// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "forge-std/Script.sol";

import {TokenGatedMinter} from "../../src/token-gated-minter/TokenGatedMinter.sol";

contract DeployTokenGatedMinter is Script {
    function run() external {
        uint256 key = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(key);

        new TokenGatedMinter();

        vm.stopBroadcast();
    }
}
