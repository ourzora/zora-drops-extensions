// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

/// @title MetadataRendererTypesV1
/// @author Iain Nash & Rohan Kulkarni
/// @notice The Metadata Renderer custom data types
interface INounsCoasterMetadataRendererTypes {
    struct ItemParam {
        uint256 propertyId;
        string name;
        bool isNewProperty;
    }

    struct IPFSGroup {
        string baseUri;
        string extension;
    }

    struct Property {
        string name;
        string[] items;
    }

    struct Item {
        uint8 index;
        string name;
    }

    struct Settings {
        address token;
        string projectURI;
        string description;
        string contractImage;
        string rendererBase;
    }

    struct AdditionalTokenProperty {
        string key;
        string value;
        bool quote;
    }

    struct NounsCoasterLayerData {
        IPFSGroup ipfs;
        address data;
        uint256 count;
        bool hasEqualVariants;
        string name;
    }
}
