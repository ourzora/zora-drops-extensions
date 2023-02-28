// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import {IERC165} from "forge-std/interfaces/IERC165.sol";
import {IERC721} from "forge-std/interfaces/IERC721.sol";
import {IERC721Drop} from "zora-drops-contracts/interfaces/IERC721Drop.sol";

contract TokenGatedMinter {
    struct TokenGateDetails {
        uint256 mintPrice;
        uint256 maxQuantityPerGateToken;
    }

    // mint address => gate address => token gate details
    mapping(address => mapping(address => TokenGateDetails)) public tokenGates;

    // mint address => gate address => gate tokenId => was used for minting
    mapping(address => mapping(address => mapping(uint256 => bool)))
        public tokenWasUsedToMint;

    event TokenGateUpdated(
        address mintToken,
        address gateToken,
        uint256 mintPrice,
        uint256 maxQuantityPerGateToken
    );

    event MintedUsingGatedTokens(
        address recipient,
        address mintToken,
        uint256 numMinted,
        address gateToken,
        uint256[] gateTokenIds
    );

    modifier onlyTokenAdmin(address mintToken) {
        require(
            IERC721Drop(mintToken).isAdmin(msg.sender),
            "TokenGatedMinter: not token admin"
        );
        _;
    }

    function setTokenGate(
        address _mintToken,
        address _gateToken,
        uint256 _mintPrice,
        uint256 _maxQuantityPerGateToken
    ) external onlyTokenAdmin(_mintToken) {
        require(_gateToken != address(0), "TokenGatedMinter: zero address");
        tokenGates[_mintToken][_gateToken] = TokenGateDetails({
            mintPrice: _mintPrice,
            maxQuantityPerGateToken: _maxQuantityPerGateToken
        });
        emit TokenGateUpdated(
            _mintToken,
            _gateToken,
            _mintPrice,
            _maxQuantityPerGateToken
        );
    }

    function mintWithGatedTokens(
        address _mintToken,
        address _gateToken,
        uint256 _amountToMint,
        uint256[] calldata _tokenIds
    ) external payable {
        require(_amountToMint > 0, "TokenGatedMinter: must mint at least 1");
        require(_tokenIds.length > 0, "TokenGatedMinter: must provide tokens");
        require(
            _amountToMint <=
                _tokenIds.length *
                    tokenGates[_mintToken][_gateToken].maxQuantityPerGateToken,
            "TokenGatedMinter: mint limit exceeded"
        );
        require(
            _amountToMint >
                (_tokenIds.length - 1) *
                    tokenGates[_mintToken][_gateToken].maxQuantityPerGateToken,
            "TokenGatedMinter: too many gate tokens provided for mint amount"
        );
        require(
            msg.value ==
                _amountToMint * tokenGates[_mintToken][_gateToken].mintPrice,
            "TokenGatedMinter: incorrect ETH amount sent"
        );
        for (uint256 i = 0; i < _tokenIds.length; i++) {
            require(
                !tokenWasUsedToMint[_mintToken][_gateToken][_tokenIds[i]],
                "TokenGatedMinter: token already used to mint"
            );
            require(
                IERC721(_gateToken).ownerOf(_tokenIds[i]) == msg.sender,
                "TokenGatedMinter: not token owner"
            );
            tokenWasUsedToMint[_mintToken][_gateToken][_tokenIds[i]] = true;
        }
        emit MintedUsingGatedTokens(
            msg.sender,
            _mintToken,
            _amountToMint,
            _gateToken,
            _tokenIds
        );
        IERC721Drop(_mintToken).adminMint(msg.sender, _amountToMint);
        (bool sent, ) = _mintToken.call{value: msg.value}("");
        require(sent, "TokenGatedMinter: failed to send ether");
    }
}
