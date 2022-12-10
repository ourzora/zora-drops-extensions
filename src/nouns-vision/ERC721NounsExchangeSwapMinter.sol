// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import {SafeOwnable} from "../utils/SafeOwnable.sol";
import {IERC721} from "@openzeppelin/contracts/interfaces/IERC721.sol";
import {IERC721Drop} from "zora-drops-contracts/interfaces/IERC721Drop.sol";
import {Address} from "@openzeppelin/contracts/utils/Address.sol";

contract ERC721NounsExchangeSwapMinter is SafeOwnable {
    IERC721 internal immutable nounsToken;
    IERC721Drop internal immutable discoGlasses;
    uint256 public freeMintMaxCount;
    uint256 public costPerNoun;
    event UpdatedHoldingsIndex(uint256);
    mapping(uint256 => bool) public claimedPerNoun;

    error YouNeedtoOwnClaimedNoun();
    error YouAlreadyMinted();
    event ClaimedFromNoun(
        address indexed claimee,
        uint256 newId,
        uint256 nounId
    );
    error WrongPrice();

    constructor(
        address _nounsToken,
        address _discoGlasses,
        uint256 _freeMintMaxCount,
        uint256 _costPerNoun,
        address _initialOwner
    ) {
        // Set variables
        discoGlasses = IERC721Drop(_discoGlasses);
        nounsToken = IERC721(_nounsToken);
        freeMintMaxCount = _freeMintMaxCount;
        costPerNoun = _costPerNoun;

        // Setup ownership
        __Ownable_init(_initialOwner);
    }

    function updateDiscoIndex(uint256 _freeMintMaxCount) external onlyOwner {
        freeMintMaxCount = _freeMintMaxCount;

        emit UpdatedHoldingsIndex(_freeMintMaxCount);
    }

    function _mintWithNoun(uint256 nounId) internal {
        if (claimedPerNoun[nounId]) {
            revert YouAlreadyMinted();
        }

        claimedPerNoun[nounId] = true;

        // make an admin mint
        uint256 newId = discoGlasses.adminMint(msg.sender, 1);

        emit ClaimedFromNoun(msg.sender, newId, nounId);
    }

    function mintWithNouns(uint256[] memory nounIds) external payable {
        if (discoGlasses.saleDetails().totalMinted > freeMintMaxCount) {
            if (msg.value != nounIds.length * costPerNoun) {
                revert WrongPrice();
            }
        } else {
            if (msg.value > 0) {
                revert WrongPrice();
            }
        }
        // cost would be minted < 200 – 0 otherwise 0.2 (admin set)
        for (uint256 i = 0; i < nounIds.length; i++) {
            if (nounsToken.ownerOf(nounIds[i]) != msg.sender) {
                revert YouNeedtoOwnClaimedNoun();
            }
            _mintWithNoun(nounIds[i]);
        }
    }

    function withdraw() external onlyOwner {
        Address.sendValue(payable(owner()), address(this).balance);
    }

    function ownerMintWithNouns(uint256[] memory nounIds) external onlyOwner {
        for (uint256 i = 0; i < nounIds.length; i++) {
            _mintWithNoun(nounIds[i]);
        }
    }
}
