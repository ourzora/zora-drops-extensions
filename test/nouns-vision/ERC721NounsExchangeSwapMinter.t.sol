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

contract ERC721NounsExchangeSwapMinterTest is Test {
    address constant OWNER_ADDRESS = address(0x123);
    ERC721Drop impl;

    function setUp() public {
        impl = new ERC721Drop(
            IZoraFeeManager(address(0x0)),
            address(0x0),
            FactoryUpgradeGate(address(0x0))
        );
    }

    function test_SetupExchange() public {
        MockRenderer mockRenderer = new MockRenderer();
        ERC721Drop nounsMock = ERC721Drop(
            payable(
                address(
                    new ERC721DropProxy(
                        address(impl),
                        abi.encodeWithSelector(
                            ERC721Drop.initialize.selector,
                            "Nouns",
                            "NOUNS",
                            OWNER_ADDRESS,
                            address(0x0),
                            10,
                            10,
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
        vm.prank(OWNER_ADDRESS);

        ERC721Drop nounTokens = ERC721Drop(
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

        ERC721Drop discoGlasses = ERC721Drop(
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
        vm.startPrank(OWNER_ADDRESS);
        discoGlasses.adminMint(OWNER_ADDRESS, 100);

        address nounHolder1 = address(0x10);
        address nounHolder2 = address(0x11);
        nounTokens.adminMint(nounHolder1, 10);
        nounTokens.adminMint(nounHolder2, 10);

        ERC721NounsExchangeSwapMinter swapModule = new ERC721NounsExchangeSwapMinter(
          address(nounTokens),
          address(discoGlasses),
          10,
          OWNER_ADDRESS
        );

        discoGlasses.setApprovalForAll(address(swapModule), true);

        // mint holder 1
        vm.stopPrank();
        vm.startPrank(nounHolder1);
        uint256[] memory nounsList = new uint256[](1);
        nounsList[0] = 1;
        swapModule.mintWithNouns(nounsList);
        vm.expectRevert(ERC721NounsExchangeSwapMinter.YouAlreadyMinted.selector);

        swapModule.mintWithNouns(nounsList);
        vm.stopPrank();

        // mint holder 2
        vm.startPrank(nounHolder2);
        uint256[] memory nounsList2 = new uint256[](2);
        nounsList2[0] = 11;
        nounsList2[1] = 12;
        swapModule.mintWithNouns(nounsList2);
        vm.stopPrank();
    }
}
