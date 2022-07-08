// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import {ERC721DropSignatureInterface} from "./ERC721DropSignatureInterface.sol";
import {SignatureChecker} from "@openzeppelin/contracts/utils/cryptography/SignatureChecker.sol";
import {EIP712} from "@openzeppelin/contracts/utils/cryptography/draft-EIP712.sol";

contract SignatureMinter is EIP712 {
    error WrongPrice();
    error UsedNonceAlready();
    error SignerNotAuthorized();
    error DeadlinePassed();
    error MintingError();
    error InvalidSignature();
    error ErrorTransferringFunds();

    event MintedFromSignature(
        address target,
        address sender,
        uint256 quantity,
        uint256 totalPrice
    );

    /// @notice Used to keep track of previously used nonces
    mapping(address => mapping(uint256 => bool)) usedNonces;

    bytes32 private immutable _MINT_TYPEHASH =
        keccak256(
            "Mint(address target,address from,uint256 totalPrice,uint256 quantity,uint256 nonce,uint256 deadline)"
        );
    bytes32 private immutable MINTER_ROLE = keccak256("MINTER");

    constructor() EIP712("SignatureMinter", "1") {

    }

    function mintWithSignature(
        address target,
        address signer,
        uint256 totalPrice,
        uint256 quantity,
        uint256 nonce,
        uint256 deadline,
        bytes calldata signature
    ) external payable {
        if (totalPrice != msg.value) {
            revert WrongPrice();
        }
        if (usedNonces[signer][nonce]) {
            revert UsedNonceAlready();
        }
        if (deadline > block.timestamp) {
            revert DeadlinePassed();
        }
        usedNonces[signer][nonce] = true;

        address from = msg.sender;

        if (
            !SignatureChecker.isValidSignatureNow(
                from,
                _hashTypedDataV4(
                    keccak256(
                        abi.encode(
                            _MINT_TYPEHASH,
                            target,
                            msg.sender,
                            totalPrice,
                            quantity,
                            nonce,
                            deadline
                        )
                    )
                ),
                signature
            )
        ) {
            revert InvalidSignature();
        }
        if (
            !ERC721DropSignatureInterface(target).isAdmin(signer) ||
            !ERC721DropSignatureInterface(target).hasRole(signer, MINTER_ROLE)
        ) {
            revert SignerNotAuthorized();
        }
        try
            ERC721DropSignatureInterface(target).adminMint(msg.sender, quantity)
        {
            if (msg.value > 0) {
                // Send value to root contract
                (bool success, ) = payable(target).call{value: msg.value}("");
                if (!success) {
                    revert ErrorTransferringFunds();
                }
            }
            // Mint NFT
            emit MintedFromSignature(target, msg.sender, quantity, totalPrice);
        } catch {
            revert MintingError();
        }
    }
}
