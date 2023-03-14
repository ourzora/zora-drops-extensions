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
        address rendererAddress = vm.envAddress("RENDERER");
        vm.startBroadcast(deployer);
        NounsCoasterMetadataRenderer renderer = NounsCoasterMetadataRenderer(rendererAddress);
        INounsCoasterMetadataRendererTypes.Settings memory settings;
        settings.variantCount = 4;
        settings.projectURI = "";
        settings.description = "";
        settings.contractImage = "";
        settings.rendererBase = "https://api.zora.co/renderer/stack-images";

        renderer.initializeWithData(abi.encode(settings));

        CoasterHelper.addLayer1(renderer, deployer);
        CoasterHelper.addLayer5(renderer, deployer);
        CoasterHelper.addLayer6(renderer, deployer);
        CoasterHelper.addLayer7(renderer, deployer);
        CoasterHelper.addLayer8(renderer, deployer);
        CoasterHelper.addLayer9(renderer, deployer);
        CoasterHelper.addLayer10(renderer, deployer);
        CoasterHelper.addLayer11(renderer, deployer);
        CoasterHelper.addLayer12(renderer, deployer);
        CoasterHelper.addLayer13(renderer, deployer);
        CoasterHelper.addLayer14(renderer, deployer);
        CoasterHelper.addLayer15(renderer, deployer);
        CoasterHelper.addLayer16(renderer, deployer);
        CoasterHelper.addLayer17(renderer, deployer);
        CoasterHelper.addLayer18(renderer, deployer);
        CoasterHelper.addLayer19(renderer, deployer);
        CoasterHelper.addLayer20(renderer, deployer);
        CoasterHelper.addLayer21(renderer, deployer);
        CoasterHelper.addLayer22(renderer, deployer);
        CoasterHelper.addLayer23(renderer, deployer);
        CoasterHelper.addLayer24(renderer, deployer);

        vm.stopBroadcast();

        (string memory _a, string memory _b) = renderer.getAttributes(deployer, 10);
        console2.log(_a);
        console2.log(_b);
    }
}
