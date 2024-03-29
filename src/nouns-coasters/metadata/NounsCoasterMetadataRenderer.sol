// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import {IMetadataRenderer} from "zora-drops-contracts/interfaces/IMetadataRenderer.sol";
import {Strings} from "@openzeppelin/contracts/utils/Strings.sol";
import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {UriEncode} from "sol-uriencode/UriEncode.sol";
import {MetadataBuilder} from "micro-onchain-metadata-utils/MetadataBuilder.sol";
import {MetadataJSONKeys} from "micro-onchain-metadata-utils/MetadataJSONKeys.sol";
import {NFTMetadataRenderer} from "zora-drops-contracts/utils/NFTMetadataRenderer.sol";
import {MetadataRenderAdminCheck} from "zora-drops-contracts/metadata/MetadataRenderAdminCheck.sol";
import {INounsCoasterMetadataRendererTypes} from "../interfaces/INounsCoasterMetadataRendererTypes.sol";
import {SSTORE2} from "../utils/SSTORE2.sol";
import {InflateLib} from "../utils/InflateLib.sol";

/****
                                                                   
 ________   _____   ____    ______                                 
/\_____  \ /\  __`\/\  _`\ /\  _  \                                
\/____//'/'\ \ \/\ \ \ \L\ \ \ \L\ \                               
     //'/'  \ \ \ \ \ \ ,  /\ \  __ \                              
    //'/'___ \ \ \_\ \ \ \\ \\ \ \/\ \                             
    /\_______\\ \_____\ \_\ \_\ \_\ \_\                            
    \/_______/ \/_____/\/_/\/ /\/_/\/_/                            
                                                                   
                                                                   
                               __                                  
                              /\ \                __               
  ___     ___              ___\ \ \___      __   /\_\    ___       
 / __`\ /' _ `\  _______  /'___\ \  _ `\  /'__`\ \/\ \ /' _ `\     
/\ \L\ \/\ \/\ \/\______\/\ \__/\ \ \ \ \/\ \L\.\_\ \ \/\ \/\ \    
\ \____/\ \_\ \_\/______/\ \____\\ \_\ \_\ \__/.\_\\ \_\ \_\ \_\   
 \/___/  \/_/\/_/         \/____/ \/_/\/_/\/__/\/_/ \/_/\/_/\/_/   
                                                                   
                                                                   
 ___                                                               
/\_ \                                                              
\//\ \      __     __  __     __   _ __    __   _ __    __   _ __  
  \ \ \   /'__`\  /\ \/\ \  /'__`\/\`'__\/'__`\/\`'__\/'__`\/\`'__\
   \_\ \_/\ \L\.\_\ \ \_\ \/\  __/\ \ \//\  __/\ \ \//\  __/\ \ \/ 
   /\____\ \__/.\_\\/`____ \ \____\\ \_\\ \____\\ \_\\ \____\\ \_\ 
   \/____/\/__/\/_/ `/___/> \/____/ \/_/ \/____/ \/_/ \/____/ \/_/ 
                       /\___/                                      
                       \/__/                    

 */

