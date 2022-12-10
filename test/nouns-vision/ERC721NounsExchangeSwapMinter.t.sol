// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import {Test} from "forge-std/Test.sol";

import {ERC721Drop} from "zora-drops-contracts/ERC721Drop.sol";
import {IERC721Drop} from "zora-drops-contracts/interfaces/IERC721Drop.sol";
import {ERC721DropProxy} from "zora-drops-contracts/ERC721DropProxy.sol";
import {ERC721NounsExchangeSwapMinter} from "../../src/nouns-vision/ERC721NounsExchangeSwapMinter.sol";
import {IZoraFeeManager} from "zora-drops-contracts/interfaces/IZoraFeeManager.sol";
import {FactoryUpgradeGate} from "zora-drops-contracts/FactoryUpgradeGate.sol";
import {MockRenderer} from "../utils/MockRenderer.sol";
import {ISafeOwnable} from "../../src/utils/ISafeOwnable.sol";

contract ERC721NounsExchangeSwapMinterTest is Test {
    address constant OWNER_ADDRESS = address(0x123);
    ERC721Drop impl;

    ERC721NounsExchangeSwapMinter swapModule;
    ERC721Drop nounTokens;
    ERC721Drop discoGlasses;
    MockRenderer mockRenderer;

    address immutable nounHolder1 = address(0x10);
    address immutable nounHolder2 = address(0x11);

    function setUp() public {
        impl = new ERC721Drop(
            IZoraFeeManager(address(0x0)),
            address(0x0),
            FactoryUpgradeGate(address(0x0))
        );
    }

    function createSwapContracts() internal {
        mockRenderer = new MockRenderer();

        nounTokens = ERC721Drop(
            payable(
                address(
                    new ERC721DropProxy(
                        address(impl),
                        abi.encodeWithSelector(
                            ERC721Drop.initialize.selector,
                            "Redeemed",
                            "RDMED",
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
        vm.label(address(nounTokens), "Noun Tokens");

        discoGlasses = ERC721Drop(
            payable(
                address(
                    new ERC721DropProxy(
                        address(impl),
                        abi.encodeWithSelector(
                            ERC721Drop.initialize.selector,
                            "Sink NFT",
                            "SNK",
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
        vm.label(address(discoGlasses), "Disco Glasses");
        vm.startPrank(OWNER_ADDRESS);
        nounTokens.adminMint(nounHolder1, 10);
        nounTokens.adminMint(nounHolder2, 10);

        swapModule = new ERC721NounsExchangeSwapMinter(
            address(nounTokens),
            address(discoGlasses),
            1,
            0.1 ether,
            OWNER_ADDRESS
        );

        discoGlasses.grantRole(discoGlasses.DEFAULT_ADMIN_ROLE(), address(swapModule));

        vm.stopPrank();
    }

    function test_SetupExchange() public {
        createSwapContracts();

        // mint holder 1
        vm.stopPrank();
        vm.startPrank(nounHolder1);
        vm.deal(nounHolder1, 1 ether);
        uint256[] memory nounsList = new uint256[](1);
        nounsList[0] = 1;
        swapModule.mintWithNouns{value: 0}(nounsList);
        vm.expectRevert(
            ERC721NounsExchangeSwapMinter.YouAlreadyMinted.selector
        );
        swapModule.mintWithNouns{value: 0.1 ether}(nounsList);
        vm.stopPrank();

        // mint holder 2
        vm.startPrank(nounHolder2);
        uint256[] memory nounsList2 = new uint256[](2);
        vm.deal(nounHolder2, 1 ether);
        nounsList2[0] = 11;
        nounsList2[1] = 12;
        swapModule.mintWithNouns{value: 0.2 ether}(nounsList2);
        vm.stopPrank();
    }

    function test_MintAdminSwap() public {
        createSwapContracts();

        uint256[] memory nounsList = new uint256[](1);
        // admin mint
        nounsList[0] = 10;
        vm.expectRevert(ISafeOwnable.ONLY_OWNER.selector);
        swapModule.ownerMintWithNouns(nounsList);
        vm.prank(OWNER_ADDRESS);
        swapModule.ownerMintWithNouns(nounsList);
    }

    function test_CanUpdateDiscoIndex() public {
        createSwapContracts();

        vm.expectRevert(ISafeOwnable.ONLY_OWNER.selector);
        swapModule.updateDiscoIndex(2);

        vm.prank(OWNER_ADDRESS);
        swapModule.updateDiscoIndex(4);
    }

    function test_CanWithdraw() public {
        createSwapContracts();

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
