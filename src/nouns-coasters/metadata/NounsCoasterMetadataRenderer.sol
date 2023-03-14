// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import {IMetadataRenderer} from "zora-drops-contracts/interfaces/IMetadataRenderer.sol";
import {IERC721Drop} from "zora-drops-contracts/interfaces/IERC721Drop.sol";
import {IERC721MetadataUpgradeable} from "@openzeppelin/contracts-upgradeable/interfaces/IERC721MetadataUpgradeable.sol";
import {IERC2981Upgradeable} from "@openzeppelin/contracts-upgradeable/interfaces/IERC2981Upgradeable.sol";
import {Strings} from "@openzeppelin/contracts/utils/Strings.sol";
import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {UriEncode} from "sol-uriencode/UriEncode.sol";
import {MetadataBuilder} from "micro-onchain-metadata-utils/MetadataBuilder.sol";
import {MetadataJSONKeys} from "micro-onchain-metadata-utils/MetadataJSONKeys.sol";
import {NFTMetadataRenderer} from "zora-drops-contracts/utils/NFTMetadataRenderer.sol";
import {MetadataRenderAdminCheck} from "zora-drops-contracts/metadata/MetadataRenderAdminCheck.sol";
import {INounsCoasterMetadataRendererTypes} from "../interfaces/INounsCoasterMetadataRendererTypes.sol";
import {SSTORE2} from "../utils/SSTORE2.sol";

