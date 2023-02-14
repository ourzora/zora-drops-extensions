// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import {IERC165} from "forge-std/interfaces/IERC165.sol";
import {IERC721Drop} from "zora-drops-contracts/interfaces/IERC721Drop.sol";
import {ITokenBalance} from "../utils/ITokenBalance.sol";

contract TokenGatedMinter {
    address payable public immutable mintingToken;

    struct TokenGate {
        uint256 amount;
        uint256 mintPrice;
        uint256 mintLimit;
    }

    // token gate contract address => token gate details
    mapping(address => TokenGate) public tokenGates;

    // minter address => token gate contract address => has minted
    mapping(address => mapping(address => bool)) public hasMintedWithTokenGate;

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
        uint256 _amount,
        uint256 _mintPrice,
        uint256 _mintLimit
    ) external onlyTokenAdmin {
        if (_token == address(0)) {
            return;
        }
        if (_amount == 0 || _mintLimit == 0) {
            delete tokenGates[_token];
        }
        tokenGates[_token] = TokenGate({
            amount: _amount,
            mintPrice: _mintPrice,
            mintLimit: _mintLimit
        });
    }

    function mintWithAllowedToken(address _tokenGate, uint256 _amountToMint)
        external
        payable
    {
        require(_amountToMint > 0, "TokenGatedMinter: must mint at least 1");
        require(
            _amountToMint <= tokenGates[_tokenGate].mintLimit,
            "TokenGatedMinter: mint limit exceeded"
        );
        require(
            msg.value == _amountToMint * tokenGates[_tokenGate].mintPrice,
            "TokenGatedMinter: wrong price"
        );
        require(
            ITokenBalance(_tokenGate).balanceOf(msg.sender) >=
                tokenGates[_tokenGate].amount,
            "TokenGatedMinter: token gate not met"
        );
        require(
            !hasMintedWithTokenGate[msg.sender][_tokenGate],
            "TokenGatedMinter: already minted"
        );
        hasMintedWithTokenGate[msg.sender][_tokenGate] = true;
        IERC721Drop(mintingToken).adminMint(msg.sender, _amountToMint);
        (bool sent, ) = mintingToken.call{value: msg.value}("");
        require(sent, "TokenGatedMinter: failed to send ether");
    }
}
