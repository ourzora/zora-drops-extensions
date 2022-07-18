// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "forge-std/Test.sol";

import {SignatureMinter} from "../../src/signature-minter/SignatureMinter.sol";
import {ERC721Drop} from "zora-drops-contracts/ERC721Drop.sol";
import {IERC721Drop} from "zora-drops-contracts/interfaces/IERC721Drop.sol";
import {ERC721DropProxy} from "zora-drops-contracts/ERC721DropProxy.sol";
import {IZoraFeeManager} from "zora-drops-contracts/interfaces/IZoraFeeManager.sol";
import {FactoryUpgradeGate} from "zora-drops-contracts/FactoryUpgradeGate.sol";

contract MockRenderer {
    function initializeWithData(bytes memory) external {}
}

contract SignatureMinterModuleTest is Test {
    address constant OWNER_ADDRESS = address(0x420);

    uint256 internal enjoyooorPrivateKey;
    address internal enjoyooor;

    ERC721Drop impl;
    ERC721Drop drop;

    SignatureMinter minter;

    function setUp() public {
        enjoyooorPrivateKey = 0x696969;
        enjoyooor = vm.addr(enjoyooorPrivateKey);

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
                            OWNER_ADDRESS,
                            OWNER_ADDRESS,
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

        minter = new SignatureMinter();

        vm.startPrank(OWNER_ADDRESS);
        drop.grantRole(drop.MINTER_ROLE(), address(minter));
        vm.stopPrank();

        _;
    }

    function test_withWrongPrice() public withDrop("") {
        vm.startPrank(enjoyooor);

        SignatureMinter.Mint memory mint = SignatureMinter.Mint({
            target: address(drop),
            from: enjoyooor,
            totalPrice: 1 ether,
            quantity: 1,
            nonce: 0,
            deadline: 1 days
        });

        (uint8 v, bytes32 r, bytes32 s) = vm.sign(
            enjoyooorPrivateKey,
            minter.getTypedDataHash(mint)
        );

        bytes memory signature = abi.encode(v, r, s);
        // emit log_named_bytes("signature", signature);

        // FIXME: [FAIL. Reason: Call reverted as expected, but without data]
        vm.expectRevert(SignatureMinter.WrongPrice.selector);

        minter.mintWithSignature{value: 0.69 ether}(
            mint.target, // target
            enjoyooor, // signer
            enjoyooor, // to
            mint.totalPrice, // totalPrice
            mint.quantity, // quantity
            mint.nonce, // nonce
            mint.deadline, // deadline
            signature // signature
        );

        vm.stopPrank();
    }

    function test_withWrongNonce() public withDrop("") {
        uint256 nonce = 0;

        // TODO: uhhhh how do I do this?
        // vm.store maybe?()
        // minter.usedNonces[enjoyooor][nonce] = true;

        vm.startPrank(enjoyooor);

        SignatureMinter.Mint memory mint = SignatureMinter.Mint({
            target: address(drop),
            from: enjoyooor,
            totalPrice: 1 ether,
            quantity: 1,
            nonce: 0,
            deadline: 1 days
        });

        (uint8 v, bytes32 r, bytes32 s) = vm.sign(
            enjoyooorPrivateKey,
            minter.getTypedDataHash(mint)
        );

        bytes memory signature = abi.encode(v, r, s);

        // FIXME: [FAIL. Reason: Call reverted as expected, but without data]
        vm.expectRevert(SignatureMinter.UsedNonceAlready.selector);

        minter.mintWithSignature{value: mint.totalPrice}(
            mint.target, // target
            enjoyooor, // signer
            enjoyooor, // to
            mint.totalPrice, // totalPrice
            mint.quantity, // quantity
            mint.nonce, // nonce
            mint.deadline, // deadline
            signature // signature
        );

        vm.stopPrank();
    }

    function Xtest_withPassedDeadline() public withDrop("") {
        uint256 deadline = 5 days;
        vm.startPrank(enjoyooor);

        vm.warp(10 days);
        vm.expectRevert(SignatureMinter.DeadlinePassed.selector);
    }

    function Xtest_withWrongRecepient() public withDrop("") {
        vm.startPrank(enjoyooor);
        vm.expectRevert(SignatureMinter.WrongRecipient.selector);
    }

    function Xtest_withInvalidSignature() public withDrop("") {
        vm.startPrank(enjoyooor);
        vm.expectRevert(SignatureMinter.InvalidSignature.selector);
    }

    function Xtest_withUnauthorizeMinter() public withDrop("") {
        vm.startPrank(enjoyooor);
        vm.expectRevert(SignatureMinter.SignerNotAuthorized.selector);
    }

    function Xtest_withErrorTransferringFunds() public withDrop("") {
        vm.startPrank(enjoyooor);
        vm.expectRevert(SignatureMinter.ErrorTransferringFunds.selector);
    }

    function Xtest_withMintingError() public withDrop("") {
        vm.startPrank(enjoyooor);
        vm.expectRevert(SignatureMinter.MintingError.selector);
    }

    event MintedFromSignature(
        address target,
        address sender,
        uint256 quantity,
        uint256 totalPrice
    );

    function Xtest_withCorrectSignature() public withDrop("") {
        vm.startPrank(enjoyooor);

        vm.expectEmit(true, true, false, true);
        emit MintedFromSignature(address(drop), enjoyooor, 1, 1);
    }
}
