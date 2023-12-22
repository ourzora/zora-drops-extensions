// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import {EIP712} from "@openzeppelin/contracts/utils/cryptography/draft-EIP712.sol";
import {ECDSA} from "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import {AccessControl} from "@openzeppelin/contracts/access/AccessControl.sol";
import {console2} from "forge-std/console2.sol";
import {ERC721DropSignatureInterface} from "./ERC721DropSignatureInterface.sol";
import {IReadableAuthRegistry} from "./IAuthRegistry.sol";

/**
 * @title SignatureMinterModule
 * @notice Mint via signatures on IERC721Drop.adminMint
 * @notice WIP, not audited!
 *
 * @author Iain <iain@zora.co>
 * @author Jem <jem@zora.co>
 * @author James <james@zora.co>
 *
 * @dev can be used by any contract
 * @dev grant ERC721Drop.MINTER_ROLE() to this contract
 * @dev add valid signers to an AuthRegistry contract
 * @dev
 *
 */
contract SignatureMinter is EIP712 {
    error WrongPrice();
    error UsedNonceAlready();
    error Expired();
    error MintingError();
    error InvalidSignature();
    error ErrorTransferringFunds();
    error WrongRecipient();
    error CallerNotAdmin();
    error NoAuthRegistryConfigured();

    /// @notice Emitted upon a successful mint
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
    mapping(address => mapping(uint256 => bool)) public usedNonces;

    /// @notice Associates an AuthRegistry contract with an ERC721Drop
    mapping(address => IReadableAuthRegistry) public authRegistryForTokenContract;

    struct Mint {
        address target;
        bytes32 nonce;
        uint256 quantity;
        uint256 totalPrice;
        uint256 expiration;
        address mintTo;
    }

    bytes32 private immutable MINT_TYPEHASH =
        keccak256(
            "Mint(address target,bytes32 nonce,uint256 quantity,uint256 totalPrice,uint256 expiration,address mintTo)"
        );

    bytes32 private immutable MINTER_ROLE = keccak256("MINTER");
    bytes32 public immutable SALES_MANAGER_ROLE = keccak256("SALES_MANAGER");
    bytes32 public constant DEFAULT_ADMIN_ROLE = 0x00;


    constructor(string memory version) EIP712("SignatureMinter", version) {}

    /// @notice AdminMints on an ERC721Drop
    /// @dev totalPrice is independent of prices set in IERC721.SaleDetails
    ///
    /// @param target implements IERC721Drop.adminMint
    /// @param mintTo receiver of the token
    /// @param quantity number of NFTs to mint
    /// @param totalPrice total cost of minting to sender
    /// @param nonce scoped to the signer
    /// @param expiration signature expiry date (seconds since UNIX epoch)
    /// @param signature the signature!
    function mintWithSignature(
        address target,
        address mintTo,
        uint256 quantity,
        uint256 totalPrice,
        uint256 nonce,
        uint256 expiration,
        bytes calldata signature
    ) external payable {
        if (totalPrice != msg.value) {
            revert WrongPrice();
        }
        if (usedNonces[target][nonce]) {
            revert UsedNonceAlready();
        }
        usedNonces[target][nonce] = true;

        if (block.timestamp > expiration) {
            revert Expired();
        }
        if (mintTo != address(0) && mintTo != msg.sender) {
            revert WrongRecipient();
        }

        bytes32 sigHash = _hashTypedDataV4(
            keccak256(
                abi.encode(
                    MINT_TYPEHASH,
                    target,
                    nonce,
                    quantity,
                    totalPrice,
                    expiration,
                    mintTo
                )
            )
        );

        IReadableAuthRegistry authRegistry = authRegistryForTokenContract[target];
        if (address(authRegistry) == address(0)) {
            revert NoAuthRegistryConfigured();
        }
        address signer = ECDSA.recover(sigHash, signature);
        if (signer == address(0) || !authRegistry.isAuthorized(signer)) {
            revert InvalidSignature();
        }

        try ERC721DropSignatureInterface(target).adminMint(mintTo, quantity) {
            if (msg.value > 0) {
                // Send value to root contract
                (bool success, ) = payable(target).call{value: msg.value}("");
                if (!success) {
                    revert ErrorTransferringFunds();
                }
            }
            emit MintedFromSignature(target, signer, mintTo, quantity, totalPrice);
        } catch {
            revert MintingError();
        }
    }

    function getMintHash(Mint memory _mint) internal view returns (bytes32) {
        return
            keccak256(
                abi.encode(
                    MINT_TYPEHASH,
                    _mint.target,
                    _mint.nonce,
                    _mint.quantity,
                    _mint.totalPrice,
                    _mint.expiration,
                    _mint.mintTo
                )
            );
    }

    function getTypedDataHash(Mint memory _mint) public view returns (bytes32) {
        return _hashTypedDataV4(getMintHash(_mint));
    }


    /// @notice ERC721Drop admin or sales manager sets an AuthRegistry
    ///
    /// @param target address of the ERC721Drop contract
    /// @param authRegistry AuthRegistry contract to manage valid signers for the ERC721Drop
    function setAuthRegistryForTokenContract(address target, IReadableAuthRegistry authRegistry) external {
        if(
            !ERC721DropSignatureInterface(target).hasRole(DEFAULT_ADMIN_ROLE, msg.sender) &&
            !ERC721DropSignatureInterface(target).hasRole(SALES_MANAGER_ROLE, msg.sender)
        ) {
            revert CallerNotAdmin();
        }
        authRegistryForTokenContract[target] = authRegistry;
    }
}
