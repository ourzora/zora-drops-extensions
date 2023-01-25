// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity >=0.8.0;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract NounsMockERC721 is ERC721 {
    uint256 counter = 0;

    constructor(string memory _name, string memory _symbol)
        ERC721(_name, _symbol)
    {}

    function tokenURI(uint256)
        public
        pure
        virtual
        override
        returns (string memory)
    {}

    function adminMint(address to, uint256 numTokens) public {
        for (uint256 i = 0; i < numTokens; i++) {
            _mint(to, counter);
            counter++;
        }
    }

    function mint(address to, uint256 tokenId) public virtual {
        _mint(to, tokenId);
        counter++;
    }

    function burn(uint256 tokenId) public virtual {
        _burn(tokenId);
    }

    function safeMint(address to, uint256 tokenId) public virtual {
        _safeMint(to, tokenId);
        counter++;
    }

    function safeMint(
        address to,
        uint256 tokenId,
        bytes memory data
    ) public virtual {
        _safeMint(to, tokenId, data);
    }
}
