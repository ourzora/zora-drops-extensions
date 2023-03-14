// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

/// @title INounsCoasterMetadataRendererTypesV1
/// @author Iain Nash
/// @notice The Metadata Renderer custom data types
interface INounsCoasterMetadataRendererTypes {
    struct IPFSGroup {
        string baseUri;
        string extension;
    }

    struct Settings {
        string projectURI;
        string description;
        string contractImage;
        string rendererBase;
        uint256 variantCount;
    }

    struct AdditionalTokenProperty {
        string key;
        string value;
        bool quote;
    }

    struct VariantInfo {
        uint16 startAt;
        uint16 count;
    }
    struct NounsCoasterLayerData {
        IPFSGroup ipfs;
        uint256 count;
        address compressedDataAddress;
        uint256 decompressedSize;
        string name;
    }
    error VariantCountNotZeroOrExpected();
}
