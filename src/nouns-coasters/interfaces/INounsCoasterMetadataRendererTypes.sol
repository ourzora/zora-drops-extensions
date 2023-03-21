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
        /// @notice freezes updates – set to 0 to not freeze
        uint256 freezeAt;
    }

    struct AdditionalTokenProperty {
        string key;
        string value;
        bool quote;
    }

    /// @notice VariantOffset list of offsets to use when indexing the variants 
    struct VariantOffset {
        uint16 startAt;
        uint16 count;
    }
    
    /// @notice Nouns Coaster Layer data
    struct NounsCoasterLayerData {
        IPFSGroup ipfs;
        uint256 count;
        address compressedDataAddress;
        uint256 decompressedSize;
        string name;
    }

    /// @notice Nested variant group offset info
    struct VariantGroupInfo {
        uint8 count;
        uint8 id;
    }

    /// @notice Variant Token Details list of offsets and ids, used in storage
    struct VariantTokenDetails {
        VariantOffset[] offsets;
        uint16 id;
    }

    /// @notice VariantPropertyParameters used to pass in and setup the variant
    struct VariantPropertyParameters {
        VariantOffset[] offsets;
        uint8 id;
        uint8 count;
    }

    /// @notice VariantSettings settings list used for storage
    struct VariantSettings {
        mapping(uint256 => VariantTokenDetails) byLayer;
        uint8[32] groupsSizes;
    }

    /// @notice Error response for variant count
    error VariantCountNotZeroOrExpected();
}
