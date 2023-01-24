// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import {Test} from "forge-std/Test.sol";

import {ERC721Drop} from "zora-drops-contracts/ERC721Drop.sol";
import {IERC721Drop} from "zora-drops-contracts/interfaces/IERC721Drop.sol";
import {ERC721DropProxy} from "zora-drops-contracts/ERC721DropProxy.sol";
import {IZoraFeeManager} from "zora-drops-contracts/interfaces/IZoraFeeManager.sol";
import {FactoryUpgradeGate} from "zora-drops-contracts/FactoryUpgradeGate.sol";

import {ERC721NounsExchangeSwapMinter} from "../../src/nouns-vision/ERC721NounsExchangeSwapMinter.sol";
import {ISafeOwnable} from "../../src/utils/ISafeOwnable.sol";

import {MockRenderer} from "../utils/MockRenderer.sol";

contract ERC721DiscoExchangeSwapMinterTest is Test {
    address constant OWNER_ADDRESS = address(0x123);

    uint256 constant MAX_AIRDROP_QUANTITY = 5;
    uint256 constant COST_PER_NOUN = 0.1 ether;

    ERC721Drop impl;

    ERC721NounsExchangeSwapMinter swapModule;
    ERC721Drop nounTokens;
    ERC721Drop discoGlasses;
    MockRenderer mockRenderer;

    address immutable nounHolder1 = address(0x10);
    address immutable nounHolder2 = address(0x11);
    address immutable nounHolder3 = address(0x12);

    function setUp() public {
        impl = new ERC721Drop(
            IZoraFeeManager(address(0x0)),
            address(0x0),
            FactoryUpgradeGate(address(0x0))
        );

        _createSwapContracts();
        vm.deal(nounHolder1, 1 ether);
        vm.deal(nounHolder2, 1 ether);
        vm.deal(nounHolder3, 1 ether);
    }

    function _createSwapContracts() internal {
        mockRenderer = new MockRenderer();

        // Create the Noun mock contract
        nounTokens = ERC721Drop(
            payable(
                address(
                    new ERC721DropProxy(
                        address(impl),
                        abi.encodeWithSelector(
                            ERC721Drop.initialize.selector,
                            "NOUNS MOCK",
                            "NOUNS",
                            OWNER_ADDRESS,
                            address(0x0),
                            100,
                            100,
                            IERC721Drop.SalesConfiguration({
                                publicSaleStart: 0,
                                publicSaleEnd: 0,
                                presaleStart: 0,
                                presaleEnd: 0,
                                publicSalePrice: 0,
                                maxSalePurchasePerAddress: 0,
                                presaleMerkleRoot: 0x0
                            }),
                            mockRenderer,
                            ""
                        )
                    )
                )
            )
        );

        vm.label(address(nounTokens), "Nouns Tokens");

        // Create the Disco Glasses
        discoGlasses = ERC721Drop(
            payable(
                address(
                    new ERC721DropProxy(
                        address(impl),
                        abi.encodeWithSelector(
                            ERC721Drop.initialize.selector,
                            "Nouns Vision Glasses (Disco)",
                            "DISCOGLASSES",
                            OWNER_ADDRESS,
                            address(0x0),
                            10,
                            100,
                            IERC721Drop.SalesConfiguration({
                                publicSaleStart: 0,
                                publicSaleEnd: 0,
                                presaleStart: 0,
                                presaleEnd: 0,
                                publicSalePrice: 0,
                                maxSalePurchasePerAddress: 0,
                                presaleMerkleRoot: 0x0
                            }),
                            mockRenderer,
                            ""
                        )
                    )
                )
            )
        );
        vm.label(address(discoGlasses), "Disco Glasses");
        vm.startPrank(OWNER_ADDRESS);

        nounTokens.adminMint(nounHolder1, 5);
        nounTokens.adminMint(nounHolder2, 5);
        nounTokens.adminMint(nounHolder3, 5);

        swapModule = new ERC721NounsExchangeSwapMinter(
            address(nounTokens),
            address(discoGlasses),
            MAX_AIRDROP_QUANTITY,
            COST_PER_NOUN,
            OWNER_ADDRESS,
            1674633790
        );

        discoGlasses.grantRole(
            discoGlasses.DEFAULT_ADMIN_ROLE(),
            address(swapModule)
        );

        vm.stopPrank();
    }

    function test_CanMintDiscoWithNouns() public {
        vm.startPrank(nounHolder1);
        uint256[] memory nounHolder1Ids = new uint256[](1);
        nounHolder1Ids[0] = 1;

        // if the user calls mintWithDisco but qualifies for the airdrop,
        // we should revert.
        vm.expectRevert(
            ERC721NounsExchangeSwapMinter.QualifiedForAirdrop.selector
        );
        swapModule.mintDiscoWithNouns{value: 0.1 ether}(nounHolder1Ids);
        vm.stopPrank();

        vm.startPrank(nounHolder2);
        uint256[] memory nounHolder2Ids = new uint256[](2);
        nounHolder2Ids[1] = 7; // nound id 6 is owned by nounHolder2

        // if the user calls mintWithDisco but does not send enough ETH, revert.
        vm.expectRevert(ERC721NounsExchangeSwapMinter.WrongPrice.selector);
        swapModule.mintDiscoWithNouns{value: 0.1 ether}(nounHolder2Ids);

        // if the user calls mintWithDisco but does not own a noun ID provided, revert.
        nounHolder2Ids[0] = 3; // nound id 3 is owned by nounHolder1
        vm.expectRevert(
            ERC721NounsExchangeSwapMinter.YouNeedToOwnTheNoun.selector
        );
        swapModule.mintDiscoWithNouns{value: 0.2 ether}(nounHolder2Ids);

        // if the user calls mintWithDisco but owns a noun ID has not already claimed it, mint the disco glasses.
        nounHolder2Ids[0] = 6; // nound id 6 is owned by nounHolder2
        swapModule.mintDiscoWithNouns{value: 0.2 ether}(nounHolder2Ids);
        assertEq(swapModule.claimedPerNoun(6), true);
        assertEq(swapModule.claimedPerNoun(7), true);

        // if the user calls mintWithDisco but owns a noun ID provided but it has already been claimed, revert.
        vm.expectRevert(
            ERC721NounsExchangeSwapMinter.YouAlreadyMinted.selector
        );
        swapModule.mintDiscoWithNouns{value: 0.2 ether}(nounHolder2Ids);
        vm.stopPrank();

        // ====== Testing Claim Period ======
        vm.startPrank(nounHolder3);
        uint256[] memory nounHolder3IDs = new uint256[](5);
        nounHolder3IDs[0] = 11;
        nounHolder3IDs[1] = 12;
        nounHolder3IDs[2] = 13;
        nounHolder3IDs[3] = 14;
        nounHolder3IDs[4] = 15;

        // if the user calls mintWithDisco but owns a noun ID
        // that doesn't have an early enough ID, and it's before the claim period revert.
        vm.expectRevert(
            ERC721NounsExchangeSwapMinter.MustWaitUntilAfterClaimPeriod.selector
        );
        swapModule.mintDiscoWithNouns{value: 0.5 ether}(nounHolder3IDs);

        // if the user calls mintWithDisco with a noun ID thats after than the disco supply
        // and the claim period has ended, they should be able to mint.
        vm.warp(1674633790);
        swapModule.mintDiscoWithNouns{value: 0.5 ether}(nounHolder3IDs);
        assertEq(swapModule.claimedPerNoun(11), true);
        assertEq(swapModule.claimedPerNoun(12), true);
        assertEq(swapModule.claimedPerNoun(13), true);
        assertEq(swapModule.claimedPerNoun(14), true);
        assertEq(swapModule.claimedPerNoun(15), true);
        vm.stopPrank();

        vm.startPrank(nounHolder2);
        // User who belonged to the claim period should still be able to mint
        // even after the claim period has ended.
        uint256[] memory reminingIdsForNounHolder2 = new uint256[](3);
        reminingIdsForNounHolder2[0] = 8;
        reminingIdsForNounHolder2[1] = 9;
        reminingIdsForNounHolder2[2] = 10;
        swapModule.mintDiscoWithNouns{value: 0.3 ether}(
            reminingIdsForNounHolder2
        );
        assertEq(swapModule.claimedPerNoun(8), true);
        assertEq(swapModule.claimedPerNoun(9), true);
        assertEq(swapModule.claimedPerNoun(10), true);
        vm.stopPrank();

        // If a user calls mintWithDisco but the max supply has been reached, revert.
        vm.startPrank(nounHolder1);
        vm.expectRevert(IERC721Drop.Mint_SoldOut.selector);
        swapModule.mintDiscoWithNouns{value: 0.1 ether}(nounHolder1Ids);
    }

    function test_CanClaimAirdrop() public {
        _createSwapContracts();

        uint256[] memory nounsList = new uint256[](2);
        nounsList[0] = 1;
        nounsList[1] = 2;

        // if the claim period has ended, the user should not be able to claim the airdrop
        vm.warp(1674633791);
        vm.expectRevert(ERC721NounsExchangeSwapMinter.ClaimPeriodOver.selector);
        swapModule.claimAirdrop(nounsList);
        vm.warp(0);

        // If the user doesn't own the noun, they can't claim the airdrop
        vm.expectRevert(
            ERC721NounsExchangeSwapMinter.YouNeedToOwnTheNoun.selector
        );
        swapModule.claimAirdrop(nounsList);

        // If the user owns the noun, they should be able to claim the airdrop
        vm.startPrank(nounHolder1);
        swapModule.claimAirdrop(nounsList);
        assertEq(swapModule.claimedPerNoun(1), true);
        assertEq(swapModule.claimedPerNoun(2), true);
        assertEq(swapModule.claimedPerNoun(3), false);

        // If the user has already claimed the airdrop, they can't claim it again
        vm.expectRevert(
            ERC721NounsExchangeSwapMinter.YouAlreadyMinted.selector
        );
        swapModule.claimAirdrop(nounsList);
        vm.stopPrank();

        // Setup noun holder 2 and their noundIDs
        vm.startPrank(nounHolder2);
        uint256[] memory nounHolder2NounIDs = new uint256[](2);
        nounHolder2NounIDs[0] = 6;
        nounHolder2NounIDs[1] = 7;

        // if the doesn't qualify for the airdrop because their noun ID is out of the
        // airdrop range -- they shouldn't be able to claim the airdrop.
        vm.expectRevert(
            ERC721NounsExchangeSwapMinter.NotQualifiedForAirdrop.selector
        );
        swapModule.claimAirdrop(nounHolder2NounIDs);
    }

    function test_CanUpdateAirdropQuantity() public {
        vm.expectRevert(ISafeOwnable.ONLY_OWNER.selector);
        swapModule.updateAirdropQuantity(2);

        vm.prank(OWNER_ADDRESS);
        swapModule.updateAirdropQuantity(4);
    }

    // Test if the owner of the contract is able to withdraw the funds
    function test_CanWithdraw() public {
        vm.deal(address(swapModule), 2 ether);
        assertEq(address(swapModule).balance, 2 ether);

        vm.expectRevert(ISafeOwnable.ONLY_OWNER.selector);
        swapModule.withdraw();

        uint256 ownerOriginalBalance = OWNER_ADDRESS.balance;
        vm.prank(OWNER_ADDRESS);
        swapModule.withdraw();
        assertEq(OWNER_ADDRESS.balance - ownerOriginalBalance, 2 ether);
    }
}
