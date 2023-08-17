// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

/*
    @@@@@@@@@@@@@@@@@@@   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*              @@@@@@   
    @@@@@@@@@@@@@@@@@@  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*           @@@@@@@@@   
            @@@@@@@   @@@@@@@        @@@@@@@        @@@@@         @@@@@@@@@@@   
        @@@@@@@    @@@@@@            @@@@@@     @@@@@@@      @@@@@@@@*@@@@@   
        @@@@@@*       @@@@@              @@@@@   @@@@@@@      @@@@@@@    @@@@@   
    @@@@@@@*         @@@@@@            @@@@@@  @@@@@@     @@@@@@@@      @@@@@   
    @@@@@@*           @@@@@@@        @@@@@@@    @@@@@@@ @@@@@@@         @@@@@   
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@       @@@@@@@@@@@           @@@@@   
    *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@           @@@@@@**            @@@@@ 
 */

import {IMetadataRenderer} from "zora-drops-contracts/interfaces/IMetadataRenderer.sol";
import {IERC721Drop} from "zora-drops-contracts/interfaces/IERC721Drop.sol";
import {IERC2981Upgradeable} from "zora-drops-contracts/ERC721Drop.sol";
import {IERC721MetadataUpgradeable} from "openzeppelin-contracts-upgradeable/contracts/interfaces/IERC721MetadataUpgradeable.sol";
import {NFTMetadataRenderer} from "zora-drops-contracts/utils/NFTMetadataRenderer.sol";
import {MetadataRenderAdminCheck} from "zora-drops-contracts/metadata/MetadataRenderAdminCheck.sol";
import {Strings} from "@openzeppelin/contracts/utils/Strings.sol";

/// @notice Contract for rendering concatenated SVG metadata
/// @author Kolber <kolber@zora.co>
contract SvgConcatRenderer is
    IMetadataRenderer,
    MetadataRenderAdminCheck
{
    /// @notice Storage for token edition information
    struct TokenEditionInfo {
        string description;
        string imageURIBase;
        string imageURISuffix;
    }

    /// @notice Event for updated Media URIs
    event MediaURIsUpdated(
        address indexed target,
        address sender,
        string imageURIBase,
        string imageURISuffix
    );

    /// @notice Event for a new edition initialized
    /// @dev admin function indexer feedback
    event EditionInitialized(
        address indexed target,
        string description,
        string imageURIBase,
        string imageURISuffix
    );

    /// @notice Description updated for this edition
    /// @dev admin function indexer feedback
    event DescriptionUpdated(
        address indexed target,
        address sender,
        string newDescription
    );

    /// @notice Token information mapping storage
    mapping(address => TokenEditionInfo) public tokenInfos;

    /// @notice Update media URIs
    /// @param target target for contract to update metadata for
    /// @param imageURIBase new image uri prefix
    /// @param imageURISuffix new image uri suffix
    function updateMediaURIs(
        address target,
        string memory imageURIBase,
        string memory imageURISuffix
    ) external requireSenderAdmin(target) {
        tokenInfos[target].imageURIBase = imageURIBase;
        tokenInfos[target].imageURISuffix = imageURISuffix;
        emit MediaURIsUpdated({
            target: target,
            sender: msg.sender,
            imageURIBase: imageURIBase,
            imageURISuffix: imageURISuffix
        });
    }

    /// @notice Admin function to update description
    /// @param target target description
    /// @param newDescription new description
    function updateDescription(address target, string memory newDescription)
        external
        requireSenderAdmin(target)
    {
        tokenInfos[target].description = newDescription;

        emit DescriptionUpdated({
            target: target,
            sender: msg.sender,
            newDescription: newDescription
        });
    }

    /// @notice Default initializer for edition data from a specific contract
    /// @param data data to init with
    function initializeWithData(bytes memory data) external {
        // data format: description, imageURIBase, imageURISuffix
        (
            string memory description,
            string memory imageURIBase,
            string memory imageURISuffix
        ) = abi.decode(data, (string, string, string));

        require(bytes(imageURIBase).length > 0, "imageURIBase is required");
        require(bytes(imageURISuffix).length > 0, "imageURISuffix is required");

        tokenInfos[msg.sender] = TokenEditionInfo({
            description: description,
            imageURIBase: imageURIBase,
            imageURISuffix: imageURISuffix
        });

        emit EditionInitialized({
            target: msg.sender,
            description: description,
            imageURIBase: imageURIBase,
            imageURISuffix: imageURISuffix
        });
    }

    /// @notice Contract URI information getter
    /// @return contract uri (if set)
    function contractURI() external view override returns (string memory) {
        address target = msg.sender;

        string memory imageURI = tokenInfos[target].imageURIBase;
        string memory imageURISuffix = tokenInfos[target].imageURISuffix;
        if (bytes(imageURI).length > 0) {
            imageURI = string.concat(imageURI, "", imageURISuffix);
        }

        (address royaltyRecipient, uint256 royaltyCharged) = IERC2981Upgradeable(
            target
        ).royaltyInfo(0, 10_000);

        return
            NFTMetadataRenderer.encodeContractURIJSON({
                name: IERC721MetadataUpgradeable(target).name(),
                description: tokenInfos[target].description,
                imageURI: imageURI,
                animationURI: "",
                royaltyBPS: royaltyCharged,
                royaltyRecipient: royaltyRecipient
            });
    }

    /// @notice Token URI information getter
    /// @param tokenId to get uri for
    /// @return contract uri (if set)
    function tokenURI(uint256 tokenId)
        external
        view
        override
        returns (string memory)
    {
        address target = msg.sender;

        TokenEditionInfo memory info = tokenInfos[target];
        IERC721Drop media = IERC721Drop(target);

        uint256 maxSupply = media.saleDetails().maxSupply;

        // For open editions, set max supply to 0 for renderer to remove the edition max number
        // This will be added back on once the open edition is "finalized"
        if (maxSupply == type(uint64).max) {
            maxSupply = 0;
        }

        string memory imageURI = bytes(info.imageURIBase).length == 0
            ? ""
            : string.concat(info.imageURIBase, Strings.toString(tokenId), info.imageURISuffix);

        return
            NFTMetadataRenderer.createMetadataEdition({
                name: IERC721MetadataUpgradeable(target).name(),
                description: info.description,
                imageURI: imageURI,
                animationURI: "",
                tokenOfEdition: tokenId,
                editionSize: maxSupply
            });
    }
}

