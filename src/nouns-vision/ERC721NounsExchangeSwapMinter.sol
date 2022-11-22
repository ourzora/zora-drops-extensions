// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import {SafeOwnable} from "../utils/SafeOwnable.sol";
import {IERC721} from "@openzeppelin/contracts/interfaces/IERC721.sol";

contract ERC721NounsExchangeSwapMinter is SafeOwnable {
    IERC721 internal immutable nounsToken;
    IERC721 internal immutable discoGlasses;
    uint256 internal discoHoldingsIndex;
    event UpdatedHoldingsIndex(uint256);
    mapping(uint256 => bool) public claimedPerNoun;

    constructor(
        address _nounsToken,
        address _discoGlasses,
        uint256 _discoHoldingsIndex,
        address initialOwner
    ) {
        // Set variables
        discoGlasses = IERC721(_discoGlasses);
        nounsToken = IERC721(_nounsToken);
        discoHoldingsIndex = _discoHoldingsIndex;

        // Setup ownership
        __Ownable_init(initialOwner);
    }

    function updateDiscoIndex(uint256 newDiscoHoldingsIndex) external {
        discoHoldingsIndex = newDiscoHoldingsIndex;
        emit UpdatedHoldingsIndex(discoHoldingsIndex);
    }

    error OnlyNounBelowID500();
    error YouNeedtoOwnClaimedNoun();
    error YouAlreadyMinted();
    event ClaimedFromNoun(
        address indexed claimee,
        uint256 newId,
        uint256 nounId
    );

    function mintWithNoun(uint256 nounId) public {
        if (nounId > 500) {
            revert OnlyNounBelowID500();
        }

        if (nounsToken.ownerOf(nounId) != msg.sender) {
            revert YouNeedtoOwnClaimedNoun();
        }

        if (claimedPerNoun[nounId]) {
            revert YouAlreadyMinted();
        }

        claimedPerNoun[nounId] = true;

        uint256 newId = discoHoldingsIndex++;

        discoGlasses.transferFrom(
            discoGlasses.ownerOf(newId),
            msg.sender,
            newId
        );

        emit ClaimedFromNoun(msg.sender, newId, nounId);
    }

    function mintWithNouns(uint256[] memory nounIds) external {
        for (uint256 i = 0; i < nounIds.length; i++) {
            mintWithNoun(nounIds[i]);
        }
    }
}