/// @notice NounsCoasterMetadataRenderer
/// @author @iainnash / @tbtstl / @0xTranqui
contract NounsCoasterMetadataRenderer is
    IMetadataRenderer,
    INounsCoasterMetadataRendererTypes,
    MetadataRenderAdminCheck
{
    /// @notice The metadata renderer settings
    mapping(address => Settings) settings;
    /// @notice Data layer storage
    mapping(address => NounsCoasterLayerData[]) dataLayers;
    /// @notice Variant mapping (optional) array
    mapping(address => VariantSettings) variantInfo;

    /// @notice Gets settings for the given target address
    function getSettings(address target)
        external
        view
        returns (Settings memory)
    {
        return settings[target];
    }

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

    error COLLECTION_UPDATE_FROZEN();

    modifier whileNotFrozen(address target) {
        if (settings[target].freezeAt > 0) {
            if (settings[target].freezeAt < block.timestamp) {
                revert COLLECTION_UPDATE_FROZEN();
            }
        }

        _;
    }

    function updateSettings(address target, Settings memory newSettings)
        external
        whileNotFrozen(target)
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

    event LayerUpdated(address indexed target, uint256 indexed index, address by);

    function replaceLayerAtIndex(
        address target,
        uint256 index,
        IPFSGroup memory ipfs,
        bytes memory compressedData,
        uint256 decompressedSize,
        uint256 count,
        string memory property,
        VariantPropertyParameters memory variantProperty
    ) external requireSenderAdmin(target) whileNotFrozen(target) {
        dataLayers[target][index] = NounsCoasterLayerData({
            name: property,
            count: count,
            ipfs: ipfs,
            decompressedSize: decompressedSize,
            compressedDataAddress: SSTORE2.write(compressedData)
        });

        emit LayerUpdated(target, index, msg.sender);

        variantInfo[target].groupsSizes[variantProperty.id] = variantProperty
            .count;
        delete variantInfo[target].byLayer[index].offsets;
        for (uint256 i = 0; i < variantProperty.offsets.length; ++i) {
            variantInfo[target].byLayer[index].offsets.push(
                variantProperty.offsets[i]
            );
        }
    }

    function addLayer(
        address target,
        IPFSGroup memory ipfs,
        bytes memory compressedData,
        uint256 decompressedSize,
        uint256 count,
        string memory property,
        VariantPropertyParameters memory variantProperty
    ) external requireSenderAdmin(target) whileNotFrozen(target) {
        uint256 added = dataLayers[target].length;
        dataLayers[target].push(
            NounsCoasterLayerData({
                name: property,
                count: count,
                ipfs: ipfs,
                decompressedSize: decompressedSize,
                compressedDataAddress: SSTORE2.write(compressedData)
            })
        );

        emit LayerUpdated(target, added, msg.sender);

        if (variantProperty.count > 0) {
            variantInfo[target].groupsSizes[
                variantProperty.id
            ] = variantProperty.count;
        }
        variantInfo[target].byLayer[added].id = variantProperty.id;
        for (uint256 i = 0; i < variantProperty.offsets.length; ++i) {
            variantInfo[target].byLayer[added].offsets.push(
                variantProperty.offsets[i]
            );
        }
    }

    function getLayerData(address target, uint256 index)
        public
        view
        returns (
            NounsCoasterLayerData memory layerData,
            VariantTokenDetails memory variantSettings,
            string[] memory layers
        )
    {
        layerData = dataLayers[target][index];
        variantSettings = variantInfo[target].byLayer[index];
        (, bytes memory decompressed) = InflateLib.puff(
            SSTORE2.read(dataLayers[target][index].compressedDataAddress),
            layerData.decompressedSize
        );
        layers = abi.decode(decompressed, (string[]));
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

        uint256 variantBaseSeed = uint256(
            keccak256(abi.encode(_tokenId, queryString))
        );


        for (uint256 i = 0; i < dataLayers[target].length; ++i) {
            (
                NounsCoasterLayerData memory layerData,
                VariantTokenDetails memory variants,
                string[] memory layers
            ) = getLayerData(target, i);

            uint256 thisLayer = uint256(
                keccak256(abi.encode(_tokenId, i, variantBaseSeed))
            );

            string memory chosenLayer;
            if (variants.offsets.length > 0 && variantInfo[target].groupsSizes[variants.id] > 0) {
                uint256 variantChoice = uint256(
                    uint8(variantBaseSeed >> (8 * variants.id))
                ) % variantInfo[target].groupsSizes[variants.id];
                VariantOffset memory chosenVariant = variants.offsets[variantChoice];
                chosenLayer = layers[
                    chosenVariant.startAt + (thisLayer % chosenVariant.count)
                ];
            } else {
                chosenLayer = layers[thisLayer % layerData.count];
            }

            arrayAttributesItems[i] = MetadataBuilder.JSONItem({
                key: layerData.name,
                value: chosenLayer,
                quote: true
            });
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
            memory items = new MetadataBuilder.JSONItem[](4);

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

        return MetadataBuilder.generateEncodedJSON(items);
    }
}
