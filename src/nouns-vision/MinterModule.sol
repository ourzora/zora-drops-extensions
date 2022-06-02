// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

// import {ERC721DropMinterInterface} from "./ERC721DropMinterInterface.sol";
// import {ERC721OwnerInterface} from "./ERC721OwnerInterface.sol";
import {ERC721Drop} from "zora-drops-contracts/ERC721Drop.sol";
import {IMetadataRenderer} from "zora-drops-contracts/interfaces/IMetadataRenderer.sol";
import {MetadataRenderAdminCheck} from "zora-drops-contracts/metadata/MetadataRenderAdminCheck.sol";
import {SharedNFTLogic} from "zora-drops-contracts/utils/SharedNFTLogic.sol";

/// @notice Exchanges one drop for another through burn mechanism
contract ExchangeMinterModule is IMetadataRenderer, MetadataRenderAdminCheck {
    struct ColorInfo {
        uint128 claimedCount;
        uint128 maxCount;
        string baseUri;
    }

    struct ColorSetting {
        string color;
        uint128 maxCount;
        string baseUri;
    }

    event ExchangedTokens(
        address indexed sender,
        uint256 indexed resultChunk,
        uint256 targetLength,
        uint256[] fromIds
    );

    event UpdatedColor(string color, ColorSetting settings);
    event UpdatedDescription(string newDescription);

    ERC721Drop public immutable source;
    ERC721Drop public immutable sink;
    SharedNFTLogic private immutable sharedNFTLogic;

    string description;

    mapping(string => ColorInfo) internal colors;
    mapping(uint256 => string) idToColor;

    constructor(
        ERC721Drop _source,
        ERC721Drop _sink,
        SharedNFTLogic _sharedNFTLogic
    ) {
        source = _source;
        sink = _sink;
        sharedNFTLogic = _sharedNFTLogic;
    }

    uint128 public maxCount;

    function setDescription(string memory newDescription) public {
        description = newDescription;
        emit UpdatedDescription(newDescription);
    }

    function initializeWithData(bytes memory initData) external {}

    function setColorLimits(ColorSetting[] calldata colorSettings)
        external
        requireSenderAdmin(address(sink))
    {
        uint128 maxCountCache = maxCount;
        for (uint256 i = 0; i < colorSettings.length; ) {
            string memory color = colorSettings[i].color;
            require(
                colors[color].claimedCount <= colorSettings[i].maxCount,
                "Cant decrease beyond claimed"
            );
            maxCountCache -= colors[color].maxCount;
            maxCountCache += colorSettings[i].maxCount;
            colors[color].maxCount = colorSettings[i].maxCount;
            colors[color].baseUri = colorSettings[i].baseUri;

            emit UpdatedColor(color, colorSettings[i]);

            unchecked {
                ++i;
            }
        }
        maxCount = maxCountCache;
    }

    function exchange(uint256[] calldata fromIds, string memory color)
        external
    {
        require(
            source.isApprovedForAll(msg.sender, address(this)),
            "exchange module is not approved to manage tokens"
        );
        uint128 targetLength = uint128(fromIds.length);
        require(
            colors[color].claimedCount + targetLength <= colors[color].maxCount,
            "ran out of color"
        );
        colors[color].claimedCount += targetLength;

        for (uint256 i = 0; i < targetLength; ) {
            if (source.ownerOf(fromIds[i]) == msg.sender) {
                uint256 targetId = fromIds[i];
                source.burn(targetId);
            }
            uint256 resultChunk = sink.adminMint(msg.sender, targetLength);

            idToColor[resultChunk] = color;

            emit ExchangedTokens({
                sender: msg.sender,
                resultChunk: resultChunk,
                targetLength: targetLength,
                fromIds: fromIds
            });
            unchecked {
                ++i;
            }
        }
    }

    function tokenURI(uint256 tokenId) external view returns (string memory) {
        string memory color = idToColor[tokenId];
        ColorInfo storage colorInfo = colors[color];

        return
            sharedNFTLogic.createMetadataEdition({
                name: string(abi.encodePacked(sink.name(), " ", color)),
                description: description,
                imageUrl: string(abi.encodePacked(colorInfo.baseUri, "/image")),
                animationUrl: string(
                    abi.encodePacked(colorInfo.baseUri, "/animation")
                ),
                tokenOfEdition: tokenId,
                editionSize: maxCount
            });
    }

    function contractURI() external pure returns (string memory) {
        return "";
    }
}
