// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "forge-std/Test.sol";
import {ERC20PresetMinterPauser} from "@openzeppelin/contracts/token/ERC20/presets/ERC20PresetMinterPauser.sol";
import {ERC721PresetMinterPauserAutoId} from "@openzeppelin/contracts/token/ERC721/presets/ERC721PresetMinterPauserAutoId.sol";
import {IERC721Drop} from "zora-drops-contracts/interfaces/IERC721Drop.sol";
import {ERC721Drop} from "zora-drops-contracts/ERC721Drop.sol";
import {ERC721DropProxy} from "zora-drops-contracts/ERC721DropProxy.sol";
import {FactoryUpgradeGate} from "zora-drops-contracts/FactoryUpgradeGate.sol";
import {IZoraFeeManager} from "zora-drops-contracts/interfaces/IZoraFeeManager.sol";

import {TokenGatedMinter} from "../../src/token-gated-minter/TokenGatedMinter.sol";
import {MockRenderer} from "../utils/MockRenderer.sol";

contract TokenGatedMinterModuleTest is Test {
    using stdStorage for StdStorage;

    ERC721Drop impl;
    ERC721Drop drop;
    TokenGatedMinter minter;

    address DROP_OWNER = address(0x1);

    function setUp() public {
        impl = new ERC721Drop(
            IZoraFeeManager(address(0x0)),
            address(0x0),
            FactoryUpgradeGate(address(0x0))
        );
    }

    modifier withDropAndTokenGatedMinter() {
        MockRenderer mockRenderer = new MockRenderer();

        drop = ERC721Drop(
            payable(
                address(
                    new ERC721DropProxy(
                        address(impl),
                        abi.encodeWithSelector(
                            ERC721Drop.initialize.selector,
                            "Source NFT",
                            "SRC",
                            DROP_OWNER,
                            DROP_OWNER,
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
        minter = new TokenGatedMinter(payable(address(drop)));

        vm.startPrank(DROP_OWNER);
        drop.grantRole(drop.MINTER_ROLE(), address(minter));

        vm.stopPrank();

        _;
    }

    function test_onlyAdminCanSetTokenGate()
        public
        withDropAndTokenGatedMinter
    {
        ERC20PresetMinterPauser dummyToken = new ERC20PresetMinterPauser(
            "Dummy",
            "DUM"
        );

        vm.prank(address(0x1234));
        vm.expectRevert("TokenGatedMinter: not token admin");
        minter.setTokenGate(address(dummyToken), 100, 0.1 ether, 2);

        vm.startPrank(DROP_OWNER);
        minter.setTokenGate(address(dummyToken), 100, 0.1 ether, 2);
        (uint256 amount, uint256 mintPrice, uint256 mintLimit) = minter
            .tokenGates(address(dummyToken));

        assertEq(amount, 100);
        assertEq(mintPrice, 0.1 ether);
        assertEq(mintLimit, 2);

        drop.grantRole(drop.DEFAULT_ADMIN_ROLE(), address(0x1234));
        vm.stopPrank();

        vm.prank(address(0x1234));
        minter.setTokenGate(address(dummyToken), 101, 0.2 ether, 3);
        (amount, mintPrice, mintLimit) = minter.tokenGates(address(dummyToken));
        assertEq(amount, 101);
        assertEq(mintPrice, 0.2 ether);
        assertEq(mintLimit, 3);
    }

    function test_mintWithERC20TokenGate() public withDropAndTokenGatedMinter {
        ERC20PresetMinterPauser dummyToken = new ERC20PresetMinterPauser(
            "Dummy",
            "DUM"
        );
        dummyToken.mint(address(0x1234), 99);

        vm.prank(DROP_OWNER);
        minter.setTokenGate(address(dummyToken), 100, 0.1 ether, 2);

        vm.deal(address(0x1234), 1 ether);

        vm.prank(address(0x1234));
        vm.expectRevert("TokenGatedMinter: must mint at least 1");
        minter.mintWithAllowedToken(address(dummyToken), 0);

        vm.prank(address(0x1234));
        vm.expectRevert("TokenGatedMinter: mint limit exceeded");
        minter.mintWithAllowedToken{value: 0.3 ether}(address(dummyToken), 3);

        vm.prank(address(0x1234));
        vm.expectRevert("TokenGatedMinter: wrong price");
        minter.mintWithAllowedToken{value: 0.3 ether}(address(dummyToken), 2);

        vm.prank(address(0x1234));
        vm.expectRevert("TokenGatedMinter: token gate not met");
        minter.mintWithAllowedToken{value: 0.2 ether}(address(dummyToken), 2);

        dummyToken.mint(address(0x1234), 1);
        vm.prank(address(0x1234));
        minter.mintWithAllowedToken{value: 0.2 ether}(address(dummyToken), 2);

        assertEq(
            drop.balanceOf(address(0x1234)),
            2,
            "Should have minted 2 tokens for address(0x1234)"
        );

        vm.prank(address(0x1234));
        vm.expectRevert("TokenGatedMinter: already minted");
        minter.mintWithAllowedToken{value: 0.1 ether}(address(dummyToken), 1);
    }

    function test_mintWithERC721TokenGate() public withDropAndTokenGatedMinter {
        ERC721PresetMinterPauserAutoId dummyToken = new ERC721PresetMinterPauserAutoId(
                "Dummy",
                "DUM",
                ""
            );
        dummyToken.mint(address(0x1234));

        vm.prank(DROP_OWNER);
        minter.setTokenGate(address(dummyToken), 2, 0.1 ether, 2);

        vm.deal(address(0x1234), 1 ether);

        vm.prank(address(0x1234));
        vm.expectRevert("TokenGatedMinter: must mint at least 1");
        minter.mintWithAllowedToken(address(dummyToken), 0);

        vm.prank(address(0x1234));
        vm.expectRevert("TokenGatedMinter: mint limit exceeded");
        minter.mintWithAllowedToken{value: 0.3 ether}(address(dummyToken), 3);

        vm.prank(address(0x1234));
        vm.expectRevert("TokenGatedMinter: wrong price");
        minter.mintWithAllowedToken{value: 0.3 ether}(address(dummyToken), 2);

        vm.prank(address(0x1234));
        vm.expectRevert("TokenGatedMinter: token gate not met");
        minter.mintWithAllowedToken{value: 0.2 ether}(address(dummyToken), 2);

        dummyToken.mint(address(0x1234));
        vm.prank(address(0x1234));
        minter.mintWithAllowedToken{value: 0.2 ether}(address(dummyToken), 2);

        assertEq(
            drop.balanceOf(address(0x1234)),
            2,
            "Should have minted 2 tokens for address(0x1234)"
        );

        vm.prank(address(0x1234));
        vm.expectRevert("TokenGatedMinter: already minted");
        minter.mintWithAllowedToken{value: 0.1 ether}(address(dummyToken), 1);
    }
}
