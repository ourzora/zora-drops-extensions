// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import {Test} from "forge-std/Test.sol";

import {ERC721Drop} from "zora-drops-contracts/ERC721Drop.sol";
import {IERC721Drop} from "zora-drops-contracts/interfaces/IERC721Drop.sol";
import {ERC721DropProxy} from "zora-drops-contracts/ERC721DropProxy.sol";
import {NounsVisionExchangeMinterModule} from "../../src/nouns-vision/NounsVisionExchangeMinterModule.sol";
import {FactoryUpgradeGate} from "zora-drops-contracts/FactoryUpgradeGate.sol";
import {MockRenderer} from "../utils/MockRenderer.sol";

contract ERC721DropMinterModuleTest is Test {
    address constant OWNER_ADDRESS = address(0x123);
    ERC721Drop impl;

    function setUp() public {
        impl = new ERC721Drop(
            address(0),
            FactoryUpgradeGate(address(0)),
            address(0),
            0,
            payable(address(0))
        );
    }

    function test_SetupExchange() public {
        MockRenderer mockRenderer = new MockRenderer();
        ERC721Drop source = ERC721Drop(
            payable(
                address(
                    new ERC721DropProxy(
                        address(impl),
                        abi.encodeWithSelector(
                            ERC721Drop.initialize.selector,
                            "Source NFT",
                            "SRC",
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
        ERC721Drop sink = ERC721Drop(
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
        NounsVisionExchangeMinterModule exchangeModule = new NounsVisionExchangeMinterModule(
                source,
                sink,
                "test description"
            );
        vm.startPrank(OWNER_ADDRESS);
        // init set approval
        sink.grantRole(sink.MINTER_ROLE(), address(exchangeModule));
        NounsVisionExchangeMinterModule.ColorSetting[]
            memory settings = new NounsVisionExchangeMinterModule.ColorSetting[](
                2
            );
        settings[0].color = "Blue";
        settings[0].imageURI = "https://example.com/base/black";
        settings[0].animationURI = "https://example.com/base/black";
        settings[0].maxCount = 2;
        settings[1].color = "Red";
        settings[1].imageURI = "https://example.com/base/red";
        settings[1].animationURI = "https://example.com/base/red";
        settings[1].maxCount = 2;
        exchangeModule.setColorLimits(settings);

        address holder1 = address(0x102);
        source.adminMint(holder1, 4);

        vm.stopPrank();
        vm.startPrank(holder1);
        source.setApprovalForAll(address(exchangeModule), true);
        uint256[] memory fromIds = new uint256[](2);
        fromIds[0] = 1;
        fromIds[1] = 2;
        source.ownerOf(3);
        exchangeModule.exchange(fromIds, "Blue");
        assertEq(
            sink.tokenURI(1),
            "data:application/json;base64,eyJuYW1lIjogIlNpbmsgTkZUIEJsdWUgMS80IiwgImRlc2NyaXB0aW9uIjogInRlc3QgZGVzY3JpcHRpb24iLCAiaW1hZ2UiOiAiaHR0cHM6Ly9leGFtcGxlLmNvbS9iYXNlL2JsYWNrIiwgImFuaW1hdGlvbl91cmwiOiAiaHR0cHM6Ly9leGFtcGxlLmNvbS9iYXNlL2JsYWNrIiwgInByb3BlcnRpZXMiOiB7Im51bWJlciI6IDEsICJuYW1lIjogIlNpbmsgTkZUIEJsdWUifX0="
        );
        fromIds[0] = 3;
        fromIds[1] = 4;
        vm.expectRevert("Ran out of color");
        exchangeModule.exchange(fromIds, "Blue");
        exchangeModule.exchange(fromIds, "Red");
    }
    function test_ExchangeCorrectOwner() public {
        MockRenderer mockRenderer = new MockRenderer();
        ERC721Drop source = ERC721Drop(
            payable(
                address(
                    new ERC721DropProxy(
                        address(impl),
                        abi.encodeWithSelector(
                            ERC721Drop.initialize.selector,
                            "Source NFT",
                            "SRC",
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
        ERC721Drop sink = ERC721Drop(
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
        NounsVisionExchangeMinterModule exchangeModule = new NounsVisionExchangeMinterModule(
                source,
                sink,
                "test description"
            );
        vm.startPrank(OWNER_ADDRESS);

        // init set approval
        sink.grantRole(sink.MINTER_ROLE(), address(exchangeModule));
        NounsVisionExchangeMinterModule.ColorSetting[]
            memory settings = new NounsVisionExchangeMinterModule.ColorSetting[](
                1
            );
        settings[0].color = "Black";
        settings[0].imageURI = "https://example.com/base/black";
        settings[0].animationURI = "https://example.com/base/black";
        settings[0].maxCount = 10;
        exchangeModule.setColorLimits(settings);

        address holder1 = address(0x102);
        address user2 = address(0x103);
        source.adminMint(holder1, 4);

        vm.stopPrank();
        vm.startPrank(holder1);
        source.setApprovalForAll(address(exchangeModule), true);
        uint256[] memory fromIds = new uint256[](2);
        fromIds[0] = 1;
        fromIds[1] = 2;
        source.ownerOf(3);
        vm.stopPrank();
        vm.prank(user2);
        source.setApprovalForAll(address(exchangeModule), true);
        vm.prank(user2);
        vm.expectRevert("Not owned by sender");
        exchangeModule.exchange(fromIds, "Black");
    }
}
