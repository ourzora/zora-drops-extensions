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

    function test_onlyAdminCanSetOrDeleteTokenGate()
        public
        withDropAndTokenGatedMinter
    {
        ERC721PresetMinterPauserAutoId dummyToken = new ERC721PresetMinterPauserAutoId(
                "Dummy",
                "DUM",
                ""
            );

        vm.prank(address(0x1234));
        vm.expectRevert("TokenGatedMinter: not token admin");
        minter.setTokenGate(address(dummyToken), 0.1 ether, 2);

        vm.startPrank(DROP_OWNER);
        minter.setTokenGate(address(dummyToken), 0.1 ether, 2);
        (uint256 mintPrice, uint256 mintLimitPerToken) = minter.tokenGates(
            address(dummyToken)
        );

        assertEq(mintPrice, 0.1 ether);
        assertEq(mintLimitPerToken, 2);

        drop.grantRole(drop.DEFAULT_ADMIN_ROLE(), address(0x1234));
        vm.stopPrank();

        vm.prank(address(0x1234));
        minter.setTokenGate(address(dummyToken), 0.2 ether, 0);
        (mintPrice, mintLimitPerToken) = minter.tokenGates(address(dummyToken));
        assertEq(mintPrice, 0);
        assertEq(mintLimitPerToken, 0);
    }

    function test_mintWithGatedTokens() public withDropAndTokenGatedMinter {
        ERC721PresetMinterPauserAutoId dummyToken = new ERC721PresetMinterPauserAutoId(
                "Dummy",
                "DUM",
                ""
            );
        dummyToken.mint(address(0x1234));
        dummyToken.mint(address(0x1234));
        vm.deal(address(0x1234), 1 ether);

        vm.prank(DROP_OWNER);
        minter.setTokenGate(address(dummyToken), 0.1 ether, 2);

        uint256[] memory tokenIds = new uint256[](2);
        tokenIds[0] = 0;
        tokenIds[1] = 1;
        vm.prank(address(0x1234));
        vm.expectRevert("TokenGatedMinter: must mint at least 1");
        minter.mintWithGatedTokens(address(dummyToken), 0, tokenIds);

        uint256[] memory emptyTokenIds = new uint256[](0);
        vm.prank(address(0x1234));
        vm.expectRevert("TokenGatedMinter: must provide tokens");
        minter.mintWithGatedTokens{value: 0.1 ether}(
            address(dummyToken),
            1,
            emptyTokenIds
        );

        vm.prank(address(0x1234));
        vm.expectRevert("TokenGatedMinter: mint limit exceeded");
        minter.mintWithGatedTokens{value: 0.5 ether}(
            address(dummyToken),
            5,
            tokenIds
        );

        uint256[] memory tooManyTokenIds = new uint256[](5);
        vm.prank(address(0x1234));
        vm.expectRevert("TokenGatedMinter: too many tokens provided");
        minter.mintWithGatedTokens{value: 0.1 ether}(
            address(dummyToken),
            1,
            tooManyTokenIds
        );

        vm.prank(address(0x1234));
        vm.expectRevert("TokenGatedMinter: wrong price");
        minter.mintWithGatedTokens{value: 0.3 ether}(
            address(dummyToken),
            4,
            tokenIds
        );

        dummyToken.mint(address(0x999));
        tokenIds[1] = 2;
        vm.prank(address(0x1234));
        vm.expectRevert("TokenGatedMinter: not token owner");
        minter.mintWithGatedTokens{value: 0.4 ether}(
            address(dummyToken),
            4,
            tokenIds
        );
        tokenIds[1] = 1;

        vm.prank(address(0x1234));
        minter.mintWithGatedTokens{value: 0.4 ether}(
            address(dummyToken),
            4,
            tokenIds
        );
        assertEq(drop.balanceOf(address(0x1234)), 4);
        assertEq(address(drop).balance, 0.4 ether);

        vm.prank(address(0x1234));
        vm.expectRevert("TokenGatedMinter: token already used to mint");
        minter.mintWithGatedTokens{value: 0.4 ether}(
            address(dummyToken),
            4,
            tokenIds
        );
    }
}
