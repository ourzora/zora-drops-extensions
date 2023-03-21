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
import {IERC721MetadataUpgradeable} from "zora-drops-contracts/../lib/openzeppelin-contracts-upgradeable/contracts/interfaces/IERC721MetadataUpgradeable.sol";
import {NFTMetadataRenderer} from "zora-drops-contracts/utils/NFTMetadataRenderer.sol";
import {MetadataRenderAdminCheck} from "zora-drops-contracts/metadata/MetadataRenderAdminCheck.sol";
import {Strings} from "@openzeppelin/contracts/utils/Strings.sol";

/// @notice DistributedGraphicsEdition for editions support with shuffled graphics for more visual interest
/// @author Iain <iain@zora.co>
contract DistributedGraphicsEdition is
    IMetadataRenderer,
    MetadataRenderAdminCheck
{
    /// @notice Storage for token edition information
    struct TokenEditionInfo {
        string description;
        string imageURIBase;
        string animationURIBase;
        uint256 numberVariations;
        bytes32 randomSeed;
    }

    /// @notice Event for updated Media URIs
    event MediaURIsUpdated(
        address indexed target,
        address sender,
        string imageURIBase,
        string animationURIBase,
        uint256 numberVariations
    );

    /// @notice Event for a new edition initialized
    /// @dev admin function indexer feedback
    event EditionInitialized(
        address indexed target,
        string description,
        string imageURIBase,
        string animationURIBase,
        uint256 numberVariations
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
    /// @param imageURIBase new image uri address
    /// @param animationURIBase new animation uri address
    /// @param numberVariations Number of variations in the metadata
    function updateMediaURIs(
        address target,
        string memory imageURIBase,
        string memory animationURIBase,
        uint256 numberVariations
    ) external requireSenderAdmin(target) {
        tokenInfos[target].imageURIBase = imageURIBase;
        tokenInfos[target].animationURIBase = animationURIBase;
        tokenInfos[target].numberVariations = numberVariations;
        emit MediaURIsUpdated({
            target: target,
            sender: msg.sender,
            imageURIBase: imageURIBase,
            animationURIBase: animationURIBase,
            numberVariations: numberVariations
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
        // data format: description, imageURI, animationURI
        (
            string memory description,
            string memory imageURIBase,
            string memory animationURIBase,
            uint256 numberVariations,
            bool assignRandomish
        ) = abi.decode(data, (string, string, string, uint256, bool));

        require(bytes(imageURIBase).length > 0, "imageURIBase is required");
        require(
            numberVariations > 0,
            "Number variations needs to be at least 1"
        );

        bytes32 randomSeed;
        if (assignRandomish) {
            randomSeed = keccak256(
                abi.encodePacked(blockhash(block.number - 1), msg.sender)
            );
        }

        tokenInfos[msg.sender] = TokenEditionInfo({
            description: description,
            imageURIBase: imageURIBase,
            animationURIBase: animationURIBase,
            numberVariations: numberVariations,
            randomSeed: randomSeed
        });

        emit EditionInitialized({
            target: msg.sender,
            description: description,
            imageURIBase: imageURIBase,
            animationURIBase: animationURIBase,
            numberVariations: numberVariations
        });
    }

    /// @notice Contract URI information getter
    /// @return contract uri (if set)
    function contractURI() external view override returns (string memory) {
        address target = msg.sender;

        string memory animationURI = tokenInfos[target].animationURIBase;
        string memory imageURI = tokenInfos[target].imageURIBase;
        if (bytes(animationURI).length > 0) {
            animationURI = string.concat(animationURI, "0");
        }
        if (bytes(imageURI).length > 0) {
            imageURI = string.concat(imageURI, "0");
        }

        (address royaltyRecipient, uint256 royaltyCharged) = IERC2981Upgradeable(
            target
        ).royaltyInfo(0, 10_000);

        return
            NFTMetadataRenderer.encodeContractURIJSON({
                name: IERC721MetadataUpgradeable(target).name(),
                description: tokenInfos[target].description,
                imageURI: imageURI,
                animationURI: animationURI,
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

        uint256 choice;
        unchecked {
            if (info.randomSeed != bytes32(0x0)) {
                choice =
                    (((uint256(info.randomSeed) / 1000) * (tokenId + 3)) %
                        info.numberVariations) +
                    1;
            } else {
                choice = (tokenId - (1 % info.numberVariations)) + 1;
            }
        }
        string memory imageURI = bytes(info.imageURIBase).length == 0
            ? ""
            : string.concat(info.imageURIBase, Strings.toString(choice));
        string memory animationURI = bytes(info.animationURIBase).length == 0
            ? ""
            : string.concat(info.animationURIBase, Strings.toString(choice));

        return
            NFTMetadataRenderer.createMetadataEdition({
                name: IERC721MetadataUpgradeable(target).name(),
                description: info.description,
                imageURI: imageURI,
                animationURI: animationURI,
                tokenOfEdition: tokenId,
                editionSize: maxSupply
            });
    }
}
