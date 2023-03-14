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

import "forge-std/console2.sol";

/// @notice NounsCoasterMetadataRenderer
contract NounsCoasterMetadataRenderer is
    IMetadataRenderer,
    INounsCoasterMetadataRendererTypes,
    MetadataRenderAdminCheck
{
    /// @notice The metadata renderer settings
    Settings public settings;

    /// @notice The background properties chosen from upon generation
    /// [
    ///   background
    ///   title
    ///   corner tag
    ///   ride
    /// ]
    Property[] public properties;

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
    mapping(uint16 => Property[]) public nounProperties;

    ///                                                          ///
    ///                            EVENTS                        ///
    ///                                                          ///

    /// @notice Emitted when the contract image is updated
    event ContractImageUpdated(string prevImage, string newImage);

    /// @notice Emitted when the renderer base is updated
    event RendererBaseUpdated(string prevRendererBase, string newRendererBase);

    /// @notice Emitted when the collection description is updated
    event DescriptionUpdated(string prevDescription, string newDescription);

    /// @notice Emitted when the collection uri is updated
    event WebsiteURIUpdated(string lastURI, string newURI);

    ///                                                          ///
    ///                            ERRORS                        ///
    ///                                                          ///

    /// @dev Reverts if the caller isn't the token contract
    error ONLY_TOKEN();

    /// @dev Reverts if querying attributes for a token not minted
    error TOKEN_NOT_MINTED(uint256 tokenId);

    /// @dev Reverts if the founder does not include both a property and item during the initial artwork upload
    error ONE_PROPERTY_AND_ITEM_REQUIRED();

    /// @dev Reverts if an item is added for a non-existent property
    error INVALID_PROPERTY_SELECTED(uint256 selectedPropertyId);

    ///
    error TOO_MANY_PROPERTIES();

    ///
    error PREVIOUS_PROPERITIES_REQUIRED();

    constructor(
        string memory _description,
        string memory _contractImage,
        string memory _projectURI,
        string memory _rendererBase,
        address _token,
        address _owner
    ) {
        // Store the renderer settings
        settings = Settings({
            projectURI: _projectURI,
            description: _description,
            contractImage: _contractImage,
            rendererBase: _rendererBase,
            token: _token
        });
    }

    NounsCoasterLayerData[] dataLayers;

    function replaceLayerAtIndex(
        uint256 index,
        IPFSGroup memory ipfs,
        string[] memory items,
        string memory property,
        bool hasEqualVariants // if the layer has global variants use this variant here
    ) external requireSenderAdmin(address(settings.token)) {
        address newData = SSTORE2.write(abi.encode(items));
        // existing layer
        dataLayers[index] = NounsCoasterLayerData({
            data: newData,
            name: property,
            count: items.length,
            ipfs: ipfs,
            hasEqualVariants: hasEqualVariants
        });
    }

    function addLayer(
        IPFSGroup memory ipfs,
        string[] memory items,
        string memory property,
        bool hasEqualVariants
    ) external requireSenderAdmin(address(settings.token)) {
        address data = SSTORE2.write(abi.encode(items));
        console2.log(data);
        dataLayers.push(
            NounsCoasterLayerData({
                data: data,
                name: property,
                count: items.length,
                hasEqualVariants: hasEqualVariants,
                ipfs: ipfs
            })
        );
    }

    ///                                                          ///
    ///                     ATTRIBUTE GENERATION                 ///
    ///                                                          ///

    /// @notice The properties and query string for a generated token
    /// @param _tokenId The ERC-721 token id
    function getAttributes(uint256 _tokenId)
        public
        view
        returns (string memory resultAttributes, string memory queryString)
    {
        uint256 seed = uint256(keccak256(abi.encode(_tokenId)));

        // Get the token's query string
        queryString = string.concat(
            "?contractAddress=",
            Strings.toHexString(uint256(uint160(address(this))), 20),
            "&tokenId=",
            Strings.toString(_tokenId)
        );

        // Get the token's generated attributes
        MetadataBuilder.JSONItem[]
            memory arrayAttributesItems = new MetadataBuilder.JSONItem[](
                dataLayers.length
            );

        uint256 variantCount = 4;

        uint256 variantChosen = uint256(uint8(seed)) % variantCount;
        seed >>= 8;

        for (uint256 i = 0; i < dataLayers.length; ++i) {
            NounsCoasterLayerData memory layerData = dataLayers[i];

            seed >>= 8;
            uint256 thisLayer = uint256(uint16(seed));

            (string[] memory layers) = abi.decode(
                SSTORE2.read(layerData.data),
                (string[])
            );
            string memory chosenLayer;
            if (layerData.hasEqualVariants) {
                chosenLayer = layers[
                    ((thisLayer % layerData.count) / variantCount) +
                        variantChosen *
                        (layerData.count / variantCount)
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
    function _name() internal view returns (string memory) {
        return ERC721(settings.token).name();
    }

    /// @notice The contract URI
    function contractURI() external view override returns (string memory) {
        MetadataBuilder.JSONItem[]
            memory items = new MetadataBuilder.JSONItem[](4);

        items[0] = MetadataBuilder.JSONItem({
            key: MetadataJSONKeys.keyName,
            value: _name(),
            quote: true
        });
        items[1] = MetadataBuilder.JSONItem({
            key: MetadataJSONKeys.keyDescription,
            value: settings.description,
            quote: true
        });
        items[2] = MetadataBuilder.JSONItem({
            key: MetadataJSONKeys.keyImage,
            value: settings.contractImage,
            quote: true
        });
        items[3] = MetadataBuilder.JSONItem({
            key: "external_url",
            value: settings.projectURI,
            quote: true
        });

        return MetadataBuilder.generateEncodedJSON(items);
    }

    /// @notice The token URI
    /// @param _tokenId The ERC-721 token id
    function tokenURI(uint256 _tokenId) external view returns (string memory) {
        (string memory _attributes, string memory queryString) = getAttributes(
            _tokenId
        );

        MetadataBuilder.JSONItem[]
            memory items = new MetadataBuilder.JSONItem[](4);

        items[0] = MetadataBuilder.JSONItem({
            key: MetadataJSONKeys.keyName,
            value: string.concat(_name(), " #", Strings.toString(_tokenId)),
            quote: true
        });
        items[1] = MetadataBuilder.JSONItem({
            key: MetadataJSONKeys.keyDescription,
            value: settings.description,
            quote: true
        });
        items[2] = MetadataBuilder.JSONItem({
            key: MetadataJSONKeys.keyImage,
            value: string.concat(settings.rendererBase, queryString),
            quote: true
        });
        items[3] = MetadataBuilder.JSONItem({
            key: MetadataJSONKeys.keyProperties,
            value: _attributes,
            quote: false
        });

        return MetadataBuilder.generateEncodedJSON(items);
    }

    ///                                                          ///
    ///                       METADATA SETTINGS                  ///
    ///                                                          ///

    /// @notice The associated ERC-721 token
    function token() external view returns (address) {
        return settings.token;
    }

    /// @notice The contract image
    function contractImage() external view returns (string memory) {
        return settings.contractImage;
    }

    /// @notice The renderer base
    function rendererBase() external view returns (string memory) {
        return settings.rendererBase;
    }

    /// @notice The collection description
    function description() external view returns (string memory) {
        return settings.description;
    }

    /// @notice The collection description
    function projectURI() external view returns (string memory) {
        return settings.projectURI;
    }

    /// @notice Default initializer for edition data from a specific contract
    /// @param data data to init with
    function initializeWithData(bytes memory data) external {
        // noop
    }

    ///                                                          ///
    ///                       UPDATE SETTINGS                    ///
    ///                                                          ///

    /// @notice Updates the contract image
    /// @param _newContractImage The new contract image
    function updateContractImage(string memory _newContractImage)
        external
        requireSenderAdmin(address(settings.token))
    {
        emit ContractImageUpdated(settings.contractImage, _newContractImage);

        settings.contractImage = _newContractImage;
    }

    /// @notice Updates the renderer base
    /// @param _newRendererBase The new renderer base
    function updateRendererBase(string memory _newRendererBase)
        external
        requireSenderAdmin(address(settings.token))
    {
        emit RendererBaseUpdated(settings.rendererBase, _newRendererBase);

        settings.rendererBase = _newRendererBase;
    }

    /// @notice Updates the collection description
    /// @param _newDescription The new description
    function updateDescription(string memory _newDescription)
        external
        requireSenderAdmin(address(settings.token))
    {
        emit DescriptionUpdated(settings.description, _newDescription);

        settings.description = _newDescription;
    }

    function updateProjectURI(string memory _newProjectURI)
        external
        requireSenderAdmin(address(settings.token))
    {
        emit WebsiteURIUpdated(settings.projectURI, _newProjectURI);

        settings.projectURI = _newProjectURI;
    }
}
