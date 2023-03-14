// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "forge-std/Script.sol";

import {Address} from "@openzeppelin/contracts/utils/Address.sol";
import {NounsCoasterMetadataRenderer} from "../../src/nouns-coasters/metadata/NounsCoasterMetadataRenderer.sol";
import {INounsCoasterMetadataRendererTypes} from "../../src/nouns-coasters/interfaces/INounsCoasterMetadataRendererTypes.sol";
import {CoasterHelper} from "../../src/nouns-coasters/metadata/CoasterHelper.sol";
import {console2} from "forge-std/console2.sol";

contract SetupNounsCoasters is Script {
    function run() public {
        address owner = address(this);
        NounsCoasterMetadataRenderer renderer = new NounsCoasterMetadataRenderer({
                _description: "",
                _contractImage: "",
                _projectURI: "",
                _rendererBase: "",
                _token: address(0),
                _owner: owner
            });

        CoasterHelper.addLayer1(renderer);
        CoasterHelper.addLayer5(renderer);
        CoasterHelper.addLayer6(renderer);
        CoasterHelper.addLayer7(renderer);
        CoasterHelper.addLayer8(renderer);
        CoasterHelper.addLayer9(renderer);
        CoasterHelper.addLayer10(renderer);
        CoasterHelper.addLayer11(renderer);
        CoasterHelper.addLayer12(renderer);
        CoasterHelper.addLayer13(renderer);
        CoasterHelper.addLayer14(renderer);
        CoasterHelper.addLayer15(renderer);
        CoasterHelper.addLayer16(renderer);
        CoasterHelper.addLayer17(renderer);
        CoasterHelper.addLayer18(renderer);
        CoasterHelper.addLayer19(renderer);
        CoasterHelper.addLayer20(renderer);
        CoasterHelper.addLayer21(renderer);
        CoasterHelper.addLayer22(renderer);
        CoasterHelper.addLayer23(renderer);
        CoasterHelper.addLayer24(renderer);

        console2.log(renderer.tokenURI(10));
    }
}
