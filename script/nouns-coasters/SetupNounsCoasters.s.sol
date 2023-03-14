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
        NounsCoasterMetadataRenderer renderer = new NounsCoasterMetadataRenderer();
        vm.prank(owner);
        INounsCoasterMetadataRendererTypes.Settings memory settings;
        settings.variantCount = 4;

        vm.startPrank(owner);
        renderer.initializeWithData(abi.encode(settings));

        CoasterHelper.addLayer1(renderer, owner);
        CoasterHelper.addLayer5(renderer, owner);
        CoasterHelper.addLayer6(renderer, owner);
        CoasterHelper.addLayer7(renderer, owner);
        CoasterHelper.addLayer8(renderer, owner);
        CoasterHelper.addLayer9(renderer, owner);
        CoasterHelper.addLayer10(renderer, owner);
        CoasterHelper.addLayer11(renderer, owner);
        CoasterHelper.addLayer12(renderer, owner);
        CoasterHelper.addLayer13(renderer, owner);
        CoasterHelper.addLayer14(renderer, owner);
        CoasterHelper.addLayer15(renderer, owner);
        CoasterHelper.addLayer16(renderer, owner);
        CoasterHelper.addLayer17(renderer, owner);
        CoasterHelper.addLayer18(renderer, owner);
        CoasterHelper.addLayer19(renderer, owner);
        CoasterHelper.addLayer20(renderer, owner);
        CoasterHelper.addLayer21(renderer, owner);
        CoasterHelper.addLayer22(renderer, owner);
        CoasterHelper.addLayer23(renderer, owner);
        CoasterHelper.addLayer24(renderer, owner);

        console2.log(renderer.tokenURI(10));
    }
}
