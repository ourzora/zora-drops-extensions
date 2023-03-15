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
        address deployer = vm.envAddress("DEPLOYER");
        address target = vm.envAddress("TARGET");
        address rendererAddress = vm.envAddress("RENDERER");
        vm.startBroadcast(deployer);
        NounsCoasterMetadataRenderer renderer = NounsCoasterMetadataRenderer(rendererAddress);
        INounsCoasterMetadataRendererTypes.Settings memory settings;
        settings.projectURI = "https://www.comicsdao.wtf/nouns";
        settings.description = unicode'Mint a unique piece from the “Themed Park Nouns” collection. \\nThe covers are randomly generated from over 7000 pieces of hand drawn artwork representing the entire set of Nouns traits. There is over 500 million possible permutations of the Special Edition Cover. \\nAll proceeds go to purchase physical versions of Nouns Comic #1 for donation to youth hospitals in North America.';
        settings.contractImage = "ipfs://bafybeiew2wnmisaojqfkmjmzll4nhsnokneo3e4d6gcszhqscf4flslq4u";
        settings.rendererBase = "https://api.zora.co/renderer/stack-images";

        renderer.updateSettings(target, settings);

        CoasterHelper.addLayer1(renderer, target);
        CoasterHelper.addLayer5(renderer, target);
        CoasterHelper.addLayer6(renderer, target);
        CoasterHelper.addLayer7(renderer, target);
        CoasterHelper.addLayer8(renderer, target);
        CoasterHelper.addLayer9(renderer, target);
        CoasterHelper.addLayer10(renderer, target);
        CoasterHelper.addLayer11(renderer, target);
        CoasterHelper.addLayer12(renderer, target);
        CoasterHelper.addLayer13(renderer, target);
        CoasterHelper.addLayer14(renderer, target);
        CoasterHelper.addLayer15(renderer, target);
        CoasterHelper.addLayer16(renderer, target);
        CoasterHelper.addLayer17(renderer, target);
        CoasterHelper.addLayer18(renderer, target);
        CoasterHelper.addLayer19(renderer, target);
        CoasterHelper.addLayer20(renderer, target);
        CoasterHelper.addLayer21(renderer, target);
        CoasterHelper.addLayer22(renderer, target);
        CoasterHelper.addLayer23(renderer, target);
        CoasterHelper.addLayer24(renderer, target);

        vm.stopBroadcast();

        (string memory _a, string memory _b) = renderer.getAttributes(target, 10);
        console2.log(_a);
        console2.log(_b);
    }
}
