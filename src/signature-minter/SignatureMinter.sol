// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import {ERC721DropSignatureInterface} from "./ERC721DropSignatureInterface.sol";
import {SignatureChecker} from "@openzeppelin/contracts/utils/cryptography/SignatureChecker.sol";
import {EIP712} from "@openzeppelin/contracts/utils/cryptography/draft-EIP712.sol";

/**
 * @title SignatureMinterModule
 * @notice Mint via signatures on IERC721Drop.adminMint
 * @notice WIP, not audited!
 *
 * @author Iain <iain@zora.co>
 * @author Jem <jem@zora.co>
 *
 * @dev can be used by any contract
 * @dev grant signers (not this contract!) ERC721Drop.MINTER_ROLE()
 * @dev
 *
 */
contract SignatureMinter is EIP712 {
    error WrongPrice();
    error UsedNonceAlready();
    error SignerNotAuthorized();
    error DeadlinePassed();
    error MintingError();
    error InvalidSignature();
    error ErrorTransferringFunds();
    error WrongRecipient();

    /// @notice hell yeah, it worked lfg!!!
    /// @dev Emitted upon a successful mint
    /// @param target implements IERC721Drop.adminMint
    /// @param signer signature-signer, e.g. your API server
    /// @param to     receiver of the token
    /// @param quantity number of NFTs to mint
    /// @param totalPrice total cost of minting to sender
    event MintedFromSignature(
        address target,
        address signer,
        address to,
        uint256 quantity,
        uint256 totalPrice
    );

    /// @notice Used to keep track of previously used nonces
    mapping(address => mapping(uint256 => bool)) usedNonces;

    struct Mint {
        address target;
        address from;
        uint256 totalPrice;
        uint256 quantity;
        uint256 nonce;
        uint256 deadline;
    }

    bytes32 private immutable _MINT_TYPEHASH =
        keccak256(
            "Mint(address target,address from,uint256 totalPrice,uint256 quantity,uint256 nonce,uint256 deadline)"
        );

    bytes32 private immutable MINTER_ROLE = keccak256("MINTER");

    constructor() EIP712("SignatureMinter", "1") {}

    /// @notice AdminMints on an ERC721Drop
    /// @dev totalPrice is independent of prices set in IERC721.SaleDetails
    /// @dev signer is e.g. your API server
    ///
    /// @param target implements IERC721Drop.adminMint
    /// @param signer signature-signer, e.g. your API server
    /// @param to     receiver of the token
    /// @param totalPrice total cost of minting to sender
    /// @param quantity number of NFTs to mint
    /// @param nonce scoped to the signer
    /// @param deadline signature expiry date (seconds since UNIX epoch)
    /// @param signature the signature!
    function mintWithSignature(
        address target,
        address signer,
        address to,
        uint256 quantity,
        uint256 totalPrice,
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
        if (block.timestamp > deadline) {
            revert DeadlinePassed();
        }
        usedNonces[signer][nonce] = true;
        if (to != address(0) && to != msg.sender) {
            revert WrongRecipient();
        }
        if (
            !SignatureChecker.isValidSignatureNow(
                signer,
                _hashTypedDataV4(
                    keccak256(
                        abi.encode(
                            _MINT_TYPEHASH,
                            target,
                            signer,
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
            !ERC721DropSignatureInterface(target).hasRole(signer, MINTER_ROLE)
        ) {
            revert SignerNotAuthorized();
        }
        try ERC721DropSignatureInterface(target).adminMint(to, quantity) {
            // metadata.setHashForToken(tokenId);
            if (msg.value > 0) {
                // Send value to root contract
                (bool success, ) = payable(target).call{value: msg.value}("");
                if (!success) {
                    revert ErrorTransferringFunds();
                }
            }
            // Mint NFT
            emit MintedFromSignature(target, signer, to, quantity, totalPrice);
        } catch {
            revert MintingError();
        }
    }

    // TODO: I think we need the next two functions?
    function getMintHash(Mint memory _mint) internal view returns (bytes32) {
        return
            keccak256(
                abi.encode(
                    _MINT_TYPEHASH,
                    _mint.target,
                    _mint.from,
                    _mint.totalPrice,
                    _mint.quantity,
                    _mint.nonce,
                    _mint.deadline
                )
            );
    }

    function getTypedDataHash(Mint memory _mint) public view returns (bytes32) {
        return _hashTypedDataV4(getMintHash(_mint));
    }
}
