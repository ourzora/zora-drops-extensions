// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import {IMetadataRenderer} from "zora-drops-contracts/interfaces/IMetadataRenderer.sol";

contract DummyMetadataRenderer is IMetadataRenderer {
    string public someState;

    function tokenURI(uint256) external pure override returns (string memory) {
        return "DUMMY";
    }

    function contractURI() external pure override returns (string memory) {
        return "DUMMY";
    }

    function initializeWithData(bytes memory data) external {
        // no-op
    }

    function updateSomeState(
        string memory someStateNewValue,
        address expectedSender
    ) external {
        require(msg.sender == expectedSender);
        someState = someStateNewValue;
    }
}
