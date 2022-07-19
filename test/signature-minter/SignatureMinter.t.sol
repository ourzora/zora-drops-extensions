// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "forge-std/Test.sol";

import {IERC721Drop} from "zora-drops-contracts/interfaces/IERC721Drop.sol";
import {ERC721Drop} from "zora-drops-contracts/ERC721Drop.sol";
import {ERC721DropProxy} from "zora-drops-contracts/ERC721DropProxy.sol";
import {FactoryUpgradeGate} from "zora-drops-contracts/FactoryUpgradeGate.sol";
import {IZoraFeeManager} from "zora-drops-contracts/interfaces/IZoraFeeManager.sol";

import {SignatureMinter} from "../../src/signature-minter/SignatureMinter.sol";
import {MockRenderer} from "../utils/MockRenderer.sol";

contract SignatureMinterModuleTest is Test {
    uint256 internal ownerPrivateKey;
    address internal owner;

    uint256 internal signerPrivateKey;
    address internal signer;

    uint256 internal collectorPrivateKey;
    address internal collector;

    ERC721Drop impl;
    ERC721Drop drop;

    SignatureMinter minter;

    function setUp() public {
        ownerPrivateKey = 0x111;
        owner = vm.addr(ownerPrivateKey);

        signerPrivateKey = 0x333;
        signer = vm.addr(signerPrivateKey);

        collectorPrivateKey = 0x888;
        collector = vm.addr(collectorPrivateKey);

        vm.deal(collector, 1 ether);

        impl = new ERC721Drop(
            IZoraFeeManager(address(0x0)),
            address(0x0),
            FactoryUpgradeGate(address(0x0))
        );
    }

    modifier withDrop(bytes memory init) {
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
                            owner,
                            owner,
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

        minter = new SignatureMinter("1");

        vm.startPrank(owner);
        drop.grantRole(drop.MINTER_ROLE(), signer);
        drop.grantRole(drop.MINTER_ROLE(), address(minter));

        vm.stopPrank();

        _;
    }

    function test_withWrongPrice() public withDrop("") {
        SignatureMinter.Mint memory mint = SignatureMinter.Mint({
            target: address(drop),
            signer: signer,
            quantity: 1,
            totalPrice: 1 ether,
            nonce: 0,
            deadline: 1 days
        });

        (uint8 v, bytes32 r, bytes32 s) = vm.sign(
            signerPrivateKey,
            minter.getTypedDataHash(mint)
        );

        bytes memory signature = abi.encodePacked(r, s, v);

        vm.startPrank(collector);

        vm.expectRevert(SignatureMinter.WrongPrice.selector);

        minter.mintWithSignature{value: 0 ether}(
            mint.target, // target
            signer, // signer
            collector, // to
            mint.quantity, // quantity
            mint.totalPrice, // totalPrice
            mint.nonce, // nonce
            mint.deadline, // deadline
            signature // signature
        );

        vm.stopPrank();
    }

    function xtest_withWrongNonce() public withDrop("") {
        uint256 nonce = 0;

        // TODO: uhhhh how do I do this?
        // vm.store maybe?()
        // minter.usedNonces[collector][nonce] = true;

        SignatureMinter.Mint memory mint = SignatureMinter.Mint({
            target: address(drop),
            signer: signer,
            quantity: 1,
            totalPrice: 0 ether,
            nonce: nonce,
            deadline: 1 days
        });

        (uint8 v, bytes32 r, bytes32 s) = vm.sign(
            signerPrivateKey,
            minter.getTypedDataHash(mint)
        );

        bytes memory signature = abi.encodePacked(r, s, v);

        vm.startPrank(collector);

        vm.expectRevert(SignatureMinter.UsedNonceAlready.selector);

        minter.mintWithSignature{value: mint.totalPrice}(
            mint.target, // target
            signer, // signer
            collector, // to
            mint.quantity, // quantity
            mint.totalPrice, // totalPrice
            mint.nonce, // nonce
            mint.deadline, // deadline
            signature // signature
        );

        vm.stopPrank();
    }

    function test_withPassedDeadline() public withDrop("") {
        SignatureMinter.Mint memory mint = SignatureMinter.Mint({
            target: address(drop),
            signer: signer,
            quantity: 1,
            totalPrice: 0 ether,
            nonce: 0,
            deadline: 1 days
        });

        (uint8 v, bytes32 r, bytes32 s) = vm.sign(
            signerPrivateKey,
            minter.getTypedDataHash(mint)
        );

        bytes memory signature = abi.encodePacked(r, s, v);

        vm.warp(1 days + 1 seconds);

        vm.startPrank(collector);

        vm.expectRevert(SignatureMinter.DeadlinePassed.selector);

        minter.mintWithSignature{value: mint.totalPrice}(
            mint.target, // target
            signer, // signer
            collector, // to
            mint.quantity, // quantity
            mint.totalPrice, // totalPrice
            mint.nonce, // nonce
            mint.deadline, // deadline
            signature // signature
        );

        vm.stopPrank();
    }

    function test_withWrongRecipient() public withDrop("") {
        address rando = address(0x999);

        SignatureMinter.Mint memory mint = SignatureMinter.Mint({
            target: address(drop),
            signer: signer,
            quantity: 1,
            totalPrice: 0 ether,
            nonce: 0,
            deadline: 1 days
        });

        (uint8 v, bytes32 r, bytes32 s) = vm.sign(
            signerPrivateKey,
            minter.getTypedDataHash(mint)
        );

        bytes memory signature = abi.encodePacked(r, s, v);

        vm.startPrank(collector);

        vm.expectRevert(SignatureMinter.WrongRecipient.selector);

        minter.mintWithSignature{value: mint.totalPrice}(
            mint.target, // target
            signer, // signer
            rando, // to
            mint.quantity, // quantity
            mint.totalPrice, // totalPrice
            mint.nonce, // nonce
            mint.deadline, // deadline
            signature // signature
        );

        vm.stopPrank();
    }

    function test_withInvalidSignature() public withDrop("") {
        SignatureMinter.Mint memory mint = SignatureMinter.Mint({
            target: address(drop),
            signer: signer,
            quantity: 1,
            totalPrice: 0 ether,
            nonce: 0,
            deadline: 1 days
        });

        // test with a garbage private key
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(
            0x4234234234,
            minter.getTypedDataHash(mint)
        );

        bytes memory signature = abi.encodePacked(r, s, v);

        vm.startPrank(collector);

        vm.expectRevert(SignatureMinter.InvalidSignature.selector);

        minter.mintWithSignature{value: mint.totalPrice}(
            mint.target, // target
            signer, // signer
            collector, // to
            mint.quantity, // quantity
            mint.totalPrice, // totalPrice
            mint.nonce, // nonce
            mint.deadline, // deadline
            signature // signature
        );

        // params that don't match a valid signature

        (v, r, s) = vm.sign(signerPrivateKey, minter.getTypedDataHash(mint));

        signature = abi.encodePacked(r, s, v);

        vm.expectRevert(SignatureMinter.InvalidSignature.selector);

        minter.mintWithSignature{value: mint.totalPrice}(
            mint.target, // target
            signer, // signer
            collector, // to
            100, // quantity
            mint.totalPrice, // totalPrice
            mint.nonce, // nonce
            mint.deadline, // deadline
            signature // signature
        );

        vm.stopPrank();
    }

    function test_withUnauthorizedMinter() public withDrop("") {
        vm.startPrank(owner);
        drop.revokeRole(drop.MINTER_ROLE(), signer);
        vm.stopPrank();

        SignatureMinter.Mint memory mint = SignatureMinter.Mint({
            target: address(drop),
            signer: signer,
            quantity: 1,
            totalPrice: 0 ether,
            nonce: 0,
            deadline: 1 days
        });

        (uint8 v, bytes32 r, bytes32 s) = vm.sign(
            signerPrivateKey,
            minter.getTypedDataHash(mint)
        );

        bytes memory signature = abi.encodePacked(r, s, v);

        vm.startPrank(collector);

        vm.expectRevert(SignatureMinter.SignerNotAuthorized.selector);

        minter.mintWithSignature{value: 0 ether}(
            mint.target, // target
            signer, // signer
            collector, // to
            mint.quantity, // quantity
            mint.totalPrice, // totalPrice
            mint.nonce, // nonce
            mint.deadline, // deadline
            signature // signature
        );

        vm.stopPrank();
    }

    function Xtest_withErrorTransferringFunds() public withDrop("") {
        vm.startPrank(collector);
        vm.expectRevert(SignatureMinter.ErrorTransferringFunds.selector);
    }

    function Xtest_withMintingError() public withDrop("") {
        vm.startPrank(collector);
        vm.expectRevert(SignatureMinter.MintingError.selector);
    }

    event MintedFromSignature(
        address target,
        address signer,
        address to,
        uint256 quantity,
        uint256 totalPrice
    );

    function test_withCorrectSignature(uint256 quantity, uint256 totalPrice)
        public
        withDrop("")
    {
        quantity = bound(quantity, 1, 10);
        vm.assume(totalPrice < collector.balance);

        SignatureMinter.Mint memory mint = SignatureMinter.Mint({
            target: address(drop),
            signer: signer,
            quantity: quantity,
            totalPrice: totalPrice,
            nonce: 0,
            deadline: 1 days
        });

        (uint8 v, bytes32 r, bytes32 s) = vm.sign(
            signerPrivateKey,
            minter.getTypedDataHash(mint)
        );

        emit log_named_uint("current balance", collector.balance);
        bytes memory signature = abi.encodePacked(r, s, v);

        vm.startPrank(collector);

        vm.expectEmit(true, true, false, true);
        emit MintedFromSignature(
            address(drop),
            signer,
            collector,
            quantity,
            totalPrice
        );

        uint256 preBalanceMinter = address(minter).balance;
        uint256 preBalanceDrop = address(drop).balance;

        minter.mintWithSignature{value: totalPrice}(
            mint.target, // target
            signer, // signer
            collector, // to
            mint.quantity, // quantity
            mint.totalPrice, // totalPrice
            mint.nonce, // nonce
            mint.deadline, // deadline
            signature // signature
        );

        uint256 postBalanceMinter = address(minter).balance;
        uint256 postBalanceDrop = address(drop).balance;

        assertEq(preBalanceMinter, postBalanceMinter);
        assertEq(preBalanceDrop + totalPrice, postBalanceDrop);

        vm.stopPrank();
    }

    function test_transfersFunds() public withDrop("") {
        // this might be a good use of fuzz testing
        // should increment the balance of the root contract
    }
}