/// @notice NounsCoasterMetadataRenderer
/// @author @tsbsl / @0xTranqui / @iainnash
contract NounsCoasterMetadataRenderer is
    IMetadataRenderer,
    INounsCoasterMetadataRendererTypes,
    MetadataRenderAdminCheck
{
    /// @notice The metadata renderer settings
    mapping(address => Settings) public settings;

    mapping(address => NounsCoasterLayerData[]) dataLayers;
    mapping(address => mapping(uint256 => VariantInfo[])) variantInfo;

    function getSettings(address target)
        external
        view
        returns (Settings memory)
    {
        return settings[target];
    }

    /// @notice The background properties chosen from upon generation
    /// [
    ///   background
    ///   title
    ///   corner tag
    ///   ride
    /// ]
    // Property[] public properties;

    /// @notice the variant dependent properties for nouns
    /// [
    ///   0: body variant 1
    ///   1: body variant 2
    ///   2: body variant 3
    ///   3: body variant 4
    ///   4: accessories variant 1
    ///   5: accessories variant 2
    ///   6: accessories variant 3
    ///   7: accessories variant 4
    ///   8: head
    ///   9: expression
    ///   10: glasses
    /// ]
    // mapping(uint16 => Property[]) public nounProperties;

    ///                                                          ///
    ///                            EVENTS                        ///
    ///                                                          ///

    /// @notice Emitted when settings are updated
    event SettingsUpdated(address indexed target, Settings);

    ///                                                          ///
    ///                            ERRORS                        ///
    ///                                                          ///

    /// @dev Reverts if the caller isn't the token contract
    error ONLY_TOKEN();

    /// @dev Reverts if querying attributes for a token not minted
    error TOKEN_NOT_MINTED(uint256 tokenId);

    function updateSettings(address target, Settings memory newSettings)
        external
        requireSenderAdmin(target)
    {
        _updateSettings(target, newSettings);
    }

    function _updateSettings(address target, Settings memory newSettings)
        internal
    {
        settings[target] = newSettings;
        emit SettingsUpdated(target, newSettings);
    }

    /// @notice Default initializer for edition data from a specific contract
    /// @param data data to init with
    function initializeWithData(bytes memory data) external {
        if (data.length > 0) {
            _updateSettings(msg.sender, abi.decode(data, (Settings)));
        }
    }

    function replaceLayerAtIndex(
        address target,
        uint256 index,
        IPFSGroup memory ipfs,
        string[] memory items,
        string memory property,
        VariantInfo[] memory variants
    ) external requireSenderAdmin(target) {
        if (
            variants.length > 0 &&
            variants.length != settings[target].variantCount
        ) {
            revert VariantCountNotZeroOrExpected();
        }
        NounsCoasterLayerData memory layerData;
        dataLayers[target][index] = NounsCoasterLayerData({
            name: property,
            count: items.length,
            data: SSTORE2.write(abi.encode(items)),
            ipfs: ipfs
        });
        delete variantInfo[target][index];
        for (uint256 i = 0; i < variants.length; ++i) {
            variantInfo[target][index].push(variants[i]);
        }
    }

    function addLayer(
        address target,
        IPFSGroup memory ipfs,
        string[] memory items,
        string memory property,
        VariantInfo[] memory variants
    ) external requireSenderAdmin(target) {
        uint256 added = dataLayers[target].length;
        dataLayers[target].push(
            NounsCoasterLayerData({
                name: property,
                count: items.length,
                ipfs: ipfs,
                data: SSTORE2.write(abi.encode(items))
            })
        );
        for (uint256 i = 0; i < variants.length; ++i) {
            variantInfo[target][added].push(variants[i]);
        }
    }

    function getLayerData(address target, uint256 index)
        external
        view
        returns (
            NounsCoasterLayerData memory layerData,
            VariantInfo[] memory variants,
            string[] memory layers
        )
    {
        layerData = dataLayers[target][index];
        variants = variantInfo[target][index];
        layers = abi.decode(
            SSTORE2.read(dataLayers[target][index].data),
            (string[])
        );
    }

    ///                                                          ///
    ///                     ATTRIBUTE GENERATION                 ///
    ///                                                          ///

    /// @notice The properties and query string for a generated token
    /// @param _tokenId The ERC-721 token id
    function getAttributes(address target, uint256 _tokenId)
        public
        view
        returns (string memory resultAttributes, string memory queryString)
    {
        uint256 seed = uint256(keccak256(abi.encode(_tokenId)));

        // Get the token's query string
        queryString = string.concat(
            "?contractAddress=",
            Strings.toHexString(uint256(uint160(target)), 20),
            "&tokenId=",
            Strings.toString(_tokenId)
        );

        // Get the token's generated attributes
        MetadataBuilder.JSONItem[]
            memory arrayAttributesItems = new MetadataBuilder.JSONItem[](
                dataLayers[target].length
            );

        uint256 variantChosen = uint256(uint8(seed)) %
            settings[target].variantCount;
        seed >>= 8;

        for (uint256 i = 0; i < dataLayers[target].length; ++i) {
            NounsCoasterLayerData memory layerData = dataLayers[target][i];
            string[] memory layers = abi.decode(
                SSTORE2.read(layerData.data),
                (string[])
            );

            uint256 thisLayer = uint256(uint16(seed));
            unchecked {
                seed >>= 8;
                seed *= thisLayer;
            }

            string memory chosenLayer;
            if (variantInfo[target][i].length > 0) {
                VariantInfo memory chosenVariant = variantInfo[target][i][
                    variantChosen
                ];
                chosenLayer = layers[
                    chosenVariant.startAt + (thisLayer % chosenVariant.count)
                ];
            } else {
                chosenLayer = layers[thisLayer % layerData.count];
            }

            MetadataBuilder.JSONItem memory itemJSON = arrayAttributesItems[i];
            itemJSON.key = layerData.name;
            itemJSON.value = chosenLayer;
            itemJSON.quote = true;
            queryString = string.concat(
                queryString,
                "&images=",
                _getItemImage(layerData.ipfs, layerData.name, chosenLayer)
            );
        }
        resultAttributes = MetadataBuilder.generateJSON(arrayAttributesItems);
    }

    /// @dev Encodes the reference URI of an item
    function _getItemImage(
        IPFSGroup memory group,
        string memory _propertyName,
        string memory _itemName
    ) private pure returns (string memory) {
        return
            UriEncode.uriEncode(
                string(
                    abi.encodePacked(
                        group.baseUri,
                        _propertyName,
                        "/",
                        _itemName,
                        group.extension
                    )
                )
            );
    }

    ///                                                          ///
    ///                            URIs                          ///
    ///                                                          ///

    /// @notice Internal getter function for token name
    function _name(address target) internal view returns (string memory) {
        return ERC721(target).name();
    }

    /// @notice The contract URI
    function contractURI() external view override returns (string memory) {
        address target = msg.sender;

        MetadataBuilder.JSONItem[]
            memory items = new MetadataBuilder.JSONItem[](4);

        items[0] = MetadataBuilder.JSONItem({
            key: MetadataJSONKeys.keyName,
            value: _name(target),
            quote: true
        });
        items[1] = MetadataBuilder.JSONItem({
            key: MetadataJSONKeys.keyDescription,
            value: settings[target].description,
            quote: true
        });
        items[2] = MetadataBuilder.JSONItem({
            key: MetadataJSONKeys.keyImage,
            value: settings[target].contractImage,
            quote: true
        });
        items[3] = MetadataBuilder.JSONItem({
            key: "external_url",
            value: settings[target].projectURI,
            quote: true
        });

        return MetadataBuilder.generateEncodedJSON(items);
    }

    /// @notice The token URI
    /// @param _tokenId The ERC-721 token id
    function tokenURI(uint256 _tokenId) external view returns (string memory) {
        address target = msg.sender;
        (string memory _attributes, string memory queryString) = getAttributes(
            target,
            _tokenId
        );

        MetadataBuilder.JSONItem[]
            memory items = new MetadataBuilder.JSONItem[](5);

        items[0] = MetadataBuilder.JSONItem({
            key: MetadataJSONKeys.keyName,
            value: string.concat(
                _name(target),
                " #",
                Strings.toString(_tokenId)
            ),
            quote: true
        });
        items[1] = MetadataBuilder.JSONItem({
            key: MetadataJSONKeys.keyDescription,
            value: settings[target].description,
            quote: true
        });
        items[2] = MetadataBuilder.JSONItem({
            key: MetadataJSONKeys.keyImage,
            value: string.concat(settings[target].rendererBase, queryString),
            quote: true
        });
        items[3] = MetadataBuilder.JSONItem({
            key: MetadataJSONKeys.keyProperties,
            value: _attributes,
            quote: false
        });
        items[4] = MetadataBuilder.JSONItem({
            key: "external_url",
            value: settings[target].projectURI,
            quote: true
        });

        return MetadataBuilder.generateEncodedJSON(items);
    }
}
