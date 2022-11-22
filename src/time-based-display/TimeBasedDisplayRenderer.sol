// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

/**
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

/// @notice TimeBasedDisplay for editions support with time-based graphics
/// @author Iain <iain@zora.co>
contract TimeBasedDisplayRenderer is
    IMetadataRenderer,
    MetadataRenderAdminCheck
{
    uint256 private immutable SECONDS_PER_DAY = 24 * 60 * 60;
    uint256 private immutable SECONDS_PER_HOUR = 60 * 60;
    uint256 private immutable SECONDS_PER_YEAR = 31557600;
    int256 private immutable OFFSET19700101 = 2440588;

    enum Period {
        MONTH_OF_YEAR,
        DAY_OF_YEAR,
        HOUR_OF_DAY,
        DEFAULT_FALLBACK,
        YEAR
    }

    struct DateTime {
        uint256 year;
        uint256 month;
        uint256 day;
        uint256 daysInYear;
        uint256 hour;
        uint256 secs;
    }

    error InsertingRequiresZeroIndex();
    error NoTokenURISetup();

    /// @notice Storage for token edition information
    struct TimedTokenInfo {
        string description;
        string imageURI;
        string animationURI;
        // Period specified
        Period period;
        // unix timestamp
        uint64 start;
        // unix timestamp
        uint64 end;
    }

    /// @notice Event for updated Media URIs
    event InfoUpdated(
        address indexed target,
        address indexed sender,
        TimedTokenInfo data
    );

    /// @notice Event for a new edition initialized
    /// @dev admin function indexer feedback
    event EditionInitialized(address indexed target);

    /// @notice Description updated for this edition
    /// @dev admin function indexer feedback
    event DescriptionUpdated(
        address indexed target,
        address sender,
        string newDescription
    );

    event InfoRemoved(address indexed target);

    mapping(address => TimedTokenInfo[]) internal tokenInfo;

    /// @notice Update media URIs
    function updateTiming(
        address target,
        uint256 index,
        bool insert,
        TimedTokenInfo memory newInfo
    ) external requireSenderAdmin(target) {
        if (insert && index != 0) {
            revert InsertingRequiresZeroIndex();
        }
        if (insert) {
            tokenInfo[target].push(newInfo);
        } else {
            tokenInfo[target][index] = newInfo;
        }

        emit InfoUpdated({target: target, sender: msg.sender, data: newInfo});
    }

    function removeTiming(address target, uint256 index)
        external
        requireSenderAdmin(target)
    {
        uint256 size = tokenInfo[target].length;
        TimedTokenInfo memory toSave = tokenInfo[target][size - 1];
        tokenInfo[target][index] = toSave;
        // remove last token
        tokenInfo[target].pop();
        emit InfoRemoved(msg.sender);
    }

    /// @notice Default initializer for edition data from a specific contract
    /// @param data data to init with
    function initializeWithData(bytes memory data) external {
        address target = msg.sender;
        // data format: description, imageURI, animationURI
        TimedTokenInfo[] memory tokenData = abi.decode(
            data,
            (TimedTokenInfo[])
        );

        for (uint256 i = 0; i < tokenData.length; i++) {
            tokenInfo[target].push(tokenData[i]);
        }

        emit EditionInitialized({target: target});
    }

    function getDataAt(address target, uint256 timestamp)
        public
        view
        returns (TimedTokenInfo memory)
    {
        uint256 i;
        DateTime memory dateTime = _timestampToDate(timestamp);
        for (i = 0; i < tokenInfo[target].length; i++) {

            // check if period works
            TimedTokenInfo storage item = tokenInfo[target][i];

            if (item.period == Period.DAY_OF_YEAR) {
                if (
                    item.start >= dateTime.daysInYear &&
                    item.end < dateTime.daysInYear
                ) {
                    return item;
                }
            } else if (item.period == Period.HOUR_OF_DAY) {
                if (item.start <= dateTime.hour && item.end > dateTime.hour) {
                    return item;
                }
            } else if (item.period == Period.MONTH_OF_YEAR) {
                if (item.start <= dateTime.month && item.end > dateTime.month) {
                    return item;
                }
            } else if (item.period == Period.YEAR) {
                if (item.start <= dateTime.year && item.end > dateTime.year) {
                    return item;
                }
            }
        }
        for (i = 0; i < tokenInfo[target].length; i++) {
            // find fallback
            if (tokenInfo[target][i].period == Period.DEFAULT_FALLBACK) {
                return tokenInfo[target][i];
            }
        }
        revert NoTokenURISetup();
    }

    /// @notice Contract URI information getter
    /// @return contract uri (if set)
    function contractURI() external view override returns (string memory) {
        address target = msg.sender;

        TimedTokenInfo memory tokenData = getDataAt(target, block.timestamp);

        (
            address royaltyRecipient,
            uint256 royaltyCharged
        ) = IERC2981Upgradeable(target).royaltyInfo(0, 10_000);

        return
            NFTMetadataRenderer.encodeContractURIJSON({
                name: IERC721MetadataUpgradeable(target).name(),
                description: tokenData.description,
                imageURI: tokenData.imageURI,
                animationURI: tokenData.animationURI,
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

        TimedTokenInfo memory tokenData = getDataAt(target, block.timestamp);

        uint256 maxSupply = IERC721Drop(target).saleDetails().maxSupply;

        // For open editions, set max supply to 0 for renderer to remove the edition max number
        // This will be added back on once the open edition is "finalized"
        if (maxSupply == type(uint64).max) {
            maxSupply = 0;
        }

        return
            NFTMetadataRenderer.createMetadataEdition({
                name: IERC721MetadataUpgradeable(target).name(),
                description: tokenData.description,
                imageURI: tokenData.imageURI,
                animationURI: tokenData.animationURI,
                tokenOfEdition: tokenId,
                editionSize: maxSupply
            });
    }

    // DateTime.sol
    // From :Copyright (c) 2018 The Officious BokkyPooBah / Bok Consulting Pty Ltd
    // ------------------------------------------------------------------------
    // Calculate year/month/day from the number of days since 1970/01/01 using
    // the date conversion algorithm from
    //   http://aa.usno.navy.mil/faq/docs/JD_Formula.php
    // and adding the offset 2440588 so that 1970/01/01 is day 0
    //
    // int L = days + 68569 + offset
    // int N = 4 * L / 146097
    // L = L - (146097 * N + 3) / 4
    // year = 4000 * (L + 1) / 1461001
    // L = L - 1461 * year / 4 + 31
    // month = 80 * L / 2447
    // dd = L - 2447 * month / 80
    // L = month / 11
    // month = month + 2 - 12 * L
    // year = 100 * (N - 49) + year + L
    // ------------------------------------------------------------------------
    function _timestampToDate(uint256 _tmstamp)
        internal
        pure
        returns (DateTime memory)
    {
        uint256 _days = _tmstamp / SECONDS_PER_DAY;
        int256 __days = int256(_days);

        int256 L = __days + 68569 + OFFSET19700101;
        // start of 1970
        int256 N = (4 * L) / 146097;

        L = L - (146097 * N + 3) / 4;
        int256 _year = (4000 * (L + 1)) / 1461001;
        L = L - (1461 * _year) / 4 + 31;
        int256 _month = (80 * L) / 2447;
        int256 _day = L - (2447 * _month) / 80;
        L = _month / 11;
        _month = _month + 2 - 12 * L;
        _year = 100 * (N - 49) + _year + L;

        uint256 secs = _tmstamp % SECONDS_PER_DAY;
        uint256 hour = secs / SECONDS_PER_HOUR;

        return
            DateTime({
                year: uint256(_year),
                month: uint256(_month),
                day: uint256(_day),
                daysInYear: (_tmstamp % SECONDS_PER_YEAR) / SECONDS_PER_DAY,
                hour: hour,
                secs: secs
            });
    }
}
