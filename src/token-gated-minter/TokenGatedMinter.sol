// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import {IERC165} from "forge-std/interfaces/IERC165.sol";
import {IERC721} from "forge-std/interfaces/IERC721.sol";
import {IERC721Drop} from "zora-drops-contracts/interfaces/IERC721Drop.sol";

contract TokenGatedMinter {
    struct TokenGate {
        uint256 mintPrice;
        uint256 mintLimitPerToken;
    }

    // token gate contract address => token gate details
    mapping(address => TokenGate) public tokenGates;

    // token gate address => token gate tokenId => was used for minting
    mapping(address => mapping(uint256 => bool)) public tokenUsedForMinting;

    address payable public immutable mintingToken;

    modifier onlyTokenAdmin() {
        require(
            IERC721Drop(mintingToken).isAdmin(msg.sender),
            "TokenGatedMinter: not token admin"
        );
        _;
    }

    constructor(address payable _mintingToken) {
        mintingToken = _mintingToken;
    }

    function setTokenGate(
        address _token,
        uint256 _mintPrice,
        uint256 _mintLimitPerToken
    ) external onlyTokenAdmin {
        if (_token == address(0)) {
            return;
        }
        if (_mintLimitPerToken == 0) {
            delete tokenGates[_token];
            return;
        }
        tokenGates[_token] = TokenGate({
            mintPrice: _mintPrice,
            mintLimitPerToken: _mintLimitPerToken
        });
    }

    function mintWithAllowedTokens(
        address _tokenGate,
        uint256 _amountToMint,
        uint256[] calldata _tokenIds
    ) external payable {
        require(_amountToMint > 0, "TokenGatedMinter: must mint at least 1");
        require(_tokenIds.length > 0, "TokenGatedMinter: must provide tokens");
        require(
            _amountToMint <=
                _tokenIds.length * tokenGates[_tokenGate].mintLimitPerToken,
            "TokenGatedMinter: mint limit exceeded"
        );
        require(
            _amountToMint >
                (_tokenIds.length - 1) *
                    tokenGates[_tokenGate].mintLimitPerToken,
            "TokenGatedMinter: too many tokens provided"
        );
        require(
            msg.value == _amountToMint * tokenGates[_tokenGate].mintPrice,
            "TokenGatedMinter: wrong price"
        );
        for (uint256 i = 0; i < _tokenIds.length; i++) {
            require(
                !tokenUsedForMinting[_tokenGate][_tokenIds[i]],
                "TokenGatedMinter: token already used to mint"
            );
            require(
                IERC721(_tokenGate).ownerOf(_tokenIds[i]) == msg.sender,
                "TokenGatedMinter: not token owner"
            );
            tokenUsedForMinting[_tokenGate][_tokenIds[i]] = true;
        }
        IERC721Drop(mintingToken).adminMint(msg.sender, _amountToMint);
        (bool sent, ) = mintingToken.call{value: msg.value}("");
        require(sent, "TokenGatedMinter: failed to send ether");
    }
}
