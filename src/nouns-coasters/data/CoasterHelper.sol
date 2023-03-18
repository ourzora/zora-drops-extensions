// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import {NounsCoasterMetadataRenderer} from "../metadata/NounsCoasterMetadataRenderer.sol";
import {SSTORE2} from "../utils/SSTORE2.sol";
import {INounsCoasterMetadataRendererTypes} from "../interfaces/INounsCoasterMetadataRendererTypes.sol";
import {VmSafe} from "forge-std/Vm.sol";

library CoasterHelper {
    function addLayer1(NounsCoasterMetadataRenderer renderer, address target)
        internal
    {
        // 1 Background
        INounsCoasterMetadataRendererTypes.VariantPropertyParameters
            memory variantPropertyParameters;
        variantPropertyParameters
            .offsets = new INounsCoasterMetadataRendererTypes.VariantOffset[](
            0
        );
        variantPropertyParameters.id = 0;
        variantPropertyParameters.count = 0;

        string[] memory items = new string[](16);
        items[0] = "Day Blue Roller Coaster";
        items[1] = "Day Blue Water Log";
        items[2] = "Day Orange Roller Coaster";
        items[3] = "Day Orange Water Log";
        items[4] = "Day Pink Roller Coaster";
        items[5] = "Day Pink Water Log";
        items[6] = "Day Purple Roller Coaster";
        items[7] = "Day Purple Water Log";
        items[8] = "Night Blue Roller Coaster";
        items[9] = "Night Blue Water Log";
        items[10] = "Night Orange Roller Coaster";
        items[11] = "Night Orange Water Log";
        items[12] = "Night Pink Roller Coaster";
        items[13] = "Night Pink Water Log";
        items[14] = "Night Purple Roller Coaster";
        items[15] = "Night Purple Water Log";

        bytes memory data = abi.encode(items);

        VmSafe vm = VmSafe(
            address(uint160(uint256(keccak256("hevm cheat code"))))
        );

        string[] memory inputs = new string[](3);
        inputs[0] = "node";
        inputs[1] = "script/nouns-coasters/deflate.js";
        inputs[2] = vm.toString(data);

        bytes memory compressedData = vm.ffi(inputs);

        // address result = SSTORE2.write(compressedData);

        renderer.addLayer({
            target: target,
            ipfs: INounsCoasterMetadataRendererTypes.IPFSGroup({
                baseUri: "ipfs://bafybeiag26lh2at7iah5xqlrzgj2ei2jd2qel3g5bpccgfj5ktjbvu4qm4/",
                extension: ".png"
            }),
            decompressedSize: data.length,
            compressedData: compressedData,
            count: items.length,
            property: "1 Background",
            variantProperty: variantPropertyParameters
        });
    }

    function addLayer5(NounsCoasterMetadataRenderer renderer, address target)
        internal
    {
        // 5 Body rear left
        INounsCoasterMetadataRendererTypes.VariantPropertyParameters
            memory variantPropertyParameters;
        variantPropertyParameters
            .offsets = new INounsCoasterMetadataRendererTypes.VariantOffset[](
            4
        );
        variantPropertyParameters.id = 0;
        variantPropertyParameters.count = 4;
        variantPropertyParameters.offsets[
            0
        ] = INounsCoasterMetadataRendererTypes.VariantOffset({
            startAt: 0,
            count: 30
        });
        variantPropertyParameters.offsets[
            1
        ] = INounsCoasterMetadataRendererTypes.VariantOffset({
            startAt: 30,
            count: 30
        });
        variantPropertyParameters.offsets[
            2
        ] = INounsCoasterMetadataRendererTypes.VariantOffset({
            startAt: 60,
            count: 30
        });
        variantPropertyParameters.offsets[
            3
        ] = INounsCoasterMetadataRendererTypes.VariantOffset({
            startAt: 90,
            count: 30
        });

        string[] memory items = new string[](120);
        items[0] = "1-Both Arms Down Bege Bsod";
        items[1] = "1-Both Arms Down Bege Crt";
        items[2] = "1-Both Arms Down Blue Grey";
        items[3] = "1-Both Arms Down Blue Sky";
        items[4] = "1-Both Arms Down Cold";
        items[5] = "1-Both Arms Down Computer Blue";
        items[6] = "1-Both Arms Down Dark Brown";
        items[7] = "1-Both Arms Down Dark Pink";
        items[8] = "1-Both Arms Down Foggrey";
        items[9] = "1-Both Arms Down Gold";
        items[10] = "1-Both Arms Down Gray Scale 1";
        items[11] = "1-Both Arms Down Gray Scale 7";
        items[12] = "1-Both Arms Down Gray Scale 8";
        items[13] = "1-Both Arms Down Gray Scale 9";
        items[14] = "1-Both Arms Down Green";
        items[15] = "1-Both Arms Down Gunk";
        items[16] = "1-Both Arms Down Hotbrown";
        items[17] = "1-Both Arms Down Magenta";
        items[18] = "1-Both Arms Down Orange";
        items[19] = "1-Both Arms Down Orange Yellow";
        items[20] = "1-Both Arms Down Peachy A";
        items[21] = "1-Both Arms Down Peachy B";
        items[22] = "1-Both Arms Down Purple";
        items[23] = "1-Both Arms Down Red";
        items[24] = "1-Both Arms Down Red Pinkish";
        items[25] = "1-Both Arms Down Rust";
        items[26] = "1-Both Arms Down Slime Green";
        items[27] = "1-Both Arms Down Teal";
        items[28] = "1-Both Arms Down Teal Light";
        items[29] = "1-Both Arms Down Yellow";
        items[30] = "2-Both Arms Up Bege Bsod";
        items[31] = "2-Both Arms Up Bege Crt";
        items[32] = "2-Both Arms Up Blue Gray";
        items[33] = "2-Both Arms Up Blue Sky";
        items[34] = "2-Both Arms Up Cold";
        items[35] = "2-Both Arms Up Computer Blue";
        items[36] = "2-Both Arms Up Dark Brown";
        items[37] = "2-Both Arms Up Dark Pink";
        items[38] = "2-Both Arms Up Foggrey";
        items[39] = "2-Both Arms Up Gold";
        items[40] = "2-Both Arms Up Gray Scale 1";
        items[41] = "2-Both Arms Up Gray Scale 7";
        items[42] = "2-Both Arms Up Gray Scale 8";
        items[43] = "2-Both Arms Up Gray Scale 9";
        items[44] = "2-Both Arms Up Green";
        items[45] = "2-Both Arms Up Gunk";
        items[46] = "2-Both Arms Up Hotbrown";
        items[47] = "2-Both Arms Up Magenta";
        items[48] = "2-Both Arms Up Orange";
        items[49] = "2-Both Arms Up Orange Yellow";
        items[50] = "2-Both Arms Up Peachy A";
        items[51] = "2-Both Arms Up Peachy B";
        items[52] = "2-Both Arms Up Purple";
        items[53] = "2-Both Arms Up Red";
        items[54] = "2-Both Arms Up Red Pinkish";
        items[55] = "2-Both Arms Up Rust";
        items[56] = "2-Both Arms Up Slime Green";
        items[57] = "2-Both Arms Up Teal";
        items[58] = "2-Both Arms Up Teal Light";
        items[59] = "2-Both Arms Up Yellow";
        items[60] = "3-Left Arm Up Bege Bsod";
        items[61] = "3-Left Arm Up Bege Crt";
        items[62] = "3-Left Arm Up Blue Grey";
        items[63] = "3-Left Arm Up Blue Sky";
        items[64] = "3-Left Arm Up Cold";
        items[65] = "3-Left Arm Up Computer Blue";
        items[66] = "3-Left Arm Up Dark Brown";
        items[67] = "3-Left Arm Up Dark Pink";
        items[68] = "3-Left Arm Up Foggrey";
        items[69] = "3-Left Arm Up Gold";
        items[70] = "3-Left Arm Up Gray Scale 1";
        items[71] = "3-Left Arm Up Gray Scale 7";
        items[72] = "3-Left Arm Up Gray Scale 8";
        items[73] = "3-Left Arm Up Gray Scale 9";
        items[74] = "3-Left Arm Up Green";
        items[75] = "3-Left Arm Up Gunk";
        items[76] = "3-Left Arm Up Hotbrown";
        items[77] = "3-Left Arm Up Magenta";
        items[78] = "3-Left Arm Up Orange";
        items[79] = "3-Left Arm Up Orange Yellow";
        items[80] = "3-Left Arm Up Peachy A";
        items[81] = "3-Left Arm Up Peachy B";
        items[82] = "3-Left Arm Up Purple";
        items[83] = "3-Left Arm Up Red";
        items[84] = "3-Left Arm Up Redpinkish";
        items[85] = "3-Left Arm Up Rust";
        items[86] = "3-Left Arm Up Slime Green";
        items[87] = "3-Left Arm Up Teal";
        items[88] = "3-Left Arm Up Teal Light";
        items[89] = "3-Left Arm Up Yellow";
        items[90] = "4-Right Arm Up Bege Bsod";
        items[91] = "4-Right Arm Up Bege Crt";
        items[92] = "4-Right Arm Up Blue Grey";
        items[93] = "4-Right Arm Up Blue Sky";
        items[94] = "4-Right Arm Up Cold";
        items[95] = "4-Right Arm Up Computer Blue";
        items[96] = "4-Right Arm Up Dark Brown";
        items[97] = "4-Right Arm Up Dark Pink";
        items[98] = "4-Right Arm Up Foggrey";
        items[99] = "4-Right Arm Up Gold";
        items[100] = "4-Right Arm Up Gray Scale 1";
        items[101] = "4-Right Arm Up Gray Scale 7";
        items[102] = "4-Right Arm Up Gray Scale 8";
        items[103] = "4-Right Arm Up Gray Scale 9";
        items[104] = "4-Right Arm Up Green";
        items[105] = "4-Right Arm Up Gunk";
        items[106] = "4-Right Arm Up Hotbrown";
        items[107] = "4-Right Arm Up Magenta";
        items[108] = "4-Right Arm Up Orange";
        items[109] = "4-Right Arm Up Orange Yellow";
        items[110] = "4-Right Arm Up Peachy A";
        items[111] = "4-Right Arm Up Peachy B";
        items[112] = "4-Right Arm Up Purple";
        items[113] = "4-Right Arm Up Red";
        items[114] = "4-Right Arm Up Red Pinkish";
        items[115] = "4-Right Arm Up Rust";
        items[116] = "4-Right Arm Up Slime Green";
        items[117] = "4-Right Arm Up Teal";
        items[118] = "4-Right Arm Up Teal Light";
        items[119] = "4-Right Arm Up Yellow";

        bytes memory data = abi.encode(items);

        VmSafe vm = VmSafe(
            address(uint160(uint256(keccak256("hevm cheat code"))))
        );

        string[] memory inputs = new string[](3);
        inputs[0] = "node";
        inputs[1] = "script/nouns-coasters/deflate.js";
        inputs[2] = vm.toString(data);

        bytes memory compressedData = vm.ffi(inputs);

        // address result = SSTORE2.write(compressedData);

        renderer.addLayer({
            target: target,
            ipfs: INounsCoasterMetadataRendererTypes.IPFSGroup({
                baseUri: "ipfs://bafybeiag26lh2at7iah5xqlrzgj2ei2jd2qel3g5bpccgfj5ktjbvu4qm4/",
                extension: ".png"
            }),
            decompressedSize: data.length,
            compressedData: compressedData,
            count: items.length,
            property: "5 Body rear left",
            variantProperty: variantPropertyParameters
        });
    }

    function addLayer6(NounsCoasterMetadataRenderer renderer, address target)
        internal
    {
        // 6 Accessories rear left
        INounsCoasterMetadataRendererTypes.VariantPropertyParameters
            memory variantPropertyParameters;
        variantPropertyParameters
            .offsets = new INounsCoasterMetadataRendererTypes.VariantOffset[](
            4
        );
        variantPropertyParameters.id = 0;
        variantPropertyParameters.count = 4;
        variantPropertyParameters.offsets[
            0
        ] = INounsCoasterMetadataRendererTypes.VariantOffset({
            startAt: 0,
            count: 139
        });
        variantPropertyParameters.offsets[
            1
        ] = INounsCoasterMetadataRendererTypes.VariantOffset({
            startAt: 139,
            count: 137
        });
        variantPropertyParameters.offsets[
            2
        ] = INounsCoasterMetadataRendererTypes.VariantOffset({
            startAt: 276,
            count: 137
        });
        variantPropertyParameters.offsets[
            3
        ] = INounsCoasterMetadataRendererTypes.VariantOffset({
            startAt: 413,
            count: 137
        });

        string[] memory items = new string[](550);
        items[0] = "1-Asset Rear Left 1n";
        items[1] = "1-Asset Rear Left Aardvark";
        items[2] = "1-Asset Rear Left Axe";
        items[3] = "1-Asset Rear Left Belly Chamaleon";
        items[4] = "1-Asset Rear Left Bird Flying";
        items[5] = "1-Asset Rear Left Bird Side";
        items[6] = "1-Asset Rear Left Bling Anchor";
        items[7] = "1-Asset Rear Left Bling Anvil";
        items[8] = "1-Asset Rear Left Bling Arrow";
        items[9] = "1-Asset Rear Left Bling Cheese";
        items[10] = "1-Asset Rear Left Bling Gold Ingot";
        items[11] = "1-Asset Rear Left Bling Love";
        items[12] = "1-Asset Rear Left Bling Mask";
        items[13] = "1-Asset Rear Left Bling Rings";
        items[14] = "1-Asset Rear Left Bling Scissors";
        items[15] = "1-Asset Rear Left Both Arms Down Bege Bsod";
        items[16] = "1-Asset Rear Left Both Arms Down Belly Chamaleon";
        items[17] = "1-Asset Rear Left Both Arms Down Bigwalk Blue Prime";
        items[18] = "1-Asset Rear Left Both Arms Down Bigwalk Grey Light";
        items[19] = "1-Asset Rear Left Both Arms Down Bigwalk Rainbow";
        items[20] = "1-Asset Rear Left Both Arms Down Chain Logo";
        items[21] = "1-Asset Rear Left Both Arms Down Checker Disco";
        items[22] = "1-Asset Rear Left Both Arms Down Checker Rgb";
        items[23] = "1-Asset Rear Left Both Arms Down Checker Spaced Black";
        items[24] = "1-Asset Rear Left Both Arms Down Checker Spaced White";
        items[25] = "1-Asset Rear Left Both Arms Down Checker Vibrant";
        items[26] = "1-Asset Rear Left Both Arms Down Checkers Big Green";
        items[27] = "1-Asset Rear Left Both Arms Down Checkers Big Red Cold";
        items[28] = "1-Asset Rear Left Both Arms Down Checkers Black";
        items[29] = "1-Asset Rear Left Both Arms Down Checkers Blue";
        items[30] = "1-Asset Rear Left Both Arms Down Checkers Magenta";
        items[31] = "1-Asset Rear Left Both Arms Down Collar Sunset";
        items[32] = "1-Asset Rear Left Both Arms Down Decay Gray Dark";
        items[33] = "1-Asset Rear Left Both Arms Down Decay Pride";
        items[34] = "1-Asset Rear Left Both Arms Down Gradient Dawn";
        items[35] = "1-Asset Rear Left Both Arms Down Gradient Dusk";
        items[36] = "1-Asset Rear Left Both Arms Down Gradient Glacier";
        items[37] = "1-Asset Rear Left Both Arms Down Gradient Ice";
        items[38] = "1-Asset Rear Left Both Arms Down Gradient Pride";
        items[39] = "1-Asset Rear Left Both Arms Down Gradient Redpink";
        items[40] = "1-Asset Rear Left Both Arms Down Gradient Sunset";
        items[41] = "1-Asset Rear Left Both Arms Down Gray Scale 1";
        items[42] = "1-Asset Rear Left Both Arms Down Gray Scale 9";
        items[43] = "1-Asset Rear Left Both Arms Down Grid Simple Bege";
        items[44] = "1-Asset Rear Left Both Arms Down Ice Cold";
        items[45] = "1-Asset Rear Left Both Arms Down Lines 45 Greens";
        items[46] = "1-Asset Rear Left Both Arms Down Lines 45 Rose";
        items[47] = "1-Asset Rear Left Both Arms Down Old Shirt";
        items[48] = "1-Asset Rear Left Both Arms Down Rainbow Steps";
        items[49] = "1-Asset Rear Left Both Arms Down Robot";
        items[50] = "1-Asset Rear Left Both Arms Down Safety Vest";
        items[51] = "1-Asset Rear Left Both Arms Down Scarf Clown";
        items[52] = "1-Asset Rear Left Both Arms Down Shirt Black";
        items[53] = "1-Asset Rear Left Both Arms Down Stripes And Checks";
        items[54] = "1-Asset Rear Left Both Arms Down Stripes Big Red";
        items[55] = "1-Asset Rear Left Both Arms Down Stripes Blit";
        items[56] = "1-Asset Rear Left Both Arms Down Stripes Blue Med";
        items[57] = "1-Asset Rear Left Both Arms Down Stripes Brown";
        items[58] = "1-Asset Rear Left Both Arms Down Stripes Olive";
        items[59] = "1-Asset Rear Left Both Arms Down Stripes Red Cold";
        items[60] = "1-Asset Rear Left Both Arms Down Taxi Checkers";
        items[61] = "1-Asset Rear Left Both Arms Down Tee Yo";
        items[62] = "1-Asset Rear Left Both Arms Down Txt Ico";
        items[63] = "1-Asset Rear Left Both Arms Down Wall";
        items[64] = "1-Asset Rear Left Both Arms Down Woolweave Bicolor";
        items[65] = "1-Asset Rear Left Both Arms Down Woolweave Dirt";
        items[66] = "1-Asset Rear Left Carrot";
        items[67] = "1-Asset Rear Left Chain Logo";
        items[68] = "1-Asset Rear Left Chicken";
        items[69] = "1-Asset Rear Left Cloud";
        items[70] = "1-Asset Rear Left Clover";
        items[71] = "1-Asset Rear Left Cow";
        items[72] = "1-Asset Rear Left Dinosaur";
        items[73] = "1-Asset Rear Left Dollar Bling";
        items[74] = "1-Asset Rear Left Dragon";
        items[75] = "1-Asset Rear Left Ducky";
        items[76] = "1-Asset Rear Left Eth";
        items[77] = "1-Asset Rear Left Eye";
        items[78] = "1-Asset Rear Left Flash";
        items[79] = "1-Asset Rear Left Fries";
        items[80] = "1-Asset Rear Left Glasses";
        items[81] = "1-Asset Rear Left Glasses Logo";
        items[82] = "1-Asset Rear Left Glasses Logo Sun";
        items[83] = "1-Asset Rear Left Heart";
        items[84] = "1-Asset Rear Left Hoodiestrings Uneven";
        items[85] = "1-Asset Rear Left Id";
        items[86] = "1-Asset Rear Left Infinity";
        items[87] = "1-Asset Rear Left Insignia";
        items[88] = "1-Asset Rear Left Leaf";
        items[89] = "1-Asset Rear Left Light Bulb";
        items[90] = "1-Asset Rear Left Lp";
        items[91] = "1-Asset Rear Left Mars Face";
        items[92] = "1-Asset Rear Left Matrix White";
        items[93] = "1-Asset Rear Left Moon Block";
        items[94] = "1-Asset Rear Left None";
        items[95] = "1-Asset Rear Left Pizza Bling";
        items[96] = "1-Asset Rear Left Pocket Pencil";
        items[97] = "1-Asset Rear Left Rain";
        items[98] = "1-Asset Rear Left Rgb";
        items[99] = "1-Asset Rear Left Secret X";
        items[100] = "1-Asset Rear Left Shrimp";
        items[101] = "1-Asset Rear Left Slime Splat";
        items[102] = "1-Asset Rear Left Small Bling";
        items[103] = "1-Asset Rear Left Snowflake";
        items[104] = "1-Asset Rear Left Sparkles";
        items[105] = "1-Asset Rear Left Stains Blood";
        items[106] = "1-Asset Rear Left Stains Zombie";
        items[107] = "1-Asset Rear Left Sunset";
        items[108] = "1-Asset Rear Left Think";
        items[109] = "1-Asset Rear Left Tie Black On White";
        items[110] = "1-Asset Rear Left Tie Dye";
        items[111] = "1-Asset Rear Left Tie Purple";
        items[112] = "1-Asset Rear Left Tie Red";
        items[113] = "1-Asset Rear Left Txt A2+b2";
        items[114] = "1-Asset Rear Left Txt Cc";
        items[115] = "1-Asset Rear Left Txt Cc 2";
        items[116] = "1-Asset Rear Left Txt Copy";
        items[117] = "1-Asset Rear Left Txt Dao Black";
        items[118] = "1-Asset Rear Left Txt Doom";
        items[119] = "1-Asset Rear Left Txt Dope";
        items[120] = "1-Asset Rear Left Txt Foo Black";
        items[121] = "1-Asset Rear Left Txt Io";
        items[122] = "1-Asset Rear Left Txt Lmao";
        items[123] = "1-Asset Rear Left Txt Lol";
        items[124] = "1-Asset Rear Left Txt Mint";
        items[125] = "1-Asset Rear Left Txt Nil Grey Dark";
        items[126] = "1-Asset Rear Left Txt Noun";
        items[127] = "1-Asset Rear Left Txt Noun F0f";
        items[128] = "1-Asset Rear Left Txt Noun Green";
        items[129] = "1-Asset Rear Left Txt Noun Multicolor";
        items[130] = "1-Asset Rear Left Txt Pi";
        items[131] = "1-Asset Rear Left Txt Pop";
        items[132] = "1-Asset Rear Left Txt Rofl";
        items[133] = "1-Asset Rear Left Txt We";
        items[134] = "1-Asset Rear Left Txt Yay";
        items[135] = "1-Asset Rear Left Txt Yolo";
        items[136] = "1-Asset Rear Left Wave";
        items[137] = "1-Asset Rear Left Wet Money";
        items[138] = "1-Asset Rear Left Ying Yang";
        items[139] = "2-Asset Rear Left 1n";
        items[140] = "2-Asset Rear Left Aardvark";
        items[141] = "2-Asset Rear Left Axe";
        items[142] = "2-Asset Rear Left Belly Chamaleon";
        items[143] = "2-Asset Rear Left Bird Flying";
        items[144] = "2-Asset Rear Left Bird Side";
        items[145] = "2-Asset Rear Left Bling Anchor";
        items[146] = "2-Asset Rear Left Bling Anvil";
        items[147] = "2-Asset Rear Left Bling Arrow";
        items[148] = "2-Asset Rear Left Bling Cheese";
        items[149] = "2-Asset Rear Left Bling Gold Ingot";
        items[150] = "2-Asset Rear Left Bling Love";
        items[151] = "2-Asset Rear Left Bling Mask";
        items[152] = "2-Asset Rear Left Bling Rings";
        items[153] = "2-Asset Rear Left Bling Scissors";
        items[154] = "2-Asset Rear Left Both Arms Up Bege Bsod";
        items[155] = "2-Asset Rear Left Both Arms Up Bigwalk Blue Prime";
        items[156] = "2-Asset Rear Left Both Arms Up Bigwalk Grey Light";
        items[157] = "2-Asset Rear Left Both Arms Up Bigwalk Rainbow";
        items[158] = "2-Asset Rear Left Both Arms Up Checker Disco";
        items[159] = "2-Asset Rear Left Both Arms Up Checker Rgb";
        items[160] = "2-Asset Rear Left Both Arms Up Checker Spaced Black";
        items[161] = "2-Asset Rear Left Both Arms Up Checker Spaced White";
        items[162] = "2-Asset Rear Left Both Arms Up Checker Vibrant";
        items[163] = "2-Asset Rear Left Both Arms Up Checkers Big Green";
        items[164] = "2-Asset Rear Left Both Arms Up Checkers Big Red Cold";
        items[165] = "2-Asset Rear Left Both Arms Up Checkers Black";
        items[166] = "2-Asset Rear Left Both Arms Up Checkers Blue";
        items[167] = "2-Asset Rear Left Both Arms Up Checkers Magenta";
        items[168] = "2-Asset Rear Left Both Arms Up Collar Sunset";
        items[169] = "2-Asset Rear Left Both Arms Up Decay Gray Dark";
        items[170] = "2-Asset Rear Left Both Arms Up Decay Pride";
        items[171] = "2-Asset Rear Left Both Arms Up Gradient Dawn";
        items[172] = "2-Asset Rear Left Both Arms Up Gradient Dusk";
        items[173] = "2-Asset Rear Left Both Arms Up Gradient Glacier";
        items[174] = "2-Asset Rear Left Both Arms Up Gradient Ice";
        items[175] = "2-Asset Rear Left Both Arms Up Gradient Pride";
        items[176] = "2-Asset Rear Left Both Arms Up Gradient Redpink";
        items[177] = "2-Asset Rear Left Both Arms Up Gradient Sunset";
        items[178] = "2-Asset Rear Left Both Arms Up Gray Scale 1";
        items[179] = "2-Asset Rear Left Both Arms Up Gray Scale 9";
        items[180] = "2-Asset Rear Left Both Arms Up Grid Simple Bege";
        items[181] = "2-Asset Rear Left Both Arms Up Ice Cold";
        items[182] = "2-Asset Rear Left Both Arms Up Lines 45 Greens";
        items[183] = "2-Asset Rear Left Both Arms Up Lines 45 Rose";
        items[184] = "2-Asset Rear Left Both Arms Up Old Shirt";
        items[185] = "2-Asset Rear Left Both Arms Up Rainbow Steps";
        items[186] = "2-Asset Rear Left Both Arms Up Robot";
        items[187] = "2-Asset Rear Left Both Arms Up Safety Vest";
        items[188] = "2-Asset Rear Left Both Arms Up Scarf Clown";
        items[189] = "2-Asset Rear Left Both Arms Up Shirt Black";
        items[190] = "2-Asset Rear Left Both Arms Up Stripes And Checks";
        items[191] = "2-Asset Rear Left Both Arms Up Stripes Big Red";
        items[192] = "2-Asset Rear Left Both Arms Up Stripes Blit";
        items[193] = "2-Asset Rear Left Both Arms Up Stripes Blue Med";
        items[194] = "2-Asset Rear Left Both Arms Up Stripes Brown";
        items[195] = "2-Asset Rear Left Both Arms Up Stripes Olive";
        items[196] = "2-Asset Rear Left Both Arms Up Stripes Red Cold";
        items[197] = "2-Asset Rear Left Both Arms Up Taxi Checkers";
        items[198] = "2-Asset Rear Left Both Arms Up Tee Yo";
        items[199] = "2-Asset Rear Left Both Arms Up Txt Ico";
        items[200] = "2-Asset Rear Left Both Arms Up Wall";
        items[201] = "2-Asset Rear Left Both Arms Up Woolweave Bicolor";
        items[202] = "2-Asset Rear Left Both Arms Up Woolweave Dirt";
        items[203] = "2-Asset Rear Left Carrot";
        items[204] = "2-Asset Rear Left Chain Logo";
        items[205] = "2-Asset Rear Left Chicken";
        items[206] = "2-Asset Rear Left Cloud";
        items[207] = "2-Asset Rear Left Clover";
        items[208] = "2-Asset Rear Left Cow";
        items[209] = "2-Asset Rear Left Dinosaur";
        items[210] = "2-Asset Rear Left Dollar Bling";
        items[211] = "2-Asset Rear Left Dragon";
        items[212] = "2-Asset Rear Left Ducky";
        items[213] = "2-Asset Rear Left Eth";
        items[214] = "2-Asset Rear Left Eye";
        items[215] = "2-Asset Rear Left Flash";
        items[216] = "2-Asset Rear Left Fries";
        items[217] = "2-Asset Rear Left Glasses";
        items[218] = "2-Asset Rear Left Glasses Logo";
        items[219] = "2-Asset Rear Left Glasses Logo Sun";
        items[220] = "2-Asset Rear Left Heart";
        items[221] = "2-Asset Rear Left Hoodiestrings Uneven";
        items[222] = "2-Asset Rear Left Id";
        items[223] = "2-Asset Rear Left Infinity";
        items[224] = "2-Asset Rear Left Insignia";
        items[225] = "2-Asset Rear Left Leaf";
        items[226] = "2-Asset Rear Left Light Bulb";
        items[227] = "2-Asset Rear Left Lp";
        items[228] = "2-Asset Rear Left Mars Face";
        items[229] = "2-Asset Rear Left Matrix White";
        items[230] = "2-Asset Rear Left Moon Block";
        items[231] = "2-Asset Rear Left None";
        items[232] = "2-Asset Rear Left Pizza Bling";
        items[233] = "2-Asset Rear Left Pocket Pencil";
        items[234] = "2-Asset Rear Left Rain";
        items[235] = "2-Asset Rear Left Rgb";
        items[236] = "2-Asset Rear Left Secret X";
        items[237] = "2-Asset Rear Left Shrimp";
        items[238] = "2-Asset Rear Left Slime Splat";
        items[239] = "2-Asset Rear Left Small Bling";
        items[240] = "2-Asset Rear Left Snowflake";
        items[241] = "2-Asset Rear Left Sparkles";
        items[242] = "2-Asset Rear Left Stains Blood";
        items[243] = "2-Asset Rear Left Stains Zombie";
        items[244] = "2-Asset Rear Left Sunset";
        items[245] = "2-Asset Rear Left Think";
        items[246] = "2-Asset Rear Left Tie Black On White";
        items[247] = "2-Asset Rear Left Tie Dye";
        items[248] = "2-Asset Rear Left Tie Purple";
        items[249] = "2-Asset Rear Left Tie Red";
        items[250] = "2-Asset Rear Left Txt A2+b2";
        items[251] = "2-Asset Rear Left Txt Cc";
        items[252] = "2-Asset Rear Left Txt Cc 2";
        items[253] = "2-Asset Rear Left Txt Copy";
        items[254] = "2-Asset Rear Left Txt Dao Black";
        items[255] = "2-Asset Rear Left Txt Doom";
        items[256] = "2-Asset Rear Left Txt Dope";
        items[257] = "2-Asset Rear Left Txt Foo Black";
        items[258] = "2-Asset Rear Left Txt Io";
        items[259] = "2-Asset Rear Left Txt Lmao";
        items[260] = "2-Asset Rear Left Txt Lol";
        items[261] = "2-Asset Rear Left Txt Mint";
        items[262] = "2-Asset Rear Left Txt Nil Grey Dark";
        items[263] = "2-Asset Rear Left Txt Noun";
        items[264] = "2-Asset Rear Left Txt Noun F0f";
        items[265] = "2-Asset Rear Left Txt Noun Green";
        items[266] = "2-Asset Rear Left Txt Noun Multicolor";
        items[267] = "2-Asset Rear Left Txt Pi";
        items[268] = "2-Asset Rear Left Txt Pop";
        items[269] = "2-Asset Rear Left Txt Rofl";
        items[270] = "2-Asset Rear Left Txt We";
        items[271] = "2-Asset Rear Left Txt Yay";
        items[272] = "2-Asset Rear Left Txt Yolo";
        items[273] = "2-Asset Rear Left Wave";
        items[274] = "2-Asset Rear Left Wet Money";
        items[275] = "2-Asset Rear Left Ying Yang";
        items[276] = "3-Asset Rear Left 1n";
        items[277] = "3-Asset Rear Left Aardvark";
        items[278] = "3-Asset Rear Left Axe";
        items[279] = "3-Asset Rear Left Belly Chamaleon";
        items[280] = "3-Asset Rear Left Bird Flying";
        items[281] = "3-Asset Rear Left Bird Side";
        items[282] = "3-Asset Rear Left Bling Anchor";
        items[283] = "3-Asset Rear Left Bling Anvil";
        items[284] = "3-Asset Rear Left Bling Arrow";
        items[285] = "3-Asset Rear Left Bling Cheese";
        items[286] = "3-Asset Rear Left Bling Gold Ingot";
        items[287] = "3-Asset Rear Left Bling Love";
        items[288] = "3-Asset Rear Left Bling Mask";
        items[289] = "3-Asset Rear Left Bling Rings";
        items[290] = "3-Asset Rear Left Bling Scissors";
        items[291] = "3-Asset Rear Left Carrot";
        items[292] = "3-Asset Rear Left Chain Logo";
        items[293] = "3-Asset Rear Left Chicken";
        items[294] = "3-Asset Rear Left Cloud";
        items[295] = "3-Asset Rear Left Clover";
        items[296] = "3-Asset Rear Left Cow";
        items[297] = "3-Asset Rear Left Dinosaur";
        items[298] = "3-Asset Rear Left Dollar Bling";
        items[299] = "3-Asset Rear Left Dragon";
        items[300] = "3-Asset Rear Left Ducky";
        items[301] = "3-Asset Rear Left Eth";
        items[302] = "3-Asset Rear Left Eye";
        items[303] = "3-Asset Rear Left Flash";
        items[304] = "3-Asset Rear Left Fries";
        items[305] = "3-Asset Rear Left Glasses";
        items[306] = "3-Asset Rear Left Glasses Logo";
        items[307] = "3-Asset Rear Left Glasses Logo Sun";
        items[308] = "3-Asset Rear Left Heart";
        items[309] = "3-Asset Rear Left Hoodiestrings Uneven";
        items[310] = "3-Asset Rear Left Id";
        items[311] = "3-Asset Rear Left Infinity";
        items[312] = "3-Asset Rear Left Insignia";
        items[313] = "3-Asset Rear Left Leaf";
        items[314] = "3-Asset Rear Left Left Arm Up Bege Bsod";
        items[315] = "3-Asset Rear Left Left Arm Up Bigwalk Blue Prime";
        items[316] = "3-Asset Rear Left Left Arm Up Bigwalk Grey Light";
        items[317] = "3-Asset Rear Left Left Arm Up Bigwalk Rainbow";
        items[318] = "3-Asset Rear Left Left Arm Up Checker Disco";
        items[319] = "3-Asset Rear Left Left Arm Up Checker Rgb";
        items[320] = "3-Asset Rear Left Left Arm Up Checker Spaced Black";
        items[321] = "3-Asset Rear Left Left Arm Up Checker Spaced White";
        items[322] = "3-Asset Rear Left Left Arm Up Checker Vibrant";
        items[323] = "3-Asset Rear Left Left Arm Up Checkers Big Green";
        items[324] = "3-Asset Rear Left Left Arm Up Checkers Big Red Cold";
        items[325] = "3-Asset Rear Left Left Arm Up Checkers Black";
        items[326] = "3-Asset Rear Left Left Arm Up Checkers Blue";
        items[327] = "3-Asset Rear Left Left Arm Up Checkers Magenta";
        items[328] = "3-Asset Rear Left Left Arm Up Collar Sunset";
        items[329] = "3-Asset Rear Left Left Arm Up Decay Gray Dark";
        items[330] = "3-Asset Rear Left Left Arm Up Decay Pride";
        items[331] = "3-Asset Rear Left Left Arm Up Gradient Dawn";
        items[332] = "3-Asset Rear Left Left Arm Up Gradient Dusk";
        items[333] = "3-Asset Rear Left Left Arm Up Gradient Glacier";
        items[334] = "3-Asset Rear Left Left Arm Up Gradient Ice";
        items[335] = "3-Asset Rear Left Left Arm Up Gradient Pride";
        items[336] = "3-Asset Rear Left Left Arm Up Gradient Redpink";
        items[337] = "3-Asset Rear Left Left Arm Up Gradient Sunset";
        items[338] = "3-Asset Rear Left Left Arm Up Gray Scale 1";
        items[339] = "3-Asset Rear Left Left Arm Up Gray Scale 9";
        items[340] = "3-Asset Rear Left Left Arm Up Grid Simple Bege";
        items[341] = "3-Asset Rear Left Left Arm Up Ice Cold";
        items[342] = "3-Asset Rear Left Left Arm Up Lines 45 Greens";
        items[343] = "3-Asset Rear Left Left Arm Up Lines 45 Rose";
        items[344] = "3-Asset Rear Left Left Arm Up Old Shirt";
        items[345] = "3-Asset Rear Left Left Arm Up Rainbow Steps";
        items[346] = "3-Asset Rear Left Left Arm Up Robot";
        items[347] = "3-Asset Rear Left Left Arm Up Safety Vest";
        items[348] = "3-Asset Rear Left Left Arm Up Scarf Clown";
        items[349] = "3-Asset Rear Left Left Arm Up Shirt Black";
        items[350] = "3-Asset Rear Left Left Arm Up Stripes And Checks";
        items[351] = "3-Asset Rear Left Left Arm Up Stripes Big Red";
        items[352] = "3-Asset Rear Left Left Arm Up Stripes Blit";
        items[353] = "3-Asset Rear Left Left Arm Up Stripes Blue Med";
        items[354] = "3-Asset Rear Left Left Arm Up Stripes Brown";
        items[355] = "3-Asset Rear Left Left Arm Up Stripes Olive";
        items[356] = "3-Asset Rear Left Left Arm Up Stripes Red Cold";
        items[357] = "3-Asset Rear Left Left Arm Up Taxi Checkers";
        items[358] = "3-Asset Rear Left Left Arm Up Tee Yo";
        items[359] = "3-Asset Rear Left Left Arm Up Txt Ico";
        items[360] = "3-Asset Rear Left Left Arm Up Wall";
        items[361] = "3-Asset Rear Left Left Arm Up Woolweave Bicolor";
        items[362] = "3-Asset Rear Left Left Arm Up Woolweave Dirt";
        items[363] = "3-Asset Rear Left Light Bulb";
        items[364] = "3-Asset Rear Left Lp";
        items[365] = "3-Asset Rear Left Mars Face";
        items[366] = "3-Asset Rear Left Matrix White";
        items[367] = "3-Asset Rear Left Moon Block";
        items[368] = "3-Asset Rear Left None";
        items[369] = "3-Asset Rear Left Pizza Bling";
        items[370] = "3-Asset Rear Left Pocket Pencil";
        items[371] = "3-Asset Rear Left Rain";
        items[372] = "3-Asset Rear Left Rgb";
        items[373] = "3-Asset Rear Left Secret X";
        items[374] = "3-Asset Rear Left Shrimp";
        items[375] = "3-Asset Rear Left Slime Splat";
        items[376] = "3-Asset Rear Left Small Bling";
        items[377] = "3-Asset Rear Left Snowflake";
        items[378] = "3-Asset Rear Left Sparkles";
        items[379] = "3-Asset Rear Left Stains Blood";
        items[380] = "3-Asset Rear Left Stains Zombie";
        items[381] = "3-Asset Rear Left Sunset";
        items[382] = "3-Asset Rear Left Think";
        items[383] = "3-Asset Rear Left Tie Black On White";
        items[384] = "3-Asset Rear Left Tie Dye";
        items[385] = "3-Asset Rear Left Tie Purple";
        items[386] = "3-Asset Rear Left Tie Red";
        items[387] = "3-Asset Rear Left Txt A2+b2";
        items[388] = "3-Asset Rear Left Txt Cc";
        items[389] = "3-Asset Rear Left Txt Cc 2";
        items[390] = "3-Asset Rear Left Txt Copy";
        items[391] = "3-Asset Rear Left Txt Dao Black";
        items[392] = "3-Asset Rear Left Txt Doom";
        items[393] = "3-Asset Rear Left Txt Dope";
        items[394] = "3-Asset Rear Left Txt Foo Black";
        items[395] = "3-Asset Rear Left Txt Io";
        items[396] = "3-Asset Rear Left Txt Lmao";
        items[397] = "3-Asset Rear Left Txt Lol";
        items[398] = "3-Asset Rear Left Txt Mint";
        items[399] = "3-Asset Rear Left Txt Nil Grey Dark";
        items[400] = "3-Asset Rear Left Txt Noun";
        items[401] = "3-Asset Rear Left Txt Noun F0f";
        items[402] = "3-Asset Rear Left Txt Noun Green";
        items[403] = "3-Asset Rear Left Txt Noun Multicolor";
        items[404] = "3-Asset Rear Left Txt Pi";
        items[405] = "3-Asset Rear Left Txt Pop";
        items[406] = "3-Asset Rear Left Txt Rofl";
        items[407] = "3-Asset Rear Left Txt We";
        items[408] = "3-Asset Rear Left Txt Yay";
        items[409] = "3-Asset Rear Left Txt Yolo";
        items[410] = "3-Asset Rear Left Wave";
        items[411] = "3-Asset Rear Left Wet Money";
        items[412] = "3-Asset Rear Left Ying Yang";
        items[413] = "4-Asset Rear Left 1n";
        items[414] = "4-Asset Rear Left Aardvark";
        items[415] = "4-Asset Rear Left Axe";
        items[416] = "4-Asset Rear Left Belly Chamaleon";
        items[417] = "4-Asset Rear Left Bird Flying";
        items[418] = "4-Asset Rear Left Bird Side";
        items[419] = "4-Asset Rear Left Bling Anchor";
        items[420] = "4-Asset Rear Left Bling Anvil";
        items[421] = "4-Asset Rear Left Bling Arrow";
        items[422] = "4-Asset Rear Left Bling Cheese";
        items[423] = "4-Asset Rear Left Bling Gold Ingot";
        items[424] = "4-Asset Rear Left Bling Love";
        items[425] = "4-Asset Rear Left Bling Mask";
        items[426] = "4-Asset Rear Left Bling Rings";
        items[427] = "4-Asset Rear Left Bling Scissors";
        items[428] = "4-Asset Rear Left Carrot";
        items[429] = "4-Asset Rear Left Chain Logo";
        items[430] = "4-Asset Rear Left Chicken";
        items[431] = "4-Asset Rear Left Cloud";
        items[432] = "4-Asset Rear Left Clover";
        items[433] = "4-Asset Rear Left Cow";
        items[434] = "4-Asset Rear Left Dinosaur";
        items[435] = "4-Asset Rear Left Dollar Bling";
        items[436] = "4-Asset Rear Left Dragon";
        items[437] = "4-Asset Rear Left Ducky";
        items[438] = "4-Asset Rear Left Eth";
        items[439] = "4-Asset Rear Left Eye";
        items[440] = "4-Asset Rear Left Flash";
        items[441] = "4-Asset Rear Left Fries";
        items[442] = "4-Asset Rear Left Glasses";
        items[443] = "4-Asset Rear Left Glasses Logo";
        items[444] = "4-Asset Rear Left Glasses Logo Sun";
        items[445] = "4-Asset Rear Left Heart";
        items[446] = "4-Asset Rear Left Hoodiestrings Uneven";
        items[447] = "4-Asset Rear Left Id";
        items[448] = "4-Asset Rear Left Infinity";
        items[449] = "4-Asset Rear Left Insignia";
        items[450] = "4-Asset Rear Left Leaf";
        items[451] = "4-Asset Rear Left Light Bulb";
        items[452] = "4-Asset Rear Left Lp";
        items[453] = "4-Asset Rear Left Mars Face";
        items[454] = "4-Asset Rear Left Matrix White";
        items[455] = "4-Asset Rear Left Moon Block";
        items[456] = "4-Asset Rear Left None";
        items[457] = "4-Asset Rear Left Pizza Bling";
        items[458] = "4-Asset Rear Left Pocket Pencil";
        items[459] = "4-Asset Rear Left Rain";
        items[460] = "4-Asset Rear Left Rgb";
        items[461] = "4-Asset Rear Left Right Arm Up Bege Bsod";
        items[462] = "4-Asset Rear Left Right Arm Up Bigwalk Blue Prime";
        items[463] = "4-Asset Rear Left Right Arm Up Bigwalk Grey Light";
        items[464] = "4-Asset Rear Left Right Arm Up Bigwalk Rainbow";
        items[465] = "4-Asset Rear Left Right Arm Up Checker Disco";
        items[466] = "4-Asset Rear Left Right Arm Up Checker Rgb";
        items[467] = "4-Asset Rear Left Right Arm Up Checker Spaced Black";
        items[468] = "4-Asset Rear Left Right Arm Up Checker Spaced White";
        items[469] = "4-Asset Rear Left Right Arm Up Checkers Big Green";
        items[470] = "4-Asset Rear Left Right Arm Up Checkers Big Red Cold";
        items[471] = "4-Asset Rear Left Right Arm Up Checkers Black";
        items[472] = "4-Asset Rear Left Right Arm Up Checkers Blue";
        items[473] = "4-Asset Rear Left Right Arm Up Checkers Magenta";
        items[474] = "4-Asset Rear Left Right Arm Up Checkers Vibrant";
        items[475] = "4-Asset Rear Left Right Arm Up Collar Sunset";
        items[476] = "4-Asset Rear Left Right Arm Up Decay Gray Dark";
        items[477] = "4-Asset Rear Left Right Arm Up Decay Pride";
        items[478] = "4-Asset Rear Left Right Arm Up Gradient Dawn";
        items[479] = "4-Asset Rear Left Right Arm Up Gradient Dusk";
        items[480] = "4-Asset Rear Left Right Arm Up Gradient Glacier";
        items[481] = "4-Asset Rear Left Right Arm Up Gradient Ice";
        items[482] = "4-Asset Rear Left Right Arm Up Gradient Pride";
        items[483] = "4-Asset Rear Left Right Arm Up Gradient Redpink";
        items[484] = "4-Asset Rear Left Right Arm Up Gradient Sunset";
        items[485] = "4-Asset Rear Left Right Arm Up Gray Scale 1";
        items[486] = "4-Asset Rear Left Right Arm Up Gray Scale 9";
        items[487] = "4-Asset Rear Left Right Arm Up Grid Simple Bege";
        items[488] = "4-Asset Rear Left Right Arm Up Ice Cold";
        items[489] = "4-Asset Rear Left Right Arm Up Lines 45 Greens";
        items[490] = "4-Asset Rear Left Right Arm Up Lines 45 Rose";
        items[491] = "4-Asset Rear Left Right Arm Up Old Shirt";
        items[492] = "4-Asset Rear Left Right Arm Up Rainbow Steps";
        items[493] = "4-Asset Rear Left Right Arm Up Robot";
        items[494] = "4-Asset Rear Left Right Arm Up Safety Vest";
        items[495] = "4-Asset Rear Left Right Arm Up Scarf Clown";
        items[496] = "4-Asset Rear Left Right Arm Up Shirt Black";
        items[497] = "4-Asset Rear Left Right Arm Up Stripes And Checks";
        items[498] = "4-Asset Rear Left Right Arm Up Stripes Big Red";
        items[499] = "4-Asset Rear Left Right Arm Up Stripes Blit";
        items[500] = "4-Asset Rear Left Right Arm Up Stripes Blue Med";
        items[501] = "4-Asset Rear Left Right Arm Up Stripes Brown";
        items[502] = "4-Asset Rear Left Right Arm Up Stripes Olive";
        items[503] = "4-Asset Rear Left Right Arm Up Stripes Red Cold";
        items[504] = "4-Asset Rear Left Right Arm Up Taxi Checkers";
        items[505] = "4-Asset Rear Left Right Arm Up Tee Yo";
        items[506] = "4-Asset Rear Left Right Arm Up Txt Ico";
        items[507] = "4-Asset Rear Left Right Arm Up Wall";
        items[508] = "4-Asset Rear Left Right Arm Up Woolweave Bicolor";
        items[509] = "4-Asset Rear Left Right Arm Up Woolweave Dirt";
        items[510] = "4-Asset Rear Left Secret X";
        items[511] = "4-Asset Rear Left Shrimp";
        items[512] = "4-Asset Rear Left Slime Splat";
        items[513] = "4-Asset Rear Left Small Bling";
        items[514] = "4-Asset Rear Left Snowflake";
        items[515] = "4-Asset Rear Left Sparkles";
        items[516] = "4-Asset Rear Left Stains Blood";
        items[517] = "4-Asset Rear Left Stains Zombie";
        items[518] = "4-Asset Rear Left Sunset";
        items[519] = "4-Asset Rear Left Think";
        items[520] = "4-Asset Rear Left Tie Black On White";
        items[521] = "4-Asset Rear Left Tie Dye";
        items[522] = "4-Asset Rear Left Tie Purple";
        items[523] = "4-Asset Rear Left Tie Red";
        items[524] = "4-Asset Rear Left Txt A2+b2";
        items[525] = "4-Asset Rear Left Txt Cc";
        items[526] = "4-Asset Rear Left Txt Cc 2";
        items[527] = "4-Asset Rear Left Txt Copy";
        items[528] = "4-Asset Rear Left Txt Dao Black";
        items[529] = "4-Asset Rear Left Txt Doom";
        items[530] = "4-Asset Rear Left Txt Dope";
        items[531] = "4-Asset Rear Left Txt Foo Black";
        items[532] = "4-Asset Rear Left Txt Io";
        items[533] = "4-Asset Rear Left Txt Lmao";
        items[534] = "4-Asset Rear Left Txt Lol";
        items[535] = "4-Asset Rear Left Txt Mint";
        items[536] = "4-Asset Rear Left Txt Nil Grey Dark";
        items[537] = "4-Asset Rear Left Txt Noun";
        items[538] = "4-Asset Rear Left Txt Noun F0f";
        items[539] = "4-Asset Rear Left Txt Noun Green";
        items[540] = "4-Asset Rear Left Txt Noun Multicolor";
        items[541] = "4-Asset Rear Left Txt Pi";
        items[542] = "4-Asset Rear Left Txt Pop";
        items[543] = "4-Asset Rear Left Txt Rofl";
        items[544] = "4-Asset Rear Left Txt We";
        items[545] = "4-Asset Rear Left Txt Yay";
        items[546] = "4-Asset Rear Left Txt Yolo";
        items[547] = "4-Asset Rear Left Wave";
        items[548] = "4-Asset Rear Left Wet Money";
        items[549] = "4-Asset Rear Left Ying Yang";

        bytes memory data = abi.encode(items);

        VmSafe vm = VmSafe(
            address(uint160(uint256(keccak256("hevm cheat code"))))
        );

        string[] memory inputs = new string[](3);
        inputs[0] = "node";
        inputs[1] = "script/nouns-coasters/deflate.js";
        inputs[2] = vm.toString(data);

        bytes memory compressedData = vm.ffi(inputs);

        // address result = SSTORE2.write(compressedData);

        renderer.addLayer({
            target: target,
            ipfs: INounsCoasterMetadataRendererTypes.IPFSGroup({
                baseUri: "ipfs://bafybeiag26lh2at7iah5xqlrzgj2ei2jd2qel3g5bpccgfj5ktjbvu4qm4/",
                extension: ".png"
            }),
            decompressedSize: data.length,
            compressedData: compressedData,
            count: items.length,
            property: "6 Accessories rear left",
            variantProperty: variantPropertyParameters
        });
    }

    function addLayer7(NounsCoasterMetadataRenderer renderer, address target)
        internal
    {
        // 7 Head rear left
        INounsCoasterMetadataRendererTypes.VariantPropertyParameters
            memory variantPropertyParameters;
        variantPropertyParameters
            .offsets = new INounsCoasterMetadataRendererTypes.VariantOffset[](
            0
        );
        variantPropertyParameters.id = 0;
        variantPropertyParameters.count = 0;

        string[] memory items = new string[](940);
        items[0] = "Aardvark Bored";
        items[1] = "Aardvark Happy";
        items[2] = "Aardvark Scared";
        items[3] = "Aardvark Sick";
        items[4] = "Abstract Bored";
        items[5] = "Abstract Happy";
        items[6] = "Abstract Scared";
        items[7] = "Abstract Sick";
        items[8] = "Ape Bored";
        items[9] = "Ape Happy";
        items[10] = "Ape Scared";
        items[11] = "Ape Sick";
        items[12] = "Bag Bored";
        items[13] = "Bag Happy";
        items[14] = "Bag Scared";
        items[15] = "Bag Sick";
        items[16] = "Bagpipe Bored";
        items[17] = "Bagpipe Happy";
        items[18] = "Bagpipe Scared";
        items[19] = "Bagpipe Sick";
        items[20] = "Banana Bored";
        items[21] = "Banana Happy";
        items[22] = "Banana Scared";
        items[23] = "Banana Sick";
        items[24] = "Bank Bored";
        items[25] = "Bank Happy";
        items[26] = "Bank Scared";
        items[27] = "Bank Sick";
        items[28] = "Baseball Gameball Bored";
        items[29] = "Baseball Gameball Happy";
        items[30] = "Baseball Gameball Scared";
        items[31] = "Baseball Gameball Sick";
        items[32] = "Bat Bored";
        items[33] = "Bat Happy";
        items[34] = "Bat Scared";
        items[35] = "Bat Sick";
        items[36] = "Bear Bored";
        items[37] = "Bear Happy";
        items[38] = "Bear Scared";
        items[39] = "Bear Sick";
        items[40] = "Beer Bored";
        items[41] = "Beer Happy";
        items[42] = "Beer Scared";
        items[43] = "Beer Sick";
        items[44] = "Beet Bored";
        items[45] = "Beet Happy";
        items[46] = "Beet Scared";
        items[47] = "Beet Sick";
        items[48] = "Bell Bored";
        items[49] = "Bell Happy";
        items[50] = "Bell Scared";
        items[51] = "Bell Sick";
        items[52] = "Bigfoot Bored";
        items[53] = "Bigfoot Happy";
        items[54] = "Bigfoot Scared";
        items[55] = "Bigfoot Sick";
        items[56] = "Bigfoot Yeti Bored";
        items[57] = "Bigfoot Yeti Happy";
        items[58] = "Bigfoot Yeti Scared";
        items[59] = "Bigfoot Yeti Sick";
        items[60] = "Blackhole Bored";
        items[61] = "Blackhole Happy";
        items[62] = "Blackhole Scared";
        items[63] = "Blackhole Sick";
        items[64] = "Blueberry Bored";
        items[65] = "Blueberry Happy";
        items[66] = "Blueberry Scared";
        items[67] = "Blueberry Sick";
        items[68] = "Bomb Bored";
        items[69] = "Bomb Happy";
        items[70] = "Bomb Scared";
        items[71] = "Bomb Sick";
        items[72] = "Bonsai Bored";
        items[73] = "Bonsai Happy";
        items[74] = "Bonsai Scared";
        items[75] = "Bonsai Sick";
        items[76] = "Boombox Bored";
        items[77] = "Boombox Happy";
        items[78] = "Boombox Scared";
        items[79] = "Boombox Sick";
        items[80] = "Boot Bored";
        items[81] = "Boot Happy";
        items[82] = "Boot Scared";
        items[83] = "Boot Sick";
        items[84] = "Box Bored";
        items[85] = "Box Happy";
        items[86] = "Box Scared";
        items[87] = "Box Sick";
        items[88] = "Boxingglove Bored";
        items[89] = "Boxingglove Happy";
        items[90] = "Boxingglove Scared";
        items[91] = "Boxingglove Sick";
        items[92] = "Brain Bored";
        items[93] = "Brain Happy";
        items[94] = "Brain Scared";
        items[95] = "Brain Sick";
        items[96] = "Bubble Speech Bored";
        items[97] = "Bubble Speech Happy";
        items[98] = "Bubble Speech Scared";
        items[99] = "Bubble Speech Sick";
        items[100] = "Bubblegum Bored";
        items[101] = "Bubblegum Happy";
        items[102] = "Bubblegum Scared";
        items[103] = "Bubblegum Sick";
        items[104] = "Burger Dollarmenu Bored";
        items[105] = "Burger Dollarmenu Happy";
        items[106] = "Burger Dollarmenu Scared";
        items[107] = "Burger Dollarmenu Sick";
        items[108] = "Cake Bored";
        items[109] = "Cake Happy";
        items[110] = "Cake Scared";
        items[111] = "Cake Sick";
        items[112] = "Calculator Bored";
        items[113] = "Calculator Happy";
        items[114] = "Calculator Scared";
        items[115] = "Calculator Sick";
        items[116] = "Calendar Bored";
        items[117] = "Calendar Happy";
        items[118] = "Calendar Scared";
        items[119] = "Calendar Sick";
        items[120] = "Camcorder Bored";
        items[121] = "Camcorder Happy";
        items[122] = "Camcorder Scared";
        items[123] = "Camcorder Sick";
        items[124] = "Candy Bar Bored";
        items[125] = "Candy Bar Happy";
        items[126] = "Candy Bar Scared";
        items[127] = "Candy Bar Sick";
        items[128] = "Cannedham Bored";
        items[129] = "Cannedham Happy";
        items[130] = "Cannedham Scared";
        items[131] = "Cannedham Sick";
        items[132] = "Car Bored";
        items[133] = "Car Happy";
        items[134] = "Car Scared";
        items[135] = "Car Sick";
        items[136] = "Cash Register Bored";
        items[137] = "Cash Register Happy";
        items[138] = "Cash Register Scared";
        items[139] = "Cash Register Sick";
        items[140] = "Cassettetape Bored";
        items[141] = "Cassettetape Happy";
        items[142] = "Cassettetape Scared";
        items[143] = "Cassettetape Sick";
        items[144] = "Cat Bored";
        items[145] = "Cat Happy";
        items[146] = "Cat Scared";
        items[147] = "Cat Sick";
        items[148] = "Cd Bored";
        items[149] = "Cd Happy";
        items[150] = "Cd Scared";
        items[151] = "Cd Sick";
        items[152] = "Chain Bored";
        items[153] = "Chain Happy";
        items[154] = "Chain Scared";
        items[155] = "Chain Sick";
        items[156] = "Chainsaw Bored";
        items[157] = "Chainsaw Happy";
        items[158] = "Chainsaw Scared";
        items[159] = "Chainsaw Sick";
        items[160] = "Chameleon Bored";
        items[161] = "Chameleon Happy";
        items[162] = "Chameleon Scared";
        items[163] = "Chameleon Sick";
        items[164] = "Chart Bars Bored";
        items[165] = "Chart Bars Happy";
        items[166] = "Chart Bars Scared";
        items[167] = "Chart Bars Sick";
        items[168] = "Cheese Bored";
        items[169] = "Cheese Happy";
        items[170] = "Cheese Scared";
        items[171] = "Cheese Sick";
        items[172] = "Chefhat Bored";
        items[173] = "Chefhat Happy";
        items[174] = "Chefhat Scared";
        items[175] = "Chefhat Sick";
        items[176] = "Cherry Bored";
        items[177] = "Cherry Happy";
        items[178] = "Cherry Scared";
        items[179] = "Cherry Sick";
        items[180] = "Chicken Bored";
        items[181] = "Chicken Happy";
        items[182] = "Chicken Scared";
        items[183] = "Chicken Sick";
        items[184] = "Chipboard Bored";
        items[185] = "Chipboard Happy";
        items[186] = "Chipboard Scared";
        items[187] = "Chipboard Sick";
        items[188] = "Chips Bored";
        items[189] = "Chips Happy";
        items[190] = "Chips Scared";
        items[191] = "Chips Sick";
        items[192] = "Cloud Bored";
        items[193] = "Cloud Happy";
        items[194] = "Cloud Scared";
        items[195] = "Cloud Sick";
        items[196] = "Clover Bored";
        items[197] = "Clover Happy";
        items[198] = "Clover Scared";
        items[199] = "Clover Sick";
        items[200] = "Clutch Bored";
        items[201] = "Clutch Happy";
        items[202] = "Clutch Scared";
        items[203] = "Clutch Sick";
        items[204] = "Coffeebean Bored";
        items[205] = "Coffeebean Happy";
        items[206] = "Coffeebean Scared";
        items[207] = "Coffeebean Sick";
        items[208] = "Cone Bored";
        items[209] = "Cone Happy";
        items[210] = "Cone Scared";
        items[211] = "Cone Sick";
        items[212] = "Console Handheld Bored";
        items[213] = "Console Handheld Happy";
        items[214] = "Console Handheld Scared";
        items[215] = "Console Handheld Sick";
        items[216] = "Cookie Bored";
        items[217] = "Cookie Happy";
        items[218] = "Cookie Scared";
        items[219] = "Cookie Sick";
        items[220] = "Cordlessphone Bored";
        items[221] = "Cordlessphone Happy";
        items[222] = "Cordlessphone Scared";
        items[223] = "Cordlessphone Sick";
        items[224] = "Cottonball Bored";
        items[225] = "Cottonball Happy";
        items[226] = "Cottonball Scared";
        items[227] = "Cottonball Sick";
        items[228] = "Couch Bored";
        items[229] = "Couch Happy";
        items[230] = "Couch Scared";
        items[231] = "Couch Sick";
        items[232] = "Cow Bored";
        items[233] = "Cow Happy";
        items[234] = "Cow Scared";
        items[235] = "Cow Sick";
        items[236] = "Crab Bored";
        items[237] = "Crab Happy";
        items[238] = "Crab Scared";
        items[239] = "Crab Sick";
        items[240] = "Crane Bored";
        items[241] = "Crane Happy";
        items[242] = "Crane Scared";
        items[243] = "Crane Sick";
        items[244] = "Croc Hat Bored";
        items[245] = "Croc Hat Happy";
        items[246] = "Croc Hat Scared";
        items[247] = "Croc Hat Sick";
        items[248] = "Crown Bored";
        items[249] = "Crown Happy";
        items[250] = "Crown Scared";
        items[251] = "Crown Sick";
        items[252] = "Crt Bsod Bored";
        items[253] = "Crt Bsod Happy";
        items[254] = "Crt Bsod Scared";
        items[255] = "Crt Bsod Sick";
        items[256] = "Crystallball Bored";
        items[257] = "Crystallball Happy";
        items[258] = "Crystallball Scared";
        items[259] = "Crystallball Sick";
        items[260] = "Diamond Blue Bored";
        items[261] = "Diamond Blue Happy";
        items[262] = "Diamond Blue Scared";
        items[263] = "Diamond Blue Sick";
        items[264] = "Diamond Red Bored";
        items[265] = "Diamond Red Happy";
        items[266] = "Diamond Red Scared";
        items[267] = "Diamond Red Sick";
        items[268] = "Dictionary Bored";
        items[269] = "Dictionary Happy";
        items[270] = "Dictionary Scared";
        items[271] = "Dictionary Sick";
        items[272] = "Dino Bored";
        items[273] = "Dino Happy";
        items[274] = "Dino Scared";
        items[275] = "Dino Sick";
        items[276] = "Dna Bored";
        items[277] = "Dna Happy";
        items[278] = "Dna Scared";
        items[279] = "Dna Sick";
        items[280] = "Dog Bored";
        items[281] = "Dog Happy";
        items[282] = "Dog Scared";
        items[283] = "Dog Sick";
        items[284] = "Doughnut Bored";
        items[285] = "Doughnut Happy";
        items[286] = "Doughnut Scared";
        items[287] = "Doughnut Sick";
        items[288] = "Drill Bored";
        items[289] = "Drill Happy";
        items[290] = "Drill Scared";
        items[291] = "Drill Sick";
        items[292] = "Duck Bored";
        items[293] = "Duck Happy";
        items[294] = "Duck Scared";
        items[295] = "Duck Sick";
        items[296] = "Ducky Bored";
        items[297] = "Ducky Happy";
        items[298] = "Ducky Scared";
        items[299] = "Ducky Sick";
        items[300] = "Earth Bored";
        items[301] = "Earth Happy";
        items[302] = "Earth Scared";
        items[303] = "Earth Sick";
        items[304] = "Egg Bored";
        items[305] = "Egg Happy";
        items[306] = "Egg Scared";
        items[307] = "Egg Sick";
        items[308] = "Faberge Bored";
        items[309] = "Faberge Happy";
        items[310] = "Faberge Scared";
        items[311] = "Faberge Sick";
        items[312] = "Factory Dark Bored";
        items[313] = "Factory Dark Happy";
        items[314] = "Factory Dark Scared";
        items[315] = "Factory Dark Sick";
        items[316] = "Fan Bored";
        items[317] = "Fan Happy";
        items[318] = "Fan Scared";
        items[319] = "Fan Sick";
        items[320] = "Fence Bored";
        items[321] = "Fence Happy";
        items[322] = "Fence Scared";
        items[323] = "Fence Sick";
        items[324] = "Film 35mm Bored";
        items[325] = "Film 35mm Happy";
        items[326] = "Film 35mm Scared";
        items[327] = "Film 35mm Sick";
        items[328] = "Film Strip Bored";
        items[329] = "Film Strip Happy";
        items[330] = "Film Strip Scared";
        items[331] = "Film Strip Sick";
        items[332] = "Fir Bored";
        items[333] = "Fir Happy";
        items[334] = "Fir Scared";
        items[335] = "Fir Sick";
        items[336] = "Firehydrant Bored";
        items[337] = "Firehydrant Happy";
        items[338] = "Firehydrant Scared";
        items[339] = "Firehydrant Sick";
        items[340] = "Flamingo Bored";
        items[341] = "Flamingo Happy";
        items[342] = "Flamingo Scared";
        items[343] = "Flamingo Sick";
        items[344] = "Flower Bored";
        items[345] = "Flower Happy";
        items[346] = "Flower Scared";
        items[347] = "Flower Sick";
        items[348] = "Fox Bored";
        items[349] = "Fox Happy";
        items[350] = "Fox Scared";
        items[351] = "Fox Sick";
        items[352] = "Frog Bored";
        items[353] = "Frog Happy";
        items[354] = "Frog Scared";
        items[355] = "Frog Sick";
        items[356] = "Garlic Bored";
        items[357] = "Garlic Happy";
        items[358] = "Garlic Scared";
        items[359] = "Garlic Sick";
        items[360] = "Gavel Bored";
        items[361] = "Gavel Happy";
        items[362] = "Gavel Scared";
        items[363] = "Gavel Sick";
        items[364] = "Ghost B Bored";
        items[365] = "Ghost B Happy";
        items[366] = "Ghost B Scared";
        items[367] = "Ghost B Sick";
        items[368] = "Glasses Big Bored";
        items[369] = "Glasses Big Happy";
        items[370] = "Glasses Big Scared";
        items[371] = "Glasses Big Sick";
        items[372] = "Gnomes Bored";
        items[373] = "Gnomes Happy";
        items[374] = "Gnomes Scared";
        items[375] = "Gnomes Sick";
        items[376] = "Goat Bored";
        items[377] = "Goat Happy";
        items[378] = "Goat Scared";
        items[379] = "Goat Sick";
        items[380] = "Goldcoin Bored";
        items[381] = "Goldcoin Happy";
        items[382] = "Goldcoin Scared";
        items[383] = "Goldcoin Sick";
        items[384] = "Goldfish Bored";
        items[385] = "Goldfish Happy";
        items[386] = "Goldfish Scared";
        items[387] = "Goldfish Sick";
        items[388] = "Grouper Bored";
        items[389] = "Grouper Happy";
        items[390] = "Grouper Scared";
        items[391] = "Grouper Sick";
        items[392] = "Hair Bored";
        items[393] = "Hair Happy";
        items[394] = "Hair Scared";
        items[395] = "Hair Sick";
        items[396] = "Hanger Bored";
        items[397] = "Hanger Happy";
        items[398] = "Hanger Scared";
        items[399] = "Hanger Sick";
        items[400] = "Hardhat Bored";
        items[401] = "Hardhat Happy";
        items[402] = "Hardhat Scared";
        items[403] = "Hardhat Sick";
        items[404] = "Heart Bored";
        items[405] = "Heart Happy";
        items[406] = "Heart Scared";
        items[407] = "Heart Sick";
        items[408] = "Helicopter Bored";
        items[409] = "Helicopter Happy";
        items[410] = "Helicopter Scared";
        items[411] = "Helicopter Sick";
        items[412] = "Highheel Bored";
        items[413] = "Highheel Happy";
        items[414] = "Highheel Scared";
        items[415] = "Highheel Sick";
        items[416] = "Hockeypuck Bored";
        items[417] = "Hockeypuck Happy";
        items[418] = "Hockeypuck Scared";
        items[419] = "Hockeypuck Sick";
        items[420] = "Horse Deepfried Bored";
        items[421] = "Horse Deepfried Happy";
        items[422] = "Horse Deepfried Scared";
        items[423] = "Horse Deepfried Sick";
        items[424] = "Hotdog Bored";
        items[425] = "Hotdog Happy";
        items[426] = "Hotdog Scared";
        items[427] = "Hotdog Sick";
        items[428] = "House Bored";
        items[429] = "House Happy";
        items[430] = "House Scared";
        items[431] = "House Sick";
        items[432] = "Icepop B Bored";
        items[433] = "Icepop B Happy";
        items[434] = "Icepop B Scared";
        items[435] = "Icepop B Sick";
        items[436] = "Igloo Bored";
        items[437] = "Igloo Happy";
        items[438] = "Igloo Scared";
        items[439] = "Igloo Sick";
        items[440] = "Island Bored";
        items[441] = "Island Happy";
        items[442] = "Island Scared";
        items[443] = "Island Sick";
        items[444] = "Jellyfish Bored";
        items[445] = "Jellyfish Happy";
        items[446] = "Jellyfish Scared";
        items[447] = "Jellyfish Sick";
        items[448] = "Jupiter Bored";
        items[449] = "Jupiter Happy";
        items[450] = "Jupiter Scared";
        items[451] = "Jupiter Sick";
        items[452] = "Kangaroo Bored";
        items[453] = "Kangaroo Happy";
        items[454] = "Kangaroo Scared";
        items[455] = "Kangaroo Sick";
        items[456] = "Ketchup Bored";
        items[457] = "Ketchup Happy";
        items[458] = "Ketchup Scared";
        items[459] = "Ketchup Sick";
        items[460] = "Laptop Bored";
        items[461] = "Laptop Happy";
        items[462] = "Laptop Scared";
        items[463] = "Laptop Sick";
        items[464] = "Lightning Bolt Bored";
        items[465] = "Lightning Bolt Happy";
        items[466] = "Lightning Bolt Scared";
        items[467] = "Lightning Sick";
        items[468] = "Lint Bored";
        items[469] = "Lint Happy";
        items[470] = "Lint Scared";
        items[471] = "Lint Sick";
        items[472] = "Lips Bored";
        items[473] = "Lips Happy";
        items[474] = "Lips Scared";
        items[475] = "Lips Sick";
        items[476] = "Lipstick2 Bored";
        items[477] = "Lipstick2 Happy";
        items[478] = "Lipstick2 Scared";
        items[479] = "Lipstick2 Sick";
        items[480] = "Lock Bored";
        items[481] = "Lock Happy";
        items[482] = "Lock Scared";
        items[483] = "Lock Sick";
        items[484] = "Macaroni Bored";
        items[485] = "Macaroni Happy";
        items[486] = "Macaroni Scared";
        items[487] = "Macaroni Sick";
        items[488] = "Mailbox Bored";
        items[489] = "Mailbox Happy";
        items[490] = "Mailbox Scared";
        items[491] = "Mailbox Sick";
        items[492] = "Maze Bored";
        items[493] = "Maze Happy";
        items[494] = "Maze Scared";
        items[495] = "Maze Sick";
        items[496] = "Microwave Bored";
        items[497] = "Microwave Happy";
        items[498] = "Microwave Scared";
        items[499] = "Microwave Sick";
        items[500] = "Milk Bored";
        items[501] = "Milk Happy";
        items[502] = "Milk Scared";
        items[503] = "Milk Sick";
        items[504] = "Mirror Bored";
        items[505] = "Mirror Happy";
        items[506] = "Mirror Scared";
        items[507] = "Mirror Sick";
        items[508] = "Mixer Bored";
        items[509] = "Mixer Happy";
        items[510] = "Mixer Scared";
        items[511] = "Mixer Sick";
        items[512] = "Moon Bored";
        items[513] = "Moon Happy";
        items[514] = "Moon Scared";
        items[515] = "Moon Sick";
        items[516] = "Moose Bored";
        items[517] = "Moose Happy";
        items[518] = "Moose Scared";
        items[519] = "Moose Sick";
        items[520] = "Mosquito Bored";
        items[521] = "Mosquito Happy";
        items[522] = "Mosquito Scared";
        items[523] = "Mosquito Sick";
        items[524] = "Mountain Snowcap Bored";
        items[525] = "Mountain Snowcap Happy";
        items[526] = "Mountain Snowcap Scared";
        items[527] = "Mountain Snowcap Sick";
        items[528] = "Mouse Bored";
        items[529] = "Mouse Happy";
        items[530] = "Mouse Scared";
        items[531] = "Mouse Sick";
        items[532] = "Mug Bored";
        items[533] = "Mug Happy";
        items[534] = "Mug Scared";
        items[535] = "Mug Sick";
        items[536] = "Mushroom Bored";
        items[537] = "Mushroom Happy";
        items[538] = "Mushroom Scared";
        items[539] = "Mushroom Sick";
        items[540] = "Mustard Bored";
        items[541] = "Mustard Happy";
        items[542] = "Mustard Scared";
        items[543] = "Mustard Sick";
        items[544] = "Nigiri Bored";
        items[545] = "Nigiri Happy";
        items[546] = "Nigiri Scared";
        items[547] = "Nigiri Sick";
        items[548] = "Noodles Bored";
        items[549] = "Noodles Happy";
        items[550] = "Noodles Scared";
        items[551] = "Noodles Sick";
        items[552] = "Onion Bored";
        items[553] = "Onion Happy";
        items[554] = "Onion Scared";
        items[555] = "Onion Sick";
        items[556] = "Orangutan Bored";
        items[557] = "Orangutan Happy";
        items[558] = "Orangutan Scared";
        items[559] = "Orangutan Sick";
        items[560] = "Orca Bored";
        items[561] = "Orca Happy";
        items[562] = "Orca Scared";
        items[563] = "Orca Sick";
        items[564] = "Otter Bored";
        items[565] = "Otter Happy";
        items[566] = "Otter Scared";
        items[567] = "Otter Sick";
        items[568] = "Outlet Bored";
        items[569] = "Outlet Happy";
        items[570] = "Outlet Scared";
        items[571] = "Outlet Sick";
        items[572] = "Owl Bored";
        items[573] = "Owl Happy";
        items[574] = "Owl Scared";
        items[575] = "Owl Sick";
        items[576] = "Oyster Bored";
        items[577] = "Oyster Happy";
        items[578] = "Oyster Scared";
        items[579] = "Oyster Sick";
        items[580] = "Paintbrush Bored";
        items[581] = "Paintbrush Happy";
        items[582] = "Paintbrush Scared";
        items[583] = "Paintbrush Sick";
        items[584] = "Panda Bored";
        items[585] = "Panda Happy";
        items[586] = "Panda Scared";
        items[587] = "Panda Sick";
        items[588] = "Paperclip Bored";
        items[589] = "Paperclip Happy";
        items[590] = "Paperclip Scared";
        items[591] = "Paperclip Sick";
        items[592] = "Peanut Bored";
        items[593] = "Peanut Happy";
        items[594] = "Peanut Scared";
        items[595] = "Peanut Sick";
        items[596] = "Pencil Tip Bored";
        items[597] = "Pencil Tip Happy";
        items[598] = "Pencil Tip Scared";
        items[599] = "Pencil Tip Sick";
        items[600] = "Peyote Bored";
        items[601] = "Peyote Happy";
        items[602] = "Peyote Scared";
        items[603] = "Peyote Sick";
        items[604] = "Piano Bored";
        items[605] = "Piano Happy";
        items[606] = "Piano Scared";
        items[607] = "Piano Sick";
        items[608] = "Pickle Bored";
        items[609] = "Pickle Happy";
        items[610] = "Pickle Scared";
        items[611] = "Pickle Sick";
        items[612] = "Pie Bored";
        items[613] = "Pie Happy";
        items[614] = "Pie Scared";
        items[615] = "Pie Sick";
        items[616] = "Piggybank Bored";
        items[617] = "Piggybank Happy";
        items[618] = "Piggybank Scared";
        items[619] = "Piggybank Sick";
        items[620] = "Pill Bored";
        items[621] = "Pill Happy";
        items[622] = "Pill Scared";
        items[623] = "Pill Sick";
        items[624] = "Pillow Bored";
        items[625] = "Pillow Happy";
        items[626] = "Pillow Scared";
        items[627] = "Pillow Sick";
        items[628] = "Pineapple Bored";
        items[629] = "Pineapple Happy";
        items[630] = "Pineapple Scared";
        items[631] = "Pineapple Sick";
        items[632] = "Pipe Bored";
        items[633] = "Pipe Happy";
        items[634] = "Pipe Scared";
        items[635] = "Pipe Sick";
        items[636] = "Pirateship Bored";
        items[637] = "Pirateship Happy";
        items[638] = "Pirateship Scared";
        items[639] = "Pirateship Sick";
        items[640] = "Pizza Bored";
        items[641] = "Pizza Happy";
        items[642] = "Pizza Scared";
        items[643] = "Pizza Sick";
        items[644] = "Plane Bored";
        items[645] = "Plane Happy";
        items[646] = "Plane Scared";
        items[647] = "Plane Sick";
        items[648] = "Pop Bored";
        items[649] = "Pop Happy";
        items[650] = "Pop Scared";
        items[651] = "Pop Sick";
        items[652] = "Porkbao Bored";
        items[653] = "Porkbao Happy";
        items[654] = "Porkbao Scared";
        items[655] = "Porkbao Sick";
        items[656] = "Pufferfish Bored";
        items[657] = "Pufferfish Happy";
        items[658] = "Pufferfish Scared";
        items[659] = "Pufferfish Sick";
        items[660] = "Pumpkin Bored";
        items[661] = "Pumpkin Happy";
        items[662] = "Pumpkin Scared";
        items[663] = "Pumpkin Sick";
        items[664] = "Pyramid Bored";
        items[665] = "Pyramid Happy";
        items[666] = "Pyramid Scared";
        items[667] = "Pyramid Sick";
        items[668] = "Queencrown Bored";
        items[669] = "Queencrown Happy";
        items[670] = "Queencrown Scared";
        items[671] = "Queencrown Sick";
        items[672] = "Rabbit Bored";
        items[673] = "Rabbit Happy";
        items[674] = "Rabbit Scared";
        items[675] = "Rabbit Sick";
        items[676] = "Rainbow Bored";
        items[677] = "Rainbow Happy";
        items[678] = "Rainbow Scared";
        items[679] = "Rainbow Sick";
        items[680] = "Rangefinder Bored";
        items[681] = "Rangefinder Happy";
        items[682] = "Rangefinder Scared";
        items[683] = "Rangefinder Sick";
        items[684] = "Raven Bored";
        items[685] = "Raven Happy";
        items[686] = "Raven Scared";
        items[687] = "Raven Sick";
        items[688] = "Retainer Bored";
        items[689] = "Retainer Happy";
        items[690] = "Retainer Scared";
        items[691] = "Retainer Sick";
        items[692] = "Rgb Bored";
        items[693] = "Rgb Happy";
        items[694] = "Rgb Scared";
        items[695] = "Rgb Sick";
        items[696] = "Ring Bored";
        items[697] = "Ring Happy";
        items[698] = "Ring Scared";
        items[699] = "Ring Sick";
        items[700] = "Road Bored";
        items[701] = "Road Happy";
        items[702] = "Road Scared";
        items[703] = "Road Sick";
        items[704] = "Robot Bored";
        items[705] = "Robot Happy";
        items[706] = "Robot Scared";
        items[707] = "Robot Sick";
        items[708] = "Rock Bored";
        items[709] = "Rock Happy";
        items[710] = "Rock Scared";
        items[711] = "Rock Sick";
        items[712] = "Rosebud Bored";
        items[713] = "Rosebud Happy";
        items[714] = "Rosebud Scared";
        items[715] = "Rosebud Sick";
        items[716] = "Ruler Triangular Bored";
        items[717] = "Ruler Triangular Happy";
        items[718] = "Ruler Triangular Scared";
        items[719] = "Ruler Triangular Sick";
        items[720] = "Safe Bored";
        items[721] = "Safe Happy";
        items[722] = "Safe Scared";
        items[723] = "Safe Sick";
        items[724] = "Saguaro Bored";
        items[725] = "Saguaro Happy";
        items[726] = "Saguaro Scared";
        items[727] = "Saguaro Sick";
        items[728] = "Sailboat Bored";
        items[729] = "Sailboat Happy";
        items[730] = "Sailboat Scared";
        items[731] = "Sailboat Sick";
        items[732] = "Sandwich Bored";
        items[733] = "Sandwich Happy";
        items[734] = "Sandwich Scared";
        items[735] = "Sandwich Sick";
        items[736] = "Saturn Bored";
        items[737] = "Saturn Happy";
        items[738] = "Saturn Scared";
        items[739] = "Saturn Sick";
        items[740] = "Saw Bored";
        items[741] = "Saw Happy";
        items[742] = "Saw Scared";
        items[743] = "Saw Sick";
        items[744] = "Scorpion Bored";
        items[745] = "Scorpion Happy";
        items[746] = "Scorpion Scared";
        items[747] = "Scorpion Sick";
        items[748] = "Shark Bored";
        items[749] = "Shark Happy";
        items[750] = "Shark Scared";
        items[751] = "Shark Sick";
        items[752] = "Shower Bored";
        items[753] = "Shower Happy";
        items[754] = "Shower Scared";
        items[755] = "Shower Sick";
        items[756] = "Skateboard Bored";
        items[757] = "Skateboard Happy";
        items[758] = "Skateboard Scared";
        items[759] = "Skateboard Sick";
        items[760] = "Skeleton Hat Bored";
        items[761] = "Skeleton Hat Happy";
        items[762] = "Skeleton Hat Scared";
        items[763] = "Skeleton Hat Sick";
        items[764] = "Skilift Bored";
        items[765] = "Skilift Happy";
        items[766] = "Skilift Scared";
        items[767] = "Skilift Sick";
        items[768] = "Snowglobe Bored";
        items[769] = "Snowglobe Happy";
        items[770] = "Snowglobe Scared";
        items[771] = "Snowglobe Sick";
        items[772] = "Snowman Bored";
        items[773] = "Snowman Happy";
        items[774] = "Snowman Scared";
        items[775] = "Snowman Sick";
        items[776] = "Snowmobile Bored";
        items[777] = "Snowmobile Happy";
        items[778] = "Snowmobile Scared";
        items[779] = "Snowmobile Sick";
        items[780] = "Spaghetti Bored";
        items[781] = "Spaghetti Happy";
        items[782] = "Spaghetti Scared";
        items[783] = "Spaghetti Sick";
        items[784] = "Sponge Bored";
        items[785] = "Sponge Happy";
        items[786] = "Sponge Scared";
        items[787] = "Sponge Sick";
        items[788] = "Squid Bored";
        items[789] = "Squid Happy";
        items[790] = "Squid Scared";
        items[791] = "Squid Sick";
        items[792] = "Stapler Bored";
        items[793] = "Stapler Happy";
        items[794] = "Stapler Scared";
        items[795] = "Stapler Sick";
        items[796] = "Star Sparkles Bored";
        items[797] = "Star Sparkles Happy";
        items[798] = "Star Sparkles Scared";
        items[799] = "Star Sparkles Sick";
        items[800] = "Steak Bored";
        items[801] = "Steak Happy";
        items[802] = "Steak Scared";
        items[803] = "Steak Sick";
        items[804] = "Sunset Bored";
        items[805] = "Sunset Happy";
        items[806] = "Sunset Scared";
        items[807] = "Sunset Sick";
        items[808] = "Taco Bored";
        items[809] = "Taco Happy";
        items[810] = "Taco Scared";
        items[811] = "Taco Sick";
        items[812] = "Taxi Bored";
        items[813] = "Taxi Happy";
        items[814] = "Taxi Scared";
        items[815] = "Taxi Sick";
        items[816] = "Thumbsup Bored";
        items[817] = "Thumbsup Happy";
        items[818] = "Thumbsup Scared";
        items[819] = "Thumbsup Sick";
        items[820] = "Toaster Bored";
        items[821] = "Toaster Happy";
        items[822] = "Toaster Scared";
        items[823] = "Toaster Sick";
        items[824] = "Tooth Bored";
        items[825] = "Tooth Happy";
        items[826] = "Tooth Scared";
        items[827] = "Tooth Sick";
        items[828] = "Toothbrush Bored";
        items[829] = "Toothbrush Happy";
        items[830] = "Toothbrush Scared";
        items[831] = "Toothbrush Sick";
        items[832] = "Tornado Bored";
        items[833] = "Tornado Happy";
        items[834] = "Tornado Scared";
        items[835] = "Tornado Sick";
        items[836] = "Trashcan Bored";
        items[837] = "Trashcan Happy";
        items[838] = "Trashcan Scared";
        items[839] = "Trashcan Sick";
        items[840] = "Treasurechest Bored";
        items[841] = "Treasurechest Happy";
        items[842] = "Treasurechest Scared";
        items[843] = "Treasurechest Sick";
        items[844] = "Turing Bored";
        items[845] = "Turing Happy";
        items[846] = "Turing Scared";
        items[847] = "Turing Sick";
        items[848] = "Ufo Bored";
        items[849] = "Ufo Happy";
        items[850] = "Ufo Scared";
        items[851] = "Ufo Sick";
        items[852] = "Undead Bored";
        items[853] = "Undead Happy";
        items[854] = "Undead Scared";
        items[855] = "Undead Sick";
        items[856] = "Unicorn Bored";
        items[857] = "Unicorn Happy";
        items[858] = "Unicorn Scared";
        items[859] = "Unicorn Sick";
        items[860] = "Vending Machine Bored";
        items[861] = "Vending Machine Happy";
        items[862] = "Vending Machine Scared";
        items[863] = "Vending Machine Sick";
        items[864] = "Vent Bored";
        items[865] = "Vent Happy";
        items[866] = "Vent Scared";
        items[867] = "Vent Sick";
        items[868] = "Void Bored";
        items[869] = "Void Happy";
        items[870] = "Void Scared";
        items[871] = "Void Sick";
        items[872] = "Volcano Bored";
        items[873] = "Volcano Happy";
        items[874] = "Volcano Scared";
        items[875] = "Volcano Sick";
        items[876] = "Volleyball Bored";
        items[877] = "Volleyball Happy";
        items[878] = "Volleyball Scared";
        items[879] = "Volleyball Sick";
        items[880] = "Wall Bored";
        items[881] = "Wall Happy";
        items[882] = "Wall Scared";
        items[883] = "Wall Sick";
        items[884] = "Wallet Bored";
        items[885] = "Wallet Happy";
        items[886] = "Wallet Scared";
        items[887] = "Wallet Sick";
        items[888] = "Washingmachine Bored";
        items[889] = "Washingmachine Happy";
        items[890] = "Washingmachine Scared";
        items[891] = "Washingmachine Sick";
        items[892] = "Watch Bored";
        items[893] = "Watch Happy";
        items[894] = "Watch Scared";
        items[895] = "Watch Sick";
        items[896] = "Watermelon Bored";
        items[897] = "Watermelon Happy";
        items[898] = "Watermelon Scared";
        items[899] = "Watermelon Sick";
        items[900] = "Wave Bored";
        items[901] = "Wave Happy";
        items[902] = "Wave Scared";
        items[903] = "Wave Sick";
        items[904] = "Weed Bored";
        items[905] = "Weed Happy";
        items[906] = "Weed Scared";
        items[907] = "Weed Sick";
        items[908] = "Weight Bored";
        items[909] = "Weight Happy";
        items[910] = "Weight Scared";
        items[911] = "Weight Sick";
        items[912] = "Werewolf Bored";
        items[913] = "Werewolf Happy";
        items[914] = "Werewolf Scared";
        items[915] = "Werewolf Sick";
        items[916] = "Whale Alive Bored";
        items[917] = "Whale Alive Happy";
        items[918] = "Whale Alive Scared";
        items[919] = "Whale Alive Sick";
        items[920] = "Whale Bored";
        items[921] = "Whale Happy";
        items[922] = "Whale Scared";
        items[923] = "Whale Sick";
        items[924] = "Wine Barrel Bored";
        items[925] = "Wine Barrel Happy";
        items[926] = "Wine Barrel Scared";
        items[927] = "Wine Barrel Sick";
        items[928] = "Wine Bored";
        items[929] = "Wine Happy";
        items[930] = "Wine Scared";
        items[931] = "Wine Sick";
        items[932] = "Wizardhat Bored";
        items[933] = "Wizardhat Happy";
        items[934] = "Wizardhat Scared";
        items[935] = "Wizardhat Sick";
        items[936] = "Zebra Bored";
        items[937] = "Zebra Happy";
        items[938] = "Zebra Scared";
        items[939] = "Zebra Sick";

        bytes memory data = abi.encode(items);

        VmSafe vm = VmSafe(
            address(uint160(uint256(keccak256("hevm cheat code"))))
        );

        string[] memory inputs = new string[](3);
        inputs[0] = "node";
        inputs[1] = "script/nouns-coasters/deflate.js";
        inputs[2] = vm.toString(data);

        bytes memory compressedData = vm.ffi(inputs);

        // address result = SSTORE2.write(compressedData);

        renderer.addLayer({
            target: target,
            ipfs: INounsCoasterMetadataRendererTypes.IPFSGroup({
                baseUri: "ipfs://bafybeiag26lh2at7iah5xqlrzgj2ei2jd2qel3g5bpccgfj5ktjbvu4qm4/",
                extension: ".png"
            }),
            decompressedSize: data.length,
            compressedData: compressedData,
            count: items.length,
            property: "7 Head rear left",
            variantProperty: variantPropertyParameters
        });
    }

    function addLayer8(NounsCoasterMetadataRenderer renderer, address target)
        internal
    {
        // 8 Expression rear left
        INounsCoasterMetadataRendererTypes.VariantPropertyParameters
            memory variantPropertyParameters;
        variantPropertyParameters
            .offsets = new INounsCoasterMetadataRendererTypes.VariantOffset[](
            0
        );
        variantPropertyParameters.id = 0;
        variantPropertyParameters.count = 0;

        string[] memory items = new string[](4);
        items[0] = "Bored";
        items[1] = "Happy";
        items[2] = "Scared";
        items[3] = "Sick";

        bytes memory data = abi.encode(items);

        VmSafe vm = VmSafe(
            address(uint160(uint256(keccak256("hevm cheat code"))))
        );

        string[] memory inputs = new string[](3);
        inputs[0] = "node";
        inputs[1] = "script/nouns-coasters/deflate.js";
        inputs[2] = vm.toString(data);

        bytes memory compressedData = vm.ffi(inputs);

        // address result = SSTORE2.write(compressedData);

        renderer.addLayer({
            target: target,
            ipfs: INounsCoasterMetadataRendererTypes.IPFSGroup({
                baseUri: "ipfs://bafybeiag26lh2at7iah5xqlrzgj2ei2jd2qel3g5bpccgfj5ktjbvu4qm4/",
                extension: ".png"
            }),
            decompressedSize: data.length,
            compressedData: compressedData,
            count: items.length,
            property: "8 Expression rear left",
            variantProperty: variantPropertyParameters
        });
    }

    function addLayer9(NounsCoasterMetadataRenderer renderer, address target)
        internal
    {
        // 9 Glasses rear left
        INounsCoasterMetadataRendererTypes.VariantPropertyParameters
            memory variantPropertyParameters;
        variantPropertyParameters
            .offsets = new INounsCoasterMetadataRendererTypes.VariantOffset[](
            0
        );
        variantPropertyParameters.id = 0;
        variantPropertyParameters.count = 0;

        string[] memory items = new string[](21);
        items[0] = "Black";
        items[1] = "Black Red Eyes";
        items[2] = "Black Rgb";
        items[3] = "Blue";
        items[4] = "Blue Med Saturated";
        items[5] = "Frog Green";
        items[6] = "Full Black";
        items[7] = "Green Blue Multi";
        items[8] = "Grey Light";
        items[9] = "Guava";
        items[10] = "Hip Rose";
        items[11] = "Honey";
        items[12] = "Magenta";
        items[13] = "Orange";
        items[14] = "Pink Purple Multi";
        items[15] = "Red";
        items[16] = "Smoke";
        items[17] = "Teal";
        items[18] = "Watermelon";
        items[19] = "Yellow Orange Multi";
        items[20] = "Yellow Saturated";

        bytes memory data = abi.encode(items);

        VmSafe vm = VmSafe(
            address(uint160(uint256(keccak256("hevm cheat code"))))
        );

        string[] memory inputs = new string[](3);
        inputs[0] = "node";
        inputs[1] = "script/nouns-coasters/deflate.js";
        inputs[2] = vm.toString(data);

        bytes memory compressedData = vm.ffi(inputs);

        // address result = SSTORE2.write(compressedData);

        renderer.addLayer({
            target: target,
            ipfs: INounsCoasterMetadataRendererTypes.IPFSGroup({
                baseUri: "ipfs://bafybeiag26lh2at7iah5xqlrzgj2ei2jd2qel3g5bpccgfj5ktjbvu4qm4/",
                extension: ".png"
            }),
            decompressedSize: data.length,
            compressedData: compressedData,
            count: items.length,
            property: "9 Glasses rear left",
            variantProperty: variantPropertyParameters
        });
    }

    function addLayer10(NounsCoasterMetadataRenderer renderer, address target)
        internal
    {
        // 10 Body rear right
        INounsCoasterMetadataRendererTypes.VariantPropertyParameters
            memory variantPropertyParameters;
        variantPropertyParameters
            .offsets = new INounsCoasterMetadataRendererTypes.VariantOffset[](
            4
        );
        variantPropertyParameters.id = 1;
        variantPropertyParameters.count = 4;
        variantPropertyParameters.offsets[
            0
        ] = INounsCoasterMetadataRendererTypes.VariantOffset({
            startAt: 0,
            count: 30
        });
        variantPropertyParameters.offsets[
            1
        ] = INounsCoasterMetadataRendererTypes.VariantOffset({
            startAt: 30,
            count: 30
        });
        variantPropertyParameters.offsets[
            2
        ] = INounsCoasterMetadataRendererTypes.VariantOffset({
            startAt: 60,
            count: 30
        });
        variantPropertyParameters.offsets[
            3
        ] = INounsCoasterMetadataRendererTypes.VariantOffset({
            startAt: 90,
            count: 30
        });

        string[] memory items = new string[](120);
        items[0] = "1-Both Arms Down Bege Bsod";
        items[1] = "1-Both Arms Down Bege Crt";
        items[2] = "1-Both Arms Down Blue Grey";
        items[3] = "1-Both Arms Down Blue Sky";
        items[4] = "1-Both Arms Down Cold";
        items[5] = "1-Both Arms Down Computer Blue";
        items[6] = "1-Both Arms Down Dark Brown";
        items[7] = "1-Both Arms Down Dark Pink";
        items[8] = "1-Both Arms Down Foggrey";
        items[9] = "1-Both Arms Down Gold";
        items[10] = "1-Both Arms Down Gray Scale 1";
        items[11] = "1-Both Arms Down Gray Scale 7";
        items[12] = "1-Both Arms Down Gray Scale 8";
        items[13] = "1-Both Arms Down Gray Scale 9";
        items[14] = "1-Both Arms Down Green";
        items[15] = "1-Both Arms Down Gunk";
        items[16] = "1-Both Arms Down Hotbrown";
        items[17] = "1-Both Arms Down Magenta";
        items[18] = "1-Both Arms Down Orange";
        items[19] = "1-Both Arms Down Orange Yellow";
        items[20] = "1-Both Arms Down Peachy A";
        items[21] = "1-Both Arms Down Peachy B";
        items[22] = "1-Both Arms Down Purple";
        items[23] = "1-Both Arms Down Red";
        items[24] = "1-Both Arms Down Redpinkish";
        items[25] = "1-Both Arms Down Rust";
        items[26] = "1-Both Arms Down Slime Green";
        items[27] = "1-Both Arms Down Teal";
        items[28] = "1-Both Arms Down Teal Light";
        items[29] = "1-Both Arms Down Yellow";
        items[30] = "2-Both Arms Up Bege Bsod";
        items[31] = "2-Both Arms Up Bege Crt";
        items[32] = "2-Both Arms Up Blue Grey";
        items[33] = "2-Both Arms Up Blue Sky";
        items[34] = "2-Both Arms Up Cold";
        items[35] = "2-Both Arms Up Computer Blue";
        items[36] = "2-Both Arms Up Dark Brown";
        items[37] = "2-Both Arms Up Dark Pink";
        items[38] = "2-Both Arms Up Foggrey";
        items[39] = "2-Both Arms Up Gold";
        items[40] = "2-Both Arms Up Gray Scale 1";
        items[41] = "2-Both Arms Up Gray Scale 7";
        items[42] = "2-Both Arms Up Gray Scale 8";
        items[43] = "2-Both Arms Up Gray Scale 9";
        items[44] = "2-Both Arms Up Green";
        items[45] = "2-Both Arms Up Gunk";
        items[46] = "2-Both Arms Up Hotbrown";
        items[47] = "2-Both Arms Up Magenta";
        items[48] = "2-Both Arms Up Orange";
        items[49] = "2-Both Arms Up Orange Yellow";
        items[50] = "2-Both Arms Up Peachy A";
        items[51] = "2-Both Arms Up Peachy B";
        items[52] = "2-Both Arms Up Purple";
        items[53] = "2-Both Arms Up Red";
        items[54] = "2-Both Arms Up Red Pinkish";
        items[55] = "2-Both Arms Up Rust";
        items[56] = "2-Both Arms Up Slime Green";
        items[57] = "2-Both Arms Up Teal";
        items[58] = "2-Both Arms Up Teal Light";
        items[59] = "2-Both Arms Up Yellow";
        items[60] = "3-Left Arm Up Bege Bsod";
        items[61] = "3-Left Arm Up Bege Crt";
        items[62] = "3-Left Arm Up Blue Grey";
        items[63] = "3-Left Arm Up Blue Sky";
        items[64] = "3-Left Arm Up Cold";
        items[65] = "3-Left Arm Up Computer Blue";
        items[66] = "3-Left Arm Up Dark Brown";
        items[67] = "3-Left Arm Up Dark Pink";
        items[68] = "3-Left Arm Up Foggrey";
        items[69] = "3-Left Arm Up Gold";
        items[70] = "3-Left Arm Up Gray Scale 1";
        items[71] = "3-Left Arm Up Gray Scale 7";
        items[72] = "3-Left Arm Up Gray Scale 8";
        items[73] = "3-Left Arm Up Gray Scale 9";
        items[74] = "3-Left Arm Up Green";
        items[75] = "3-Left Arm Up Gunk";
        items[76] = "3-Left Arm Up Hotbrown";
        items[77] = "3-Left Arm Up Magenta";
        items[78] = "3-Left Arm Up Orange";
        items[79] = "3-Left Arm Up Orange Yellow";
        items[80] = "3-Left Arm Up Peachy A";
        items[81] = "3-Left Arm Up Peachy B";
        items[82] = "3-Left Arm Up Purple";
        items[83] = "3-Left Arm Up Red";
        items[84] = "3-Left Arm Up Redpinkish";
        items[85] = "3-Left Arm Up Rust";
        items[86] = "3-Left Arm Up Slime Green";
        items[87] = "3-Left Arm Up Teal";
        items[88] = "3-Left Arm Up Teal Light";
        items[89] = "3-Left Arm Up Yellow";
        items[90] = "4-Right Arm Up Bege Bsod";
        items[91] = "4-Right Arm Up Bege Crt";
        items[92] = "4-Right Arm Up Blue Grey";
        items[93] = "4-Right Arm Up Blue Sky";
        items[94] = "4-Right Arm Up Cold";
        items[95] = "4-Right Arm Up Computer Blue";
        items[96] = "4-Right Arm Up Dark Brown";
        items[97] = "4-Right Arm Up Dark Pink";
        items[98] = "4-Right Arm Up Foggrey";
        items[99] = "4-Right Arm Up Gold";
        items[100] = "4-Right Arm Up Gray Scale 1";
        items[101] = "4-Right Arm Up Gray Scale 7";
        items[102] = "4-Right Arm Up Gray Scale 8";
        items[103] = "4-Right Arm Up Gray Scale 9";
        items[104] = "4-Right Arm Up Green";
        items[105] = "4-Right Arm Up Gunk";
        items[106] = "4-Right Arm Up Hotbrown";
        items[107] = "4-Right Arm Up Magenta";
        items[108] = "4-Right Arm Up Orange";
        items[109] = "4-Right Arm Up Orange Yellow";
        items[110] = "4-Right Arm Up Peachy A";
        items[111] = "4-Right Arm Up Peachy B";
        items[112] = "4-Right Arm Up Purple";
        items[113] = "4-Right Arm Up Red";
        items[114] = "4-Right Arm Up Red Pinkish";
        items[115] = "4-Right Arm Up Rust";
        items[116] = "4-Right Arm Up Slime Green";
        items[117] = "4-Right Arm Up Teal";
        items[118] = "4-Right Arm Up Teal Light";
        items[119] = "4-Right Arm Up Yellow";

        bytes memory data = abi.encode(items);

        VmSafe vm = VmSafe(
            address(uint160(uint256(keccak256("hevm cheat code"))))
        );

        string[] memory inputs = new string[](3);
        inputs[0] = "node";
        inputs[1] = "script/nouns-coasters/deflate.js";
        inputs[2] = vm.toString(data);

        bytes memory compressedData = vm.ffi(inputs);

        // address result = SSTORE2.write(compressedData);

        renderer.addLayer({
            target: target,
            ipfs: INounsCoasterMetadataRendererTypes.IPFSGroup({
                baseUri: "ipfs://bafybeiag26lh2at7iah5xqlrzgj2ei2jd2qel3g5bpccgfj5ktjbvu4qm4/",
                extension: ".png"
            }),
            decompressedSize: data.length,
            compressedData: compressedData,
            count: items.length,
            property: "10 Body rear right",
            variantProperty: variantPropertyParameters
        });
    }

    function addLayer11(NounsCoasterMetadataRenderer renderer, address target)
        internal
    {
        // 11 Accessories rear right
        INounsCoasterMetadataRendererTypes.VariantPropertyParameters
            memory variantPropertyParameters;
        variantPropertyParameters
            .offsets = new INounsCoasterMetadataRendererTypes.VariantOffset[](
            4
        );
        variantPropertyParameters.id = 1;
        variantPropertyParameters.count = 4;
        variantPropertyParameters.offsets[
            0
        ] = INounsCoasterMetadataRendererTypes.VariantOffset({
            startAt: 0,
            count: 139
        });
        variantPropertyParameters.offsets[
            1
        ] = INounsCoasterMetadataRendererTypes.VariantOffset({
            startAt: 139,
            count: 137
        });
        variantPropertyParameters.offsets[
            2
        ] = INounsCoasterMetadataRendererTypes.VariantOffset({
            startAt: 276,
            count: 137
        });
        variantPropertyParameters.offsets[
            3
        ] = INounsCoasterMetadataRendererTypes.VariantOffset({
            startAt: 413,
            count: 137
        });

        string[] memory items = new string[](550);
        items[0] = "1-Asset Rear Right 1n";
        items[1] = "1-Asset Rear Right Aardvark";
        items[2] = "1-Asset Rear Right Axe";
        items[3] = "1-Asset Rear Right Belly Chamaleon";
        items[4] = "1-Asset Rear Right Bird Flying";
        items[5] = "1-Asset Rear Right Bird Side";
        items[6] = "1-Asset Rear Right Bling Anchor";
        items[7] = "1-Asset Rear Right Bling Anvil";
        items[8] = "1-Asset Rear Right Bling Arrow";
        items[9] = "1-Asset Rear Right Bling Cheese";
        items[10] = "1-Asset Rear Right Bling Gold Ingot";
        items[11] = "1-Asset Rear Right Bling Love";
        items[12] = "1-Asset Rear Right Bling Mask";
        items[13] = "1-Asset Rear Right Bling Rings";
        items[14] = "1-Asset Rear Right Bling Scissors";
        items[15] = "1-Asset Rear Right Bling Sparkles";
        items[16] = "1-Asset Rear Right Both Arms Down Bege Bsod";
        items[17] = "1-Asset Rear Right Both Arms Down Belly Chamaleon";
        items[18] = "1-Asset Rear Right Both Arms Down Big Walk Blue Prime";
        items[19] = "1-Asset Rear Right Both Arms Down Big Walk Grey Light";
        items[20] = "1-Asset Rear Right Both Arms Down Big Walk Rainbow";
        items[21] = "1-Asset Rear Right Both Arms Down Black";
        items[22] = "1-Asset Rear Right Both Arms Down Chain Logo";
        items[23] = "1-Asset Rear Right Both Arms Down Checker Disco";
        items[24] = "1-Asset Rear Right Both Arms Down Checker Rgb";
        items[25] = "1-Asset Rear Right Both Arms Down Checker Spaced Black";
        items[26] = "1-Asset Rear Right Both Arms Down Checker Spaced White";
        items[27] = "1-Asset Rear Right Both Arms Down Checker Vibrant";
        items[28] = "1-Asset Rear Right Both Arms Down Checkers Big Green";
        items[29] = "1-Asset Rear Right Both Arms Down Checkers Big Red Cold";
        items[30] = "1-Asset Rear Right Both Arms Down Checkers Blue";
        items[31] = "1-Asset Rear Right Both Arms Down Checkers Magenta";
        items[32] = "1-Asset Rear Right Both Arms Down Collar Sunset";
        items[33] = "1-Asset Rear Right Both Arms Down Decay Gray Dark";
        items[34] = "1-Asset Rear Right Both Arms Down Decay Pride";
        items[35] = "1-Asset Rear Right Both Arms Down Gradient Dawn";
        items[36] = "1-Asset Rear Right Both Arms Down Gradient Dusk";
        items[37] = "1-Asset Rear Right Both Arms Down Gradient Glacier";
        items[38] = "1-Asset Rear Right Both Arms Down Gradient Ice";
        items[39] = "1-Asset Rear Right Both Arms Down Gradient Pride";
        items[40] = "1-Asset Rear Right Both Arms Down Gradient Redpink";
        items[41] = "1-Asset Rear Right Both Arms Down Gradient Sunset";
        items[42] = "1-Asset Rear Right Both Arms Down Gray Scale 1";
        items[43] = "1-Asset Rear Right Both Arms Down Gray Scale 9";
        items[44] = "1-Asset Rear Right Both Arms Down Grid Simple Bege";
        items[45] = "1-Asset Rear Right Both Arms Down Ice Cold";
        items[46] = "1-Asset Rear Right Both Arms Down Lines 45 Greens";
        items[47] = "1-Asset Rear Right Both Arms Down Lines 45 Rose";
        items[48] = "1-Asset Rear Right Both Arms Down Old Shirt";
        items[49] = "1-Asset Rear Right Both Arms Down Rainbow Steps";
        items[50] = "1-Asset Rear Right Both Arms Down Robot";
        items[51] = "1-Asset Rear Right Both Arms Down Safety Vest";
        items[52] = "1-Asset Rear Right Both Arms Down Scarf Clown";
        items[53] = "1-Asset Rear Right Both Arms Down Shirt Black";
        items[54] = "1-Asset Rear Right Both Arms Down Stripes And Checks";
        items[55] = "1-Asset Rear Right Both Arms Down Stripes Big Red";
        items[56] = "1-Asset Rear Right Both Arms Down Stripes Blit";
        items[57] = "1-Asset Rear Right Both Arms Down Stripes Blue Med";
        items[58] = "1-Asset Rear Right Both Arms Down Stripes Brown";
        items[59] = "1-Asset Rear Right Both Arms Down Stripes Olive";
        items[60] = "1-Asset Rear Right Both Arms Down Stripes Red Cold";
        items[61] = "1-Asset Rear Right Both Arms Down Taxi Checkers";
        items[62] = "1-Asset Rear Right Both Arms Down Tee Yo";
        items[63] = "1-Asset Rear Right Both Arms Down Txt Ico";
        items[64] = "1-Asset Rear Right Both Arms Down Wall";
        items[65] = "1-Asset Rear Right Both Arms Down Woolweave Bicolor";
        items[66] = "1-Asset Rear Right Both Arms Down Woolweave Dirt";
        items[67] = "1-Asset Rear Right Carrot";
        items[68] = "1-Asset Rear Right Chain Logo";
        items[69] = "1-Asset Rear Right Chicken";
        items[70] = "1-Asset Rear Right Cloud";
        items[71] = "1-Asset Rear Right Clover";
        items[72] = "1-Asset Rear Right Cow";
        items[73] = "1-Asset Rear Right Dinosaur";
        items[74] = "1-Asset Rear Right Dollar Bling";
        items[75] = "1-Asset Rear Right Dragon";
        items[76] = "1-Asset Rear Right Ducky";
        items[77] = "1-Asset Rear Right Eth";
        items[78] = "1-Asset Rear Right Eye";
        items[79] = "1-Asset Rear Right Flash";
        items[80] = "1-Asset Rear Right Fries";
        items[81] = "1-Asset Rear Right Glasses";
        items[82] = "1-Asset Rear Right Glasses Logo";
        items[83] = "1-Asset Rear Right Glasses Logo Sun";
        items[84] = "1-Asset Rear Right Heart";
        items[85] = "1-Asset Rear Right Hoodiestrings Uneven";
        items[86] = "1-Asset Rear Right Id";
        items[87] = "1-Asset Rear Right Infinity";
        items[88] = "1-Asset Rear Right Insignia";
        items[89] = "1-Asset Rear Right Leaf";
        items[90] = "1-Asset Rear Right Light Bulb";
        items[91] = "1-Asset Rear Right Lp";
        items[92] = "1-Asset Rear Right Mars Face";
        items[93] = "1-Asset Rear Right Matrix White";
        items[94] = "1-Asset Rear Right Moon Block";
        items[95] = "1-Asset Rear Right None";
        items[96] = "1-Asset Rear Right Pizza Bling";
        items[97] = "1-Asset Rear Right Pocket Pencil";
        items[98] = "1-Asset Rear Right Rain";
        items[99] = "1-Asset Rear Right Rgb";
        items[100] = "1-Asset Rear Right Secret X";
        items[101] = "1-Asset Rear Right Shrimp";
        items[102] = "1-Asset Rear Right Slime Splat";
        items[103] = "1-Asset Rear Right Small Bling";
        items[104] = "1-Asset Rear Right Snow Flake";
        items[105] = "1-Asset Rear Right Stains Blood";
        items[106] = "1-Asset Rear Right Stains Zombie";
        items[107] = "1-Asset Rear Right Sunset";
        items[108] = "1-Asset Rear Right Think";
        items[109] = "1-Asset Rear Right Tie Black On White";
        items[110] = "1-Asset Rear Right Tie Dye";
        items[111] = "1-Asset Rear Right Tie Purple";
        items[112] = "1-Asset Rear Right Tie Red";
        items[113] = "1-Asset Rear Right Txt A2+b2";
        items[114] = "1-Asset Rear Right Txt Cc";
        items[115] = "1-Asset Rear Right Txt Cc 2";
        items[116] = "1-Asset Rear Right Txt Copy";
        items[117] = "1-Asset Rear Right Txt Dao Black";
        items[118] = "1-Asset Rear Right Txt Doom";
        items[119] = "1-Asset Rear Right Txt Dope";
        items[120] = "1-Asset Rear Right Txt Foo Black";
        items[121] = "1-Asset Rear Right Txt Io";
        items[122] = "1-Asset Rear Right Txt Lmao";
        items[123] = "1-Asset Rear Right Txt Lol";
        items[124] = "1-Asset Rear Right Txt Mint";
        items[125] = "1-Asset Rear Right Txt Nil Grey Dark";
        items[126] = "1-Asset Rear Right Txt Noun";
        items[127] = "1-Asset Rear Right Txt Noun F0f";
        items[128] = "1-Asset Rear Right Txt Noun Green";
        items[129] = "1-Asset Rear Right Txt Noun Multicolor";
        items[130] = "1-Asset Rear Right Txt Pi";
        items[131] = "1-Asset Rear Right Txt Pop";
        items[132] = "1-Asset Rear Right Txt Rofl";
        items[133] = "1-Asset Rear Right Txt We";
        items[134] = "1-Asset Rear Right Txt Yay";
        items[135] = "1-Asset Rear Right Txt Yolo";
        items[136] = "1-Asset Rear Right Wave";
        items[137] = "1-Asset Rear Right Wet Money";
        items[138] = "1-Asset Rear Right Ying Yang";
        items[139] = "2-Asset Rear Right 1n";
        items[140] = "2-Asset Rear Right Aardvark";
        items[141] = "2-Asset Rear Right Axe";
        items[142] = "2-Asset Rear Right Belly Chamaleon";
        items[143] = "2-Asset Rear Right Bird Flying";
        items[144] = "2-Asset Rear Right Bird Side";
        items[145] = "2-Asset Rear Right Bling Anchor";
        items[146] = "2-Asset Rear Right Bling Anvil";
        items[147] = "2-Asset Rear Right Bling Arrow";
        items[148] = "2-Asset Rear Right Bling Cheese";
        items[149] = "2-Asset Rear Right Bling Gold Ingot";
        items[150] = "2-Asset Rear Right Bling Love";
        items[151] = "2-Asset Rear Right Bling Mask";
        items[152] = "2-Asset Rear Right Bling Rings";
        items[153] = "2-Asset Rear Right Bling Scissors";
        items[154] = "2-Asset Rear Right Bling Sparkles";
        items[155] = "2-Asset Rear Right Both Arms Up Bege Bsod";
        items[156] = "2-Asset Rear Right Both Arms Up Big Walk Blue Prime";
        items[157] = "2-Asset Rear Right Both Arms Up Big Walk Grey Light";
        items[158] = "2-Asset Rear Right Both Arms Up Big Walk Rainbow";
        items[159] = "2-Asset Rear Right Both Arms Up Checker Disco";
        items[160] = "2-Asset Rear Right Both Arms Up Checker Rgb";
        items[161] = "2-Asset Rear Right Both Arms Up Checker Spaced Black";
        items[162] = "2-Asset Rear Right Both Arms Up Checker Spaced White";
        items[163] = "2-Asset Rear Right Both Arms Up Checker Vibrant";
        items[164] = "2-Asset Rear Right Both Arms Up Checkers Big Green";
        items[165] = "2-Asset Rear Right Both Arms Up Checkers Big Red Cold";
        items[166] = "2-Asset Rear Right Both Arms Up Checkers Black";
        items[167] = "2-Asset Rear Right Both Arms Up Checkers Blue";
        items[168] = "2-Asset Rear Right Both Arms Up Checkers Magenta";
        items[169] = "2-Asset Rear Right Both Arms Up Collar Sunset";
        items[170] = "2-Asset Rear Right Both Arms Up Decay Gray Dark";
        items[171] = "2-Asset Rear Right Both Arms Up Decay Gray Pride";
        items[172] = "2-Asset Rear Right Both Arms Up Gradient Dawn";
        items[173] = "2-Asset Rear Right Both Arms Up Gradient Dusk";
        items[174] = "2-Asset Rear Right Both Arms Up Gradient Glacier";
        items[175] = "2-Asset Rear Right Both Arms Up Gradient Ice";
        items[176] = "2-Asset Rear Right Both Arms Up Gradient Pride";
        items[177] = "2-Asset Rear Right Both Arms Up Gradient Redpink";
        items[178] = "2-Asset Rear Right Both Arms Up Gradient Sunset";
        items[179] = "2-Asset Rear Right Both Arms Up Gray Scale 1";
        items[180] = "2-Asset Rear Right Both Arms Up Gray Scale 9";
        items[181] = "2-Asset Rear Right Both Arms Up Grid Simple Bege";
        items[182] = "2-Asset Rear Right Both Arms Up Ice Cold";
        items[183] = "2-Asset Rear Right Both Arms Up Lines 45 Greens";
        items[184] = "2-Asset Rear Right Both Arms Up Lines 45 Rose";
        items[185] = "2-Asset Rear Right Both Arms Up Old Shirt";
        items[186] = "2-Asset Rear Right Both Arms Up Rainbow Steps";
        items[187] = "2-Asset Rear Right Both Arms Up Robot";
        items[188] = "2-Asset Rear Right Both Arms Up Safety Vest";
        items[189] = "2-Asset Rear Right Both Arms Up Scarf Clown";
        items[190] = "2-Asset Rear Right Both Arms Up Shirt Black";
        items[191] = "2-Asset Rear Right Both Arms Up Stripes And Checks";
        items[192] = "2-Asset Rear Right Both Arms Up Stripes Big Red";
        items[193] = "2-Asset Rear Right Both Arms Up Stripes Blit";
        items[194] = "2-Asset Rear Right Both Arms Up Stripes Blue Med";
        items[195] = "2-Asset Rear Right Both Arms Up Stripes Brown";
        items[196] = "2-Asset Rear Right Both Arms Up Stripes Olive";
        items[197] = "2-Asset Rear Right Both Arms Up Stripes Red Cold";
        items[198] = "2-Asset Rear Right Both Arms Up Taxi Checkers";
        items[199] = "2-Asset Rear Right Both Arms Up Tee Yo";
        items[200] = "2-Asset Rear Right Both Arms Up Txt Ico";
        items[201] = "2-Asset Rear Right Both Arms Up Wall";
        items[202] = "2-Asset Rear Right Both Arms Up Woolweave Bicolor";
        items[203] = "2-Asset Rear Right Both Arms Up Woolweave Dirt";
        items[204] = "2-Asset Rear Right Carrot";
        items[205] = "2-Asset Rear Right Chain Logo";
        items[206] = "2-Asset Rear Right Chicken";
        items[207] = "2-Asset Rear Right Cloud";
        items[208] = "2-Asset Rear Right Clover";
        items[209] = "2-Asset Rear Right Cow";
        items[210] = "2-Asset Rear Right Dinosaur";
        items[211] = "2-Asset Rear Right Dollar Bling";
        items[212] = "2-Asset Rear Right Dragon";
        items[213] = "2-Asset Rear Right Ducky";
        items[214] = "2-Asset Rear Right Eth";
        items[215] = "2-Asset Rear Right Eye";
        items[216] = "2-Asset Rear Right Flash";
        items[217] = "2-Asset Rear Right Fries";
        items[218] = "2-Asset Rear Right Glasses";
        items[219] = "2-Asset Rear Right Glasses Logo";
        items[220] = "2-Asset Rear Right Glasses Logo Sun";
        items[221] = "2-Asset Rear Right Heart";
        items[222] = "2-Asset Rear Right Hoodiestrings Uneven";
        items[223] = "2-Asset Rear Right Id";
        items[224] = "2-Asset Rear Right Infinity";
        items[225] = "2-Asset Rear Right Insignia";
        items[226] = "2-Asset Rear Right Leaf";
        items[227] = "2-Asset Rear Right Light Bulb";
        items[228] = "2-Asset Rear Right Lp";
        items[229] = "2-Asset Rear Right Mars Face";
        items[230] = "2-Asset Rear Right Matrix White";
        items[231] = "2-Asset Rear Right Moon Block";
        items[232] = "2-Asset Rear Right None";
        items[233] = "2-Asset Rear Right Pizza Bling";
        items[234] = "2-Asset Rear Right Pocket Pencil";
        items[235] = "2-Asset Rear Right Rain";
        items[236] = "2-Asset Rear Right Rgb";
        items[237] = "2-Asset Rear Right Secret X";
        items[238] = "2-Asset Rear Right Shrimp";
        items[239] = "2-Asset Rear Right Slime Splat";
        items[240] = "2-Asset Rear Right Small Bling";
        items[241] = "2-Asset Rear Right Snow Flake";
        items[242] = "2-Asset Rear Right Stains Blood";
        items[243] = "2-Asset Rear Right Stains Zombie";
        items[244] = "2-Asset Rear Right Sunset";
        items[245] = "2-Asset Rear Right Think";
        items[246] = "2-Asset Rear Right Tie Black On White";
        items[247] = "2-Asset Rear Right Tie Dye";
        items[248] = "2-Asset Rear Right Tie Purple";
        items[249] = "2-Asset Rear Right Tie Red";
        items[250] = "2-Asset Rear Right Txt A2+b2";
        items[251] = "2-Asset Rear Right Txt Cc";
        items[252] = "2-Asset Rear Right Txt Cc 2";
        items[253] = "2-Asset Rear Right Txt Copy";
        items[254] = "2-Asset Rear Right Txt Dao Black";
        items[255] = "2-Asset Rear Right Txt Doom";
        items[256] = "2-Asset Rear Right Txt Dope";
        items[257] = "2-Asset Rear Right Txt Foo Black";
        items[258] = "2-Asset Rear Right Txt Io";
        items[259] = "2-Asset Rear Right Txt Lmao";
        items[260] = "2-Asset Rear Right Txt Lol";
        items[261] = "2-Asset Rear Right Txt Mint";
        items[262] = "2-Asset Rear Right Txt Nil Grey Dark";
        items[263] = "2-Asset Rear Right Txt Noun";
        items[264] = "2-Asset Rear Right Txt Noun F0f";
        items[265] = "2-Asset Rear Right Txt Noun Green";
        items[266] = "2-Asset Rear Right Txt Noun Multicolor";
        items[267] = "2-Asset Rear Right Txt Pi";
        items[268] = "2-Asset Rear Right Txt Pop";
        items[269] = "2-Asset Rear Right Txt Rofl";
        items[270] = "2-Asset Rear Right Txt We";
        items[271] = "2-Asset Rear Right Txt Yay";
        items[272] = "2-Asset Rear Right Txt Yolo";
        items[273] = "2-Asset Rear Right Wave";
        items[274] = "2-Asset Rear Right Wet Money";
        items[275] = "2-Asset Rear Right Ying Yang";
        items[276] = "3-Asset Rear Right 1n";
        items[277] = "3-Asset Rear Right Aardvark";
        items[278] = "3-Asset Rear Right Axe";
        items[279] = "3-Asset Rear Right Belly Chamaleon";
        items[280] = "3-Asset Rear Right Bird Flying";
        items[281] = "3-Asset Rear Right Bird Side";
        items[282] = "3-Asset Rear Right Bling Anchor";
        items[283] = "3-Asset Rear Right Bling Anvil";
        items[284] = "3-Asset Rear Right Bling Arrow";
        items[285] = "3-Asset Rear Right Bling Cheese";
        items[286] = "3-Asset Rear Right Bling Gold Ingot";
        items[287] = "3-Asset Rear Right Bling Love";
        items[288] = "3-Asset Rear Right Bling Mask";
        items[289] = "3-Asset Rear Right Bling Rings";
        items[290] = "3-Asset Rear Right Bling Scissors";
        items[291] = "3-Asset Rear Right Bling Sparkles";
        items[292] = "3-Asset Rear Right Carrot";
        items[293] = "3-Asset Rear Right Chain Logo";
        items[294] = "3-Asset Rear Right Chicken";
        items[295] = "3-Asset Rear Right Cloud";
        items[296] = "3-Asset Rear Right Clover";
        items[297] = "3-Asset Rear Right Cow";
        items[298] = "3-Asset Rear Right Dinosaur";
        items[299] = "3-Asset Rear Right Dollar Bling";
        items[300] = "3-Asset Rear Right Dragon";
        items[301] = "3-Asset Rear Right Ducky";
        items[302] = "3-Asset Rear Right Eth";
        items[303] = "3-Asset Rear Right Eye";
        items[304] = "3-Asset Rear Right Flash";
        items[305] = "3-Asset Rear Right Fries";
        items[306] = "3-Asset Rear Right Glasses";
        items[307] = "3-Asset Rear Right Glasses Logo";
        items[308] = "3-Asset Rear Right Glasses Logo Sun";
        items[309] = "3-Asset Rear Right Heart";
        items[310] = "3-Asset Rear Right Hoodiestrings Uneven";
        items[311] = "3-Asset Rear Right Id";
        items[312] = "3-Asset Rear Right Infinity";
        items[313] = "3-Asset Rear Right Insignia";
        items[314] = "3-Asset Rear Right Leaf";
        items[315] = "3-Asset Rear Right Left Arm Up Bege Bsod";
        items[316] = "3-Asset Rear Right Left Arm Up Bigwalk Blue Prime";
        items[317] = "3-Asset Rear Right Left Arm Up Bigwalk Grey Light";
        items[318] = "3-Asset Rear Right Left Arm Up Bigwalk Rainbow";
        items[319] = "3-Asset Rear Right Left Arm Up Checker Disco";
        items[320] = "3-Asset Rear Right Left Arm Up Checker Rgb";
        items[321] = "3-Asset Rear Right Left Arm Up Checker Spaced Black";
        items[322] = "3-Asset Rear Right Left Arm Up Checker Spaced White";
        items[323] = "3-Asset Rear Right Left Arm Up Checker Vibrant";
        items[324] = "3-Asset Rear Right Left Arm Up Checkers Big Green";
        items[325] = "3-Asset Rear Right Left Arm Up Checkers Big Red Cold";
        items[326] = "3-Asset Rear Right Left Arm Up Checkers Black";
        items[327] = "3-Asset Rear Right Left Arm Up Checkers Blue";
        items[328] = "3-Asset Rear Right Left Arm Up Checkers Magenta";
        items[329] = "3-Asset Rear Right Left Arm Up Collar Sunset";
        items[330] = "3-Asset Rear Right Left Arm Up Decay Gray Dark";
        items[331] = "3-Asset Rear Right Left Arm Up Decay Pride";
        items[332] = "3-Asset Rear Right Left Arm Up Gradient Dawn";
        items[333] = "3-Asset Rear Right Left Arm Up Gradient Dusk";
        items[334] = "3-Asset Rear Right Left Arm Up Gradient Glacier";
        items[335] = "3-Asset Rear Right Left Arm Up Gradient Ice";
        items[336] = "3-Asset Rear Right Left Arm Up Gradient Pride";
        items[337] = "3-Asset Rear Right Left Arm Up Gradient Redpink";
        items[338] = "3-Asset Rear Right Left Arm Up Gradient Sunset";
        items[339] = "3-Asset Rear Right Left Arm Up Gray Scale 1";
        items[340] = "3-Asset Rear Right Left Arm Up Gray Scale 9";
        items[341] = "3-Asset Rear Right Left Arm Up Grid Simple Bege";
        items[342] = "3-Asset Rear Right Left Arm Up Ice Cold";
        items[343] = "3-Asset Rear Right Left Arm Up Lines 45 Greens";
        items[344] = "3-Asset Rear Right Left Arm Up Lines 45 Rose";
        items[345] = "3-Asset Rear Right Left Arm Up Old Shirt";
        items[346] = "3-Asset Rear Right Left Arm Up Rainbow Steps";
        items[347] = "3-Asset Rear Right Left Arm Up Robot";
        items[348] = "3-Asset Rear Right Left Arm Up Safety Vest";
        items[349] = "3-Asset Rear Right Left Arm Up Scarf Clown";
        items[350] = "3-Asset Rear Right Left Arm Up Shirt Black";
        items[351] = "3-Asset Rear Right Left Arm Up Stripes And Checks";
        items[352] = "3-Asset Rear Right Left Arm Up Stripes Big Red";
        items[353] = "3-Asset Rear Right Left Arm Up Stripes Blit";
        items[354] = "3-Asset Rear Right Left Arm Up Stripes Blue Med";
        items[355] = "3-Asset Rear Right Left Arm Up Stripes Brown";
        items[356] = "3-Asset Rear Right Left Arm Up Stripes Olive";
        items[357] = "3-Asset Rear Right Left Arm Up Stripes Red Cold";
        items[358] = "3-Asset Rear Right Left Arm Up Taxi Checkers";
        items[359] = "3-Asset Rear Right Left Arm Up Tee Yo";
        items[360] = "3-Asset Rear Right Left Arm Up Txt Ico";
        items[361] = "3-Asset Rear Right Left Arm Up Wall";
        items[362] = "3-Asset Rear Right Left Arm Up Woolweave Bicolor";
        items[363] = "3-Asset Rear Right Left Arm Up Woolweave Dirt";
        items[364] = "3-Asset Rear Right Light Bulb";
        items[365] = "3-Asset Rear Right Lp";
        items[366] = "3-Asset Rear Right Mars Face";
        items[367] = "3-Asset Rear Right Matrix White";
        items[368] = "3-Asset Rear Right Moon Block";
        items[369] = "3-Asset Rear Right None";
        items[370] = "3-Asset Rear Right Pizza Bling";
        items[371] = "3-Asset Rear Right Pocket Pencil";
        items[372] = "3-Asset Rear Right Rain";
        items[373] = "3-Asset Rear Right Rgb";
        items[374] = "3-Asset Rear Right Secret X";
        items[375] = "3-Asset Rear Right Shrimp";
        items[376] = "3-Asset Rear Right Slime Splat";
        items[377] = "3-Asset Rear Right Small Bling";
        items[378] = "3-Asset Rear Right Snow Flake";
        items[379] = "3-Asset Rear Right Stains Blood";
        items[380] = "3-Asset Rear Right Stains Zombie";
        items[381] = "3-Asset Rear Right Sunset";
        items[382] = "3-Asset Rear Right Think";
        items[383] = "3-Asset Rear Right Tie Black On White";
        items[384] = "3-Asset Rear Right Tie Dye";
        items[385] = "3-Asset Rear Right Tie Purple";
        items[386] = "3-Asset Rear Right Tie Red";
        items[387] = "3-Asset Rear Right Txt A2+b2";
        items[388] = "3-Asset Rear Right Txt Cc";
        items[389] = "3-Asset Rear Right Txt Cc 2";
        items[390] = "3-Asset Rear Right Txt Copy";
        items[391] = "3-Asset Rear Right Txt Dao Black";
        items[392] = "3-Asset Rear Right Txt Doom";
        items[393] = "3-Asset Rear Right Txt Dope";
        items[394] = "3-Asset Rear Right Txt Foo Black";
        items[395] = "3-Asset Rear Right Txt Io";
        items[396] = "3-Asset Rear Right Txt Lmao";
        items[397] = "3-Asset Rear Right Txt Lol";
        items[398] = "3-Asset Rear Right Txt Mint";
        items[399] = "3-Asset Rear Right Txt Nil Grey Dark";
        items[400] = "3-Asset Rear Right Txt Noun";
        items[401] = "3-Asset Rear Right Txt Noun F0f";
        items[402] = "3-Asset Rear Right Txt Noun Green";
        items[403] = "3-Asset Rear Right Txt Noun Multicolor";
        items[404] = "3-Asset Rear Right Txt Pi";
        items[405] = "3-Asset Rear Right Txt Pop";
        items[406] = "3-Asset Rear Right Txt Rofl";
        items[407] = "3-Asset Rear Right Txt We";
        items[408] = "3-Asset Rear Right Txt Yay";
        items[409] = "3-Asset Rear Right Txt Yolo";
        items[410] = "3-Asset Rear Right Wave";
        items[411] = "3-Asset Rear Right Wet Money";
        items[412] = "3-Asset Rear Right Ying Yang";
        items[413] = "4-Asset Rear Right 1n";
        items[414] = "4-Asset Rear Right Aardvark";
        items[415] = "4-Asset Rear Right Axe";
        items[416] = "4-Asset Rear Right Belly Chamaleon";
        items[417] = "4-Asset Rear Right Bird Flying";
        items[418] = "4-Asset Rear Right Bird Side";
        items[419] = "4-Asset Rear Right Bling Anchor";
        items[420] = "4-Asset Rear Right Bling Anvil";
        items[421] = "4-Asset Rear Right Bling Arrow";
        items[422] = "4-Asset Rear Right Bling Cheese";
        items[423] = "4-Asset Rear Right Bling Gold Ingot";
        items[424] = "4-Asset Rear Right Bling Love";
        items[425] = "4-Asset Rear Right Bling Mask";
        items[426] = "4-Asset Rear Right Bling Rings";
        items[427] = "4-Asset Rear Right Bling Scissors";
        items[428] = "4-Asset Rear Right Bling Sparkles";
        items[429] = "4-Asset Rear Right Carrot";
        items[430] = "4-Asset Rear Right Chain Logo";
        items[431] = "4-Asset Rear Right Chicken";
        items[432] = "4-Asset Rear Right Cloud";
        items[433] = "4-Asset Rear Right Clover";
        items[434] = "4-Asset Rear Right Cow";
        items[435] = "4-Asset Rear Right Dinosaur";
        items[436] = "4-Asset Rear Right Dollar Bling";
        items[437] = "4-Asset Rear Right Dragon";
        items[438] = "4-Asset Rear Right Ducky";
        items[439] = "4-Asset Rear Right Eth";
        items[440] = "4-Asset Rear Right Eye";
        items[441] = "4-Asset Rear Right Flash";
        items[442] = "4-Asset Rear Right Fries";
        items[443] = "4-Asset Rear Right Glasses";
        items[444] = "4-Asset Rear Right Glasses Logo";
        items[445] = "4-Asset Rear Right Glasses Logo Sun";
        items[446] = "4-Asset Rear Right Heart";
        items[447] = "4-Asset Rear Right Hoodiestrings Uneven";
        items[448] = "4-Asset Rear Right Id";
        items[449] = "4-Asset Rear Right Infinity";
        items[450] = "4-Asset Rear Right Insignia";
        items[451] = "4-Asset Rear Right Leaf";
        items[452] = "4-Asset Rear Right Light Bulb";
        items[453] = "4-Asset Rear Right Lp";
        items[454] = "4-Asset Rear Right Mars Face";
        items[455] = "4-Asset Rear Right Matrix White";
        items[456] = "4-Asset Rear Right Moon Block";
        items[457] = "4-Asset Rear Right None";
        items[458] = "4-Asset Rear Right Pizza Bling";
        items[459] = "4-Asset Rear Right Pocket Pencil";
        items[460] = "4-Asset Rear Right Rain";
        items[461] = "4-Asset Rear Right Rgb";
        items[462] = "4-Asset Rear Right Right Arm Up Bege Bsod";
        items[463] = "4-Asset Rear Right Right Arm Up Big Walk Blue Prime";
        items[464] = "4-Asset Rear Right Right Arm Up Big Walk Grey Light";
        items[465] = "4-Asset Rear Right Right Arm Up Big Walk Rainbow";
        items[466] = "4-Asset Rear Right Right Arm Up Checker Disco";
        items[467] = "4-Asset Rear Right Right Arm Up Checker Rgb";
        items[468] = "4-Asset Rear Right Right Arm Up Checker Spaced Black";
        items[469] = "4-Asset Rear Right Right Arm Up Checker Spaced White";
        items[470] = "4-Asset Rear Right Right Arm Up Checker Vibrant";
        items[471] = "4-Asset Rear Right Right Arm Up Checkers Big Green";
        items[472] = "4-Asset Rear Right Right Arm Up Checkers Big Red Cold";
        items[473] = "4-Asset Rear Right Right Arm Up Checkers Black";
        items[474] = "4-Asset Rear Right Right Arm Up Checkers Blue";
        items[475] = "4-Asset Rear Right Right Arm Up Checkers Magenta";
        items[476] = "4-Asset Rear Right Right Arm Up Collar Sunset";
        items[477] = "4-Asset Rear Right Right Arm Up Decay Gray Dark";
        items[478] = "4-Asset Rear Right Right Arm Up Decay Pride";
        items[479] = "4-Asset Rear Right Right Arm Up Gradient Dawn";
        items[480] = "4-Asset Rear Right Right Arm Up Gradient Dusk";
        items[481] = "4-Asset Rear Right Right Arm Up Gradient Glacier";
        items[482] = "4-Asset Rear Right Right Arm Up Gradient Ice";
        items[483] = "4-Asset Rear Right Right Arm Up Gradient Pride";
        items[484] = "4-Asset Rear Right Right Arm Up Gradient Redpink";
        items[485] = "4-Asset Rear Right Right Arm Up Gradient Sunset";
        items[486] = "4-Asset Rear Right Right Arm Up Gray Scale 1";
        items[487] = "4-Asset Rear Right Right Arm Up Gray Scale 9";
        items[488] = "4-Asset Rear Right Right Arm Up Grid Simple Bege";
        items[489] = "4-Asset Rear Right Right Arm Up Ice Cold";
        items[490] = "4-Asset Rear Right Right Arm Up Lines 45 Greens";
        items[491] = "4-Asset Rear Right Right Arm Up Lines 45 Rose";
        items[492] = "4-Asset Rear Right Right Arm Up Old Shirt";
        items[493] = "4-Asset Rear Right Right Arm Up Rainbow Steps";
        items[494] = "4-Asset Rear Right Right Arm Up Robot";
        items[495] = "4-Asset Rear Right Right Arm Up Safety Vest";
        items[496] = "4-Asset Rear Right Right Arm Up Scarf Clown";
        items[497] = "4-Asset Rear Right Right Arm Up Shirt Black";
        items[498] = "4-Asset Rear Right Right Arm Up Stripes And Checks";
        items[499] = "4-Asset Rear Right Right Arm Up Stripes Big Red";
        items[500] = "4-Asset Rear Right Right Arm Up Stripes Blit";
        items[501] = "4-Asset Rear Right Right Arm Up Stripes Blue Med";
        items[502] = "4-Asset Rear Right Right Arm Up Stripes Brown";
        items[503] = "4-Asset Rear Right Right Arm Up Stripes Olive";
        items[504] = "4-Asset Rear Right Right Arm Up Stripes Red Cold";
        items[505] = "4-Asset Rear Right Right Arm Up Taxi Checkers";
        items[506] = "4-Asset Rear Right Right Arm Up Tee Yo";
        items[507] = "4-Asset Rear Right Right Arm Up Txt Ico";
        items[508] = "4-Asset Rear Right Right Arm Up Wall";
        items[509] = "4-Asset Rear Right Right Arm Up Woolweave Bicolor";
        items[510] = "4-Asset Rear Right Right Arm Up Woolweave Dirt";
        items[511] = "4-Asset Rear Right Secret X";
        items[512] = "4-Asset Rear Right Shrimp";
        items[513] = "4-Asset Rear Right Slime Splat";
        items[514] = "4-Asset Rear Right Small Bling";
        items[515] = "4-Asset Rear Right Snow Flake";
        items[516] = "4-Asset Rear Right Stains Blood";
        items[517] = "4-Asset Rear Right Stains Zombie";
        items[518] = "4-Asset Rear Right Sunset";
        items[519] = "4-Asset Rear Right Think";
        items[520] = "4-Asset Rear Right Tie Black On White";
        items[521] = "4-Asset Rear Right Tie Dye";
        items[522] = "4-Asset Rear Right Tie Purple";
        items[523] = "4-Asset Rear Right Tie Red";
        items[524] = "4-Asset Rear Right Txt A2+b2";
        items[525] = "4-Asset Rear Right Txt Cc";
        items[526] = "4-Asset Rear Right Txt Cc 2";
        items[527] = "4-Asset Rear Right Txt Copy";
        items[528] = "4-Asset Rear Right Txt Dao Black";
        items[529] = "4-Asset Rear Right Txt Doom";
        items[530] = "4-Asset Rear Right Txt Dope";
        items[531] = "4-Asset Rear Right Txt Foo Black";
        items[532] = "4-Asset Rear Right Txt Io";
        items[533] = "4-Asset Rear Right Txt Lmao";
        items[534] = "4-Asset Rear Right Txt Lol";
        items[535] = "4-Asset Rear Right Txt Mint";
        items[536] = "4-Asset Rear Right Txt Nil Grey Dark";
        items[537] = "4-Asset Rear Right Txt Noun";
        items[538] = "4-Asset Rear Right Txt Noun F0f";
        items[539] = "4-Asset Rear Right Txt Noun Green";
        items[540] = "4-Asset Rear Right Txt Noun Multicolor";
        items[541] = "4-Asset Rear Right Txt Pi";
        items[542] = "4-Asset Rear Right Txt Pop";
        items[543] = "4-Asset Rear Right Txt Rofl";
        items[544] = "4-Asset Rear Right Txt We";
        items[545] = "4-Asset Rear Right Txt Yay";
        items[546] = "4-Asset Rear Right Txt Yolo";
        items[547] = "4-Asset Rear Right Wave";
        items[548] = "4-Asset Rear Right Wet Money";
        items[549] = "4-Asset Rear Right Ying Yang";

        bytes memory data = abi.encode(items);

        VmSafe vm = VmSafe(
            address(uint160(uint256(keccak256("hevm cheat code"))))
        );

        string[] memory inputs = new string[](3);
        inputs[0] = "node";
        inputs[1] = "script/nouns-coasters/deflate.js";
        inputs[2] = vm.toString(data);

        bytes memory compressedData = vm.ffi(inputs);

        // address result = SSTORE2.write(compressedData);

        renderer.addLayer({
            target: target,
            ipfs: INounsCoasterMetadataRendererTypes.IPFSGroup({
                baseUri: "ipfs://bafybeiag26lh2at7iah5xqlrzgj2ei2jd2qel3g5bpccgfj5ktjbvu4qm4/",
                extension: ".png"
            }),
            decompressedSize: data.length,
            compressedData: compressedData,
            count: items.length,
            property: "11 Accessories rear right",
            variantProperty: variantPropertyParameters
        });
    }

    function addLayer12(NounsCoasterMetadataRenderer renderer, address target)
        internal
    {
        // 12 Head rear right
        INounsCoasterMetadataRendererTypes.VariantPropertyParameters
            memory variantPropertyParameters;
        variantPropertyParameters
            .offsets = new INounsCoasterMetadataRendererTypes.VariantOffset[](
            0
        );
        variantPropertyParameters.id = 0;
        variantPropertyParameters.count = 0;

        string[] memory items = new string[](940);
        items[0] = "Aardvark Bored";
        items[1] = "Aardvark Happy";
        items[2] = "Aardvark Scared";
        items[3] = "Aardvark Sick";
        items[4] = "Abstract Bored";
        items[5] = "Abstract Happy";
        items[6] = "Abstract Scared";
        items[7] = "Abstract Sick";
        items[8] = "Ape Bored";
        items[9] = "Ape Happy";
        items[10] = "Ape Scared";
        items[11] = "Ape Sick";
        items[12] = "Bag Bored";
        items[13] = "Bag Happy";
        items[14] = "Bag Scared";
        items[15] = "Bag Sick";
        items[16] = "Bagpipe Bored";
        items[17] = "Bagpipe Happy";
        items[18] = "Bagpipe Scared";
        items[19] = "Bagpipe Sick";
        items[20] = "Banana Bored";
        items[21] = "Banana Happy";
        items[22] = "Banana Scared";
        items[23] = "Banana Sick";
        items[24] = "Bank Bored";
        items[25] = "Bank Happy";
        items[26] = "Bank Scared";
        items[27] = "Bank Sick";
        items[28] = "Baseball Gameball Bored";
        items[29] = "Baseball Gameball Happy";
        items[30] = "Baseball Gameball Scared";
        items[31] = "Baseball Gameball Sick";
        items[32] = "Bat Bored";
        items[33] = "Bat Happy";
        items[34] = "Bat Scared";
        items[35] = "Bat Sick";
        items[36] = "Bear Bored";
        items[37] = "Bear Happy";
        items[38] = "Bear Scared";
        items[39] = "Bear Sick";
        items[40] = "Beer Bored";
        items[41] = "Beer Happy";
        items[42] = "Beer Scared";
        items[43] = "Beer Sick";
        items[44] = "Beet Bored";
        items[45] = "Beet Happy";
        items[46] = "Beet Scared";
        items[47] = "Beet Sick";
        items[48] = "Bell Bored";
        items[49] = "Bell Happy";
        items[50] = "Bell Scared";
        items[51] = "Bell Sick";
        items[52] = "Bigfoot Bored";
        items[53] = "Bigfoot Happy";
        items[54] = "Bigfoot Scared";
        items[55] = "Bigfoot Sick";
        items[56] = "Bigfoot Yeti Bored";
        items[57] = "Bigfoot Yeti Happy";
        items[58] = "Bigfoot Yeti Scared";
        items[59] = "Bigfoot Yeti Sick";
        items[60] = "Blackhole Bored";
        items[61] = "Blackhole Happy";
        items[62] = "Blackhole Scared";
        items[63] = "Blackhole Sick";
        items[64] = "Blueberry Bored";
        items[65] = "Blueberry Happy";
        items[66] = "Blueberry Scared";
        items[67] = "Blueberry Sick";
        items[68] = "Bomb Bored";
        items[69] = "Bomb Happy";
        items[70] = "Bomb Scared";
        items[71] = "Bomb Sick";
        items[72] = "Bonsai Bored";
        items[73] = "Bonsai Happy";
        items[74] = "Bonsai Scared";
        items[75] = "Bonsai Sick";
        items[76] = "Boombox Bored";
        items[77] = "Boombox Happy";
        items[78] = "Boombox Scared";
        items[79] = "Boombox Sick";
        items[80] = "Boot Bored";
        items[81] = "Boot Happy";
        items[82] = "Boot Scared";
        items[83] = "Boot Sick";
        items[84] = "Box Bored";
        items[85] = "Box Happy";
        items[86] = "Box Scared";
        items[87] = "Box Sick";
        items[88] = "Boxingglove Bored";
        items[89] = "Boxingglove Happy";
        items[90] = "Boxingglove Scared";
        items[91] = "Boxingglove Sick";
        items[92] = "Brain Bored";
        items[93] = "Brain Happy";
        items[94] = "Brain Scared";
        items[95] = "Brain Sick";
        items[96] = "Bubble Speech Bored";
        items[97] = "Bubble Speech Happy";
        items[98] = "Bubble Speech Scared";
        items[99] = "Bubble Speech Sick";
        items[100] = "Bubblegum Bored";
        items[101] = "Bubblegum Happy";
        items[102] = "Bubblegum Scared";
        items[103] = "Bubblegum Sick";
        items[104] = "Burger Dollarmenu Bored";
        items[105] = "Burger Dollarmenu Happy";
        items[106] = "Burger Dollarmenu Scared";
        items[107] = "Burger Dollarmenu Sick";
        items[108] = "Cake Bored";
        items[109] = "Cake Happy";
        items[110] = "Cake Scared";
        items[111] = "Cake Sick";
        items[112] = "Calculator Bored";
        items[113] = "Calculator Happy";
        items[114] = "Calculator Scared";
        items[115] = "Calculator Sick";
        items[116] = "Calendar Bored";
        items[117] = "Calendar Happy";
        items[118] = "Calendar Scared";
        items[119] = "Calendar Sick";
        items[120] = "Camcorder Bored";
        items[121] = "Camcorder Happy";
        items[122] = "Camcorder Scared";
        items[123] = "Camcorder Sick";
        items[124] = "Candy Bar Bored";
        items[125] = "Candy Bar Happy";
        items[126] = "Candy Bar Scared";
        items[127] = "Candy Bar Sick";
        items[128] = "Cannedham Bored";
        items[129] = "Cannedham Happy";
        items[130] = "Cannedham Scared";
        items[131] = "Cannedham Sick";
        items[132] = "Car Bored";
        items[133] = "Car Happy";
        items[134] = "Car Scared";
        items[135] = "Car Sick";
        items[136] = "Cash Register Bored";
        items[137] = "Cash Register Happy";
        items[138] = "Cash Register Scared";
        items[139] = "Cash Register Sick";
        items[140] = "Cassettetape Bored";
        items[141] = "Cassettetape Happy";
        items[142] = "Cassettetape Scared";
        items[143] = "Cassettetape Sick";
        items[144] = "Cat Bored";
        items[145] = "Cat Happy";
        items[146] = "Cat Scared";
        items[147] = "Cat Sick";
        items[148] = "Cd Bored";
        items[149] = "Cd Happy";
        items[150] = "Cd Scared";
        items[151] = "Cd Sick";
        items[152] = "Chain Bored";
        items[153] = "Chain Happy";
        items[154] = "Chain Scared";
        items[155] = "Chain Sick";
        items[156] = "Chainsaw Bored";
        items[157] = "Chainsaw Happy";
        items[158] = "Chainsaw Scared";
        items[159] = "Chainsaw Sick";
        items[160] = "Chameleon Bored";
        items[161] = "Chameleon Happy";
        items[162] = "Chameleon Scared";
        items[163] = "Chameleon Sick";
        items[164] = "Chart Bars Bored";
        items[165] = "Chart Bars Happy";
        items[166] = "Chart Bars Scared";
        items[167] = "Chart Bars Sick";
        items[168] = "Cheese Bored";
        items[169] = "Cheese Happy";
        items[170] = "Cheese Scared";
        items[171] = "Cheese Sick";
        items[172] = "Chefhat Bored";
        items[173] = "Chefhat Happy";
        items[174] = "Chefhat Scared";
        items[175] = "Chefhat Sick";
        items[176] = "Cherry Bored";
        items[177] = "Cherry Happy";
        items[178] = "Cherry Scared";
        items[179] = "Cherry Sick";
        items[180] = "Chicken Bored";
        items[181] = "Chicken Happy";
        items[182] = "Chicken Scared";
        items[183] = "Chicken Sick";
        items[184] = "Chipboard Bored";
        items[185] = "Chipboard Happy";
        items[186] = "Chipboard Scared";
        items[187] = "Chipboard Sick";
        items[188] = "Chips Bored";
        items[189] = "Chips Happy";
        items[190] = "Chips Scared";
        items[191] = "Chips Sick";
        items[192] = "Cloud Bored";
        items[193] = "Cloud Happy";
        items[194] = "Cloud Scared";
        items[195] = "Cloud Sick";
        items[196] = "Clover Bored";
        items[197] = "Clover Happy";
        items[198] = "Clover Scared";
        items[199] = "Clover Sick";
        items[200] = "Clutch Bored";
        items[201] = "Clutch Happy";
        items[202] = "Clutch Scared";
        items[203] = "Clutch Sick";
        items[204] = "Coffeebean Bored";
        items[205] = "Coffeebean Happy";
        items[206] = "Coffeebean Scared";
        items[207] = "Coffeebean Sick";
        items[208] = "Cone Bored";
        items[209] = "Cone Happy";
        items[210] = "Cone Scared";
        items[211] = "Cone Sick";
        items[212] = "Console Handheld Bored";
        items[213] = "Console Handheld Happy";
        items[214] = "Console Handheld Scared";
        items[215] = "Console Handheld Sick";
        items[216] = "Cookie Bored";
        items[217] = "Cookie Happy";
        items[218] = "Cookie Scared";
        items[219] = "Cookie Sick";
        items[220] = "Cordlessphone Bored";
        items[221] = "Cordlessphone Happy";
        items[222] = "Cordlessphone Scared";
        items[223] = "Cordlessphone Sick";
        items[224] = "Cottonball Bored";
        items[225] = "Cottonball Happy";
        items[226] = "Cottonball Scared";
        items[227] = "Cottonball Sick";
        items[228] = "Couch Bored";
        items[229] = "Couch Happy";
        items[230] = "Couch Scared";
        items[231] = "Couch Sick";
        items[232] = "Cow Bored";
        items[233] = "Cow Happy";
        items[234] = "Cow Scared";
        items[235] = "Cow Sick";
        items[236] = "Crab Bored";
        items[237] = "Crab Happy";
        items[238] = "Crab Scared";
        items[239] = "Crab Sick";
        items[240] = "Crane Bored";
        items[241] = "Crane Happy";
        items[242] = "Crane Scared";
        items[243] = "Crane Sick";
        items[244] = "Croc Hat Bored";
        items[245] = "Croc Hat Happy";
        items[246] = "Croc Hat Scared";
        items[247] = "Croc Hat Sick";
        items[248] = "Crown Bored";
        items[249] = "Crown Happy";
        items[250] = "Crown Scared";
        items[251] = "Crown Sick";
        items[252] = "Crt Bsod Bored";
        items[253] = "Crt Bsod Happy";
        items[254] = "Crt Bsod Scared";
        items[255] = "Crt Bsod Sick";
        items[256] = "Crystallball Bored";
        items[257] = "Crystallball Happy";
        items[258] = "Crystallball Scared";
        items[259] = "Crystallball Sick";
        items[260] = "Diamond Blue Bored";
        items[261] = "Diamond Blue Happy";
        items[262] = "Diamond Blue Scared";
        items[263] = "Diamond Blue Sick";
        items[264] = "Diamond Red Bored";
        items[265] = "Diamond Red Happy";
        items[266] = "Diamond Red Scared";
        items[267] = "Diamond Red Sick";
        items[268] = "Dictionary Bored";
        items[269] = "Dictionary Happy";
        items[270] = "Dictionary Scared";
        items[271] = "Dictionary Sick";
        items[272] = "Dino Bored";
        items[273] = "Dino Happy";
        items[274] = "Dino Scared";
        items[275] = "Dino Sick";
        items[276] = "Dna Bored";
        items[277] = "Dna Happy";
        items[278] = "Dna Scared";
        items[279] = "Dna Sick";
        items[280] = "Dog Bored";
        items[281] = "Dog Happy";
        items[282] = "Dog Scared";
        items[283] = "Dog Sick";
        items[284] = "Doughnut Bored";
        items[285] = "Doughnut Happy";
        items[286] = "Doughnut Scared";
        items[287] = "Doughnut Sick";
        items[288] = "Drill Bored";
        items[289] = "Drill Happy";
        items[290] = "Drill Scared";
        items[291] = "Drill Sick";
        items[292] = "Duck Bored";
        items[293] = "Duck Happy";
        items[294] = "Duck Scared";
        items[295] = "Duck Sick";
        items[296] = "Ducky Bored";
        items[297] = "Ducky Happy";
        items[298] = "Ducky Scared";
        items[299] = "Ducky Sick";
        items[300] = "Earth Bored";
        items[301] = "Earth Happy";
        items[302] = "Earth Scared";
        items[303] = "Earth Sick";
        items[304] = "Egg Bored";
        items[305] = "Egg Happy";
        items[306] = "Egg Scared";
        items[307] = "Egg Sick";
        items[308] = "Faberge Bored";
        items[309] = "Faberge Happy";
        items[310] = "Faberge Scared";
        items[311] = "Faberge Sick";
        items[312] = "Factory Dark Bored";
        items[313] = "Factory Dark Happy";
        items[314] = "Factory Dark Scared";
        items[315] = "Factory Dark Sick";
        items[316] = "Fan Bored";
        items[317] = "Fan Happy";
        items[318] = "Fan Scared";
        items[319] = "Fan Sick";
        items[320] = "Fence Bored";
        items[321] = "Fence Happy";
        items[322] = "Fence Scared";
        items[323] = "Fence Sick";
        items[324] = "Film 35mm Bored";
        items[325] = "Film 35mm Happy";
        items[326] = "Film 35mm Scared";
        items[327] = "Film 35mm Sick";
        items[328] = "Film Strip Bored";
        items[329] = "Film Strip Happy";
        items[330] = "Film Strip Scared";
        items[331] = "Film Strip Sick";
        items[332] = "Fir Bored";
        items[333] = "Fir Happy";
        items[334] = "Fir Scared";
        items[335] = "Fir Sick";
        items[336] = "Firehydrant Bored";
        items[337] = "Firehydrant Happy";
        items[338] = "Firehydrant Scared";
        items[339] = "Firehydrant Sick";
        items[340] = "Flamingo Bored";
        items[341] = "Flamingo Happy";
        items[342] = "Flamingo Scared";
        items[343] = "Flamingo Sick";
        items[344] = "Flower Bored";
        items[345] = "Flower Happy";
        items[346] = "Flower Scared";
        items[347] = "Flower Sick";
        items[348] = "Fox Bored";
        items[349] = "Fox Happy";
        items[350] = "Fox Scared";
        items[351] = "Fox Sick";
        items[352] = "Frog Bored";
        items[353] = "Frog Happy";
        items[354] = "Frog Scared";
        items[355] = "Frog Sick";
        items[356] = "Garlic Bored";
        items[357] = "Garlic Happy";
        items[358] = "Garlic Scared";
        items[359] = "Garlic Sick";
        items[360] = "Gavel Bored";
        items[361] = "Gavel Happy";
        items[362] = "Gavel Scared";
        items[363] = "Gavel Sick";
        items[364] = "Ghost B Bored";
        items[365] = "Ghost B Happy";
        items[366] = "Ghost B Scared";
        items[367] = "Ghost B Sick";
        items[368] = "Glasses Big Bored";
        items[369] = "Glasses Big Happy";
        items[370] = "Glasses Big Scared";
        items[371] = "Glasses Big Sick";
        items[372] = "Gnomes Bored";
        items[373] = "Gnomes Happy";
        items[374] = "Gnomes Scared";
        items[375] = "Gnomes Sick";
        items[376] = "Goat Bored";
        items[377] = "Goat Happy";
        items[378] = "Goat Scared";
        items[379] = "Goat Sick";
        items[380] = "Goldcoin Bored";
        items[381] = "Goldcoin Happy";
        items[382] = "Goldcoin Scared";
        items[383] = "Goldcoin Sick";
        items[384] = "Goldfish Bored";
        items[385] = "Goldfish Happy";
        items[386] = "Goldfish Scared";
        items[387] = "Goldfish Sick";
        items[388] = "Grouper Bored";
        items[389] = "Grouper Happy";
        items[390] = "Grouper Scared";
        items[391] = "Grouper Sick";
        items[392] = "Hair Bored";
        items[393] = "Hair Happy";
        items[394] = "Hair Scared";
        items[395] = "Hair Sick";
        items[396] = "Hanger Bored";
        items[397] = "Hanger Happy";
        items[398] = "Hanger Scared";
        items[399] = "Hanger Sick";
        items[400] = "Hardhat Bored";
        items[401] = "Hardhat Happy";
        items[402] = "Hardhat Scared";
        items[403] = "Hardhat Sick";
        items[404] = "Heart Bored";
        items[405] = "Heart Happy";
        items[406] = "Heart Scared";
        items[407] = "Heart Sick";
        items[408] = "Helicopter Bored";
        items[409] = "Helicopter Happy";
        items[410] = "Helicopter Scared";
        items[411] = "Helicopter Sick";
        items[412] = "Highheel Bored";
        items[413] = "Highheel Happy";
        items[414] = "Highheel Scared";
        items[415] = "Highheel Sick";
        items[416] = "Hockeypuck Bored";
        items[417] = "Hockeypuck Happy";
        items[418] = "Hockeypuck Scared";
        items[419] = "Hockeypuck Sick";
        items[420] = "Horse Deepfried Bored";
        items[421] = "Horse Deepfried Happy";
        items[422] = "Horse Deepfried Scared";
        items[423] = "Horse Deepfried Sick";
        items[424] = "Hotdog Bored";
        items[425] = "Hotdog Happy";
        items[426] = "Hotdog Scared";
        items[427] = "Hotdog Sick";
        items[428] = "House Bored";
        items[429] = "House Happy";
        items[430] = "House Scared";
        items[431] = "House Sick";
        items[432] = "Icepop B Bored";
        items[433] = "Icepop B Happy";
        items[434] = "Icepop B Scared";
        items[435] = "Icepop B Sick";
        items[436] = "Igloo Bored";
        items[437] = "Igloo Happy";
        items[438] = "Igloo Scared";
        items[439] = "Igloo Sick";
        items[440] = "Island Bored";
        items[441] = "Island Happy";
        items[442] = "Island Scared";
        items[443] = "Island Sick";
        items[444] = "Jellyfish Bored";
        items[445] = "Jellyfish Happy";
        items[446] = "Jellyfish Scared";
        items[447] = "Jellyfish Sick";
        items[448] = "Jupiter Bored";
        items[449] = "Jupiter Happy";
        items[450] = "Jupiter Scared";
        items[451] = "Jupiter Sick";
        items[452] = "Kangaroo Bored";
        items[453] = "Kangaroo Happy";
        items[454] = "Kangaroo Scared";
        items[455] = "Kangaroo Sick";
        items[456] = "Ketchup Bored";
        items[457] = "Ketchup Happy";
        items[458] = "Ketchup Scared";
        items[459] = "Ketchup Sick";
        items[460] = "Laptop Bored";
        items[461] = "Laptop Happy";
        items[462] = "Laptop Scared";
        items[463] = "Laptop Sick";
        items[464] = "Lightning Bolt Bored";
        items[465] = "Lightning Bolt Happy";
        items[466] = "Lightning Bolt Scared";
        items[467] = "Lightning Bolt Sick";
        items[468] = "Lint Bored";
        items[469] = "Lint Happy";
        items[470] = "Lint Scared";
        items[471] = "Lint Sick";
        items[472] = "Lips Bored";
        items[473] = "Lips Happy";
        items[474] = "Lips Scared";
        items[475] = "Lips Sick";
        items[476] = "Lipstick2 Bored";
        items[477] = "Lipstick2 Happy";
        items[478] = "Lipstick2 Scared";
        items[479] = "Lipstick2 Sick";
        items[480] = "Lock Bored";
        items[481] = "Lock Happy";
        items[482] = "Lock Scared";
        items[483] = "Lock Sick";
        items[484] = "Macaroni Bored";
        items[485] = "Macaroni Happy";
        items[486] = "Macaroni Scared";
        items[487] = "Macaroni Sick";
        items[488] = "Mailbox Bored";
        items[489] = "Mailbox Happy";
        items[490] = "Mailbox Scared";
        items[491] = "Mailbox Sick";
        items[492] = "Maze Bored";
        items[493] = "Maze Happy";
        items[494] = "Maze Scared";
        items[495] = "Maze Sick";
        items[496] = "Microwave Bored";
        items[497] = "Microwave Happy";
        items[498] = "Microwave Scared";
        items[499] = "Microwave Sick";
        items[500] = "Milk Bored";
        items[501] = "Milk Happy";
        items[502] = "Milk Scared";
        items[503] = "Milk Sick";
        items[504] = "Mirror Bored";
        items[505] = "Mirror Happy";
        items[506] = "Mirror Scared";
        items[507] = "Mirror Sick";
        items[508] = "Mixer Bored";
        items[509] = "Mixer Happy";
        items[510] = "Mixer Scared";
        items[511] = "Mixer Sick";
        items[512] = "Moon Bored";
        items[513] = "Moon Happy";
        items[514] = "Moon Scared";
        items[515] = "Moon Sick";
        items[516] = "Moose Bored";
        items[517] = "Moose Happy";
        items[518] = "Moose Scared";
        items[519] = "Moose Sick";
        items[520] = "Mosquito Bored";
        items[521] = "Mosquito Happy";
        items[522] = "Mosquito Scared";
        items[523] = "Mosquito Sick";
        items[524] = "Mountain Snowcap Bored";
        items[525] = "Mountain Snowcap Happy";
        items[526] = "Mountain Snowcap Scared";
        items[527] = "Mountain Snowcap Sick";
        items[528] = "Mouse Bored";
        items[529] = "Mouse Happy";
        items[530] = "Mouse Scared";
        items[531] = "Mouse Sick";
        items[532] = "Mug Bored";
        items[533] = "Mug Happy";
        items[534] = "Mug Scared";
        items[535] = "Mug Sick";
        items[536] = "Mushroom Bored";
        items[537] = "Mushroom Happy";
        items[538] = "Mushroom Scared";
        items[539] = "Mushroom Sick";
        items[540] = "Mustard Bored";
        items[541] = "Mustard Happy";
        items[542] = "Mustard Scared";
        items[543] = "Mustard Sick";
        items[544] = "Nigiri Bored";
        items[545] = "Nigiri Happy";
        items[546] = "Nigiri Scared";
        items[547] = "Nigiri Sick";
        items[548] = "Noodles Bored";
        items[549] = "Noodles Happy";
        items[550] = "Noodles Scared";
        items[551] = "Noodles Sick";
        items[552] = "Onion Bored";
        items[553] = "Onion Happy";
        items[554] = "Onion Scared";
        items[555] = "Onion Sick";
        items[556] = "Orangutan Bored";
        items[557] = "Orangutan Happy";
        items[558] = "Orangutan Scared";
        items[559] = "Orangutan Sick";
        items[560] = "Orca Bored";
        items[561] = "Orca Happy";
        items[562] = "Orca Scared";
        items[563] = "Orca Sick";
        items[564] = "Otter Bored";
        items[565] = "Otter Happy";
        items[566] = "Otter Scared";
        items[567] = "Otter Sick";
        items[568] = "Outlet Bored";
        items[569] = "Outlet Happy";
        items[570] = "Outlet Scared";
        items[571] = "Outlet Sick";
        items[572] = "Owl Bored";
        items[573] = "Owl Happy";
        items[574] = "Owl Scared";
        items[575] = "Owl Sick";
        items[576] = "Oyster Bored";
        items[577] = "Oyster Happy";
        items[578] = "Oyster Scared";
        items[579] = "Oyster Sick";
        items[580] = "Paintbrush Bored";
        items[581] = "Paintbrush Happy";
        items[582] = "Paintbrush Scared";
        items[583] = "Paintbrush Sick";
        items[584] = "Panda Bored";
        items[585] = "Panda Happy";
        items[586] = "Panda Scared";
        items[587] = "Panda Sick";
        items[588] = "Paperclip Bored";
        items[589] = "Paperclip Happy";
        items[590] = "Paperclip Scared";
        items[591] = "Paperclip Sick";
        items[592] = "Peanut Bored";
        items[593] = "Peanut Happy";
        items[594] = "Peanut Scared";
        items[595] = "Peanut Sick";
        items[596] = "Pencil Tip Bored";
        items[597] = "Pencil Tip Happy";
        items[598] = "Pencil Tip Scared";
        items[599] = "Pencil Tip Sick";
        items[600] = "Peyote Bored";
        items[601] = "Peyote Happy";
        items[602] = "Peyote Scared";
        items[603] = "Peyote Sick";
        items[604] = "Piano Bored";
        items[605] = "Piano Happy";
        items[606] = "Piano Scared";
        items[607] = "Piano Sick";
        items[608] = "Pickle Bored";
        items[609] = "Pickle Happy";
        items[610] = "Pickle Scared";
        items[611] = "Pickle Sick";
        items[612] = "Pie Bored";
        items[613] = "Pie Happy";
        items[614] = "Pie Scared";
        items[615] = "Pie Sick";
        items[616] = "Piggybank Bored";
        items[617] = "Piggybank Happy";
        items[618] = "Piggybank Scared";
        items[619] = "Piggybank Sick";
        items[620] = "Pill Bored";
        items[621] = "Pill Happy";
        items[622] = "Pill Scared";
        items[623] = "Pill Sick";
        items[624] = "Pillow Bored";
        items[625] = "Pillow Happy";
        items[626] = "Pillow Scared";
        items[627] = "Pillow Sick";
        items[628] = "Pineapple Bored";
        items[629] = "Pineapple Happy";
        items[630] = "Pineapple Scared";
        items[631] = "Pineapple Sick";
        items[632] = "Pipe Bored";
        items[633] = "Pipe Happy";
        items[634] = "Pipe Scared";
        items[635] = "Pipe Sick";
        items[636] = "Pirateship Bored";
        items[637] = "Pirateship Happy";
        items[638] = "Pirateship Scared";
        items[639] = "Pirateship Sick";
        items[640] = "Pizza Bored";
        items[641] = "Pizza Happy";
        items[642] = "Pizza Scared";
        items[643] = "Pizza Sick";
        items[644] = "Plane Bored";
        items[645] = "Plane Happy";
        items[646] = "Plane Scared";
        items[647] = "Plane Sick";
        items[648] = "Pop Bored";
        items[649] = "Pop Happy";
        items[650] = "Pop Scared";
        items[651] = "Pop Sick";
        items[652] = "Porkbao Bored";
        items[653] = "Porkbao Happy";
        items[654] = "Porkbao Scared";
        items[655] = "Porkbao Sick";
        items[656] = "Pufferfish Bored";
        items[657] = "Pufferfish Happy";
        items[658] = "Pufferfish Scared";
        items[659] = "Pufferfish Sick";
        items[660] = "Pumpkin Bored";
        items[661] = "Pumpkin Happy";
        items[662] = "Pumpkin Scared";
        items[663] = "Pumpkin Sick";
        items[664] = "Pyramid Bored";
        items[665] = "Pyramid Happy";
        items[666] = "Pyramid Scared";
        items[667] = "Pyramid Sick";
        items[668] = "Queencrown Bored";
        items[669] = "Queencrown Happy";
        items[670] = "Queencrown Scared";
        items[671] = "Queencrown Sick";
        items[672] = "Rabbit Bored";
        items[673] = "Rabbit Happy";
        items[674] = "Rabbit Scared";
        items[675] = "Rabbit Sick";
        items[676] = "Rainbow Bored";
        items[677] = "Rainbow Happy";
        items[678] = "Rainbow Scared";
        items[679] = "Rainbow Sick";
        items[680] = "Rangefinder Bored";
        items[681] = "Rangefinder Happy";
        items[682] = "Rangefinder Scared";
        items[683] = "Rangefinder Sick";
        items[684] = "Raven Bored";
        items[685] = "Raven Happy";
        items[686] = "Raven Scared";
        items[687] = "Raven Sick";
        items[688] = "Retainer Bored";
        items[689] = "Retainer Happy";
        items[690] = "Retainer Scared";
        items[691] = "Retainer Sick";
        items[692] = "Rgb Bored";
        items[693] = "Rgb Happy";
        items[694] = "Rgb Scared";
        items[695] = "Rgb Sick";
        items[696] = "Ring Bored";
        items[697] = "Ring Happy";
        items[698] = "Ring Scared";
        items[699] = "Ring Sick";
        items[700] = "Road Bored";
        items[701] = "Road Happy";
        items[702] = "Road Scared";
        items[703] = "Road Sick";
        items[704] = "Robot Bored";
        items[705] = "Robot Happy";
        items[706] = "Robot Scared";
        items[707] = "Robot Sick";
        items[708] = "Rock Bored";
        items[709] = "Rock Happy";
        items[710] = "Rock Scared";
        items[711] = "Rock Sick";
        items[712] = "Rosebud Bored";
        items[713] = "Rosebud Happy";
        items[714] = "Rosebud Scared";
        items[715] = "Rosebud Sick";
        items[716] = "Ruler Triangular Bored";
        items[717] = "Ruler Triangular Happy";
        items[718] = "Ruler Triangular Scared";
        items[719] = "Ruler Triangular Sick";
        items[720] = "Safe Bored";
        items[721] = "Safe Happy";
        items[722] = "Safe Scared";
        items[723] = "Safe Sick";
        items[724] = "Saguaro Bored";
        items[725] = "Saguaro Happy";
        items[726] = "Saguaro Scared";
        items[727] = "Saguaro Sick";
        items[728] = "Sailboat Bored";
        items[729] = "Sailboat Happy";
        items[730] = "Sailboat Scared";
        items[731] = "Sailboat Sick";
        items[732] = "Sandwich Bored";
        items[733] = "Sandwich Happy";
        items[734] = "Sandwich Scared";
        items[735] = "Sandwich Sick";
        items[736] = "Saturn Bored";
        items[737] = "Saturn Happy";
        items[738] = "Saturn Scared";
        items[739] = "Saturn Sick";
        items[740] = "Saw Bored";
        items[741] = "Saw Happy";
        items[742] = "Saw Scared";
        items[743] = "Saw Sick";
        items[744] = "Scorpion Bored";
        items[745] = "Scorpion Happy";
        items[746] = "Scorpion Scared";
        items[747] = "Scorpion Sick";
        items[748] = "Shark Bored";
        items[749] = "Shark Happy";
        items[750] = "Shark Scared";
        items[751] = "Shark Sick";
        items[752] = "Shower Bored";
        items[753] = "Shower Happy";
        items[754] = "Shower Scared";
        items[755] = "Shower Sick";
        items[756] = "Skateboard Bored";
        items[757] = "Skateboard Happy";
        items[758] = "Skateboard Scared";
        items[759] = "Skateboard Sick";
        items[760] = "Skeleton Hat Bored";
        items[761] = "Skeleton Hat Happy";
        items[762] = "Skeleton Hat Scared";
        items[763] = "Skeleton Hat Sick";
        items[764] = "Skilift Bored";
        items[765] = "Skilift Happy";
        items[766] = "Skilift Scared";
        items[767] = "Skilift Sick";
        items[768] = "Snowglobe Bored";
        items[769] = "Snowglobe Happy";
        items[770] = "Snowglobe Scared";
        items[771] = "Snowglobe Sick";
        items[772] = "Snowman Bored";
        items[773] = "Snowman Happy";
        items[774] = "Snowman Scared";
        items[775] = "Snowman Sick";
        items[776] = "Snowmobile Bored";
        items[777] = "Snowmobile Happy";
        items[778] = "Snowmobile Scared";
        items[779] = "Snowmobile Sick";
        items[780] = "Spaghetti Bored";
        items[781] = "Spaghetti Happy";
        items[782] = "Spaghetti Scared";
        items[783] = "Spaghetti Sick";
        items[784] = "Sponge Bored";
        items[785] = "Sponge Happy";
        items[786] = "Sponge Scared";
        items[787] = "Sponge Sick";
        items[788] = "Squid Bored";
        items[789] = "Squid Happy";
        items[790] = "Squid Scared";
        items[791] = "Squid Sick";
        items[792] = "Stapler Bored";
        items[793] = "Stapler Happy";
        items[794] = "Stapler Scared";
        items[795] = "Stapler Sick";
        items[796] = "Star Sparkles Bored";
        items[797] = "Star Sparkles Happy";
        items[798] = "Star Sparkles Scared";
        items[799] = "Star Sparkles Sick";
        items[800] = "Steak Bored";
        items[801] = "Steak Happy";
        items[802] = "Steak Scared";
        items[803] = "Steak Sick";
        items[804] = "Sunset Bored";
        items[805] = "Sunset Happy";
        items[806] = "Sunset Scared";
        items[807] = "Sunset Sick";
        items[808] = "Taco Bored";
        items[809] = "Taco Happy";
        items[810] = "Taco Scared";
        items[811] = "Taco Sick";
        items[812] = "Taxi Bored";
        items[813] = "Taxi Happy";
        items[814] = "Taxi Scared";
        items[815] = "Taxi Sick";
        items[816] = "Thumbsup Bored";
        items[817] = "Thumbsup Happy";
        items[818] = "Thumbsup Scared";
        items[819] = "Thumbsup Sick";
        items[820] = "Toaster Bored";
        items[821] = "Toaster Happy";
        items[822] = "Toaster Scared";
        items[823] = "Toaster Sick";
        items[824] = "Tooth Bored";
        items[825] = "Tooth Happy";
        items[826] = "Tooth Scared";
        items[827] = "Tooth Sick";
        items[828] = "Toothbrush Fresh Bored";
        items[829] = "Toothbrush Fresh Happy";
        items[830] = "Toothbrush Fresh Scared";
        items[831] = "Toothbrush Fresh Sick";
        items[832] = "Tornado Bored";
        items[833] = "Tornado Happy";
        items[834] = "Tornado Scared";
        items[835] = "Tornado Sick";
        items[836] = "Trashcan Bored";
        items[837] = "Trashcan Happy";
        items[838] = "Trashcan Scared";
        items[839] = "Trashcan Sick";
        items[840] = "Treasurechest Bored";
        items[841] = "Treasurechest Happy";
        items[842] = "Treasurechest Scared";
        items[843] = "Treasurechest Sick";
        items[844] = "Turing Bored";
        items[845] = "Turing Happy";
        items[846] = "Turing Scared";
        items[847] = "Turing Sick";
        items[848] = "Ufo Bored";
        items[849] = "Ufo Happy";
        items[850] = "Ufo Scared";
        items[851] = "Ufo Sick";
        items[852] = "Undead Bored";
        items[853] = "Undead Happy";
        items[854] = "Undead Scared";
        items[855] = "Undead Sick";
        items[856] = "Unicorn Bored";
        items[857] = "Unicorn Happy";
        items[858] = "Unicorn Scared";
        items[859] = "Unicorn Sick";
        items[860] = "Vending Machine Bored";
        items[861] = "Vending Machine Happy";
        items[862] = "Vending Machine Scared";
        items[863] = "Vending Machine Sick";
        items[864] = "Vent Bored";
        items[865] = "Vent Happy";
        items[866] = "Vent Scared";
        items[867] = "Vent Sick";
        items[868] = "Void Bored";
        items[869] = "Void Happy";
        items[870] = "Void Scared";
        items[871] = "Void Sick";
        items[872] = "Volcano Bored";
        items[873] = "Volcano Happy";
        items[874] = "Volcano Scared";
        items[875] = "Volcano Sick";
        items[876] = "Volleyball Bored";
        items[877] = "Volleyball Happy";
        items[878] = "Volleyball Scared";
        items[879] = "Volleyball Sick";
        items[880] = "Wall Bored";
        items[881] = "Wall Happy";
        items[882] = "Wall Scared";
        items[883] = "Wall Sick";
        items[884] = "Wallet Bored";
        items[885] = "Wallet Happy";
        items[886] = "Wallet Scared";
        items[887] = "Wallet Sick";
        items[888] = "Washingmachine Bored";
        items[889] = "Washingmachine Happy";
        items[890] = "Washingmachine Scared";
        items[891] = "Washingmachine Sick";
        items[892] = "Watch Bored";
        items[893] = "Watch Happy";
        items[894] = "Watch Scared";
        items[895] = "Watch Sick";
        items[896] = "Watermelon Bored";
        items[897] = "Watermelon Happy";
        items[898] = "Watermelon Scared";
        items[899] = "Watermelon Sick";
        items[900] = "Wave Bored";
        items[901] = "Wave Happy";
        items[902] = "Wave Scared";
        items[903] = "Wave Sick";
        items[904] = "Weed Bored";
        items[905] = "Weed Happy";
        items[906] = "Weed Scared";
        items[907] = "Weed Sick";
        items[908] = "Weight Bored";
        items[909] = "Weight Happy";
        items[910] = "Weight Scared";
        items[911] = "Weight Sick";
        items[912] = "Werewolf Bored";
        items[913] = "Werewolf Happy";
        items[914] = "Werewolf Scared";
        items[915] = "Werewolf Sick";
        items[916] = "Whale Alive Bored";
        items[917] = "Whale Alive Happy";
        items[918] = "Whale Alive Scared";
        items[919] = "Whale Alive Sick";
        items[920] = "Whale Bored";
        items[921] = "Whale Happy";
        items[922] = "Whale Scared";
        items[923] = "Whale Sick";
        items[924] = "Wine Barrel Bored";
        items[925] = "Wine Barrel Happy";
        items[926] = "Wine Barrel Scared";
        items[927] = "Wine Barrel Sick";
        items[928] = "Wine Bored";
        items[929] = "Wine Happy";
        items[930] = "Wine Scared";
        items[931] = "Wine Sick";
        items[932] = "Wizardhat Bored";
        items[933] = "Wizardhat Happy";
        items[934] = "Wizardhat Scared";
        items[935] = "Wizardhat Sick";
        items[936] = "Zebra Bored";
        items[937] = "Zebra Happy";
        items[938] = "Zebra Scared";
        items[939] = "Zebra Sick";

        bytes memory data = abi.encode(items);

        VmSafe vm = VmSafe(
            address(uint160(uint256(keccak256("hevm cheat code"))))
        );

        string[] memory inputs = new string[](3);
        inputs[0] = "node";
        inputs[1] = "script/nouns-coasters/deflate.js";
        inputs[2] = vm.toString(data);

        bytes memory compressedData = vm.ffi(inputs);

        // address result = SSTORE2.write(compressedData);

        renderer.addLayer({
            target: target,
            ipfs: INounsCoasterMetadataRendererTypes.IPFSGroup({
                baseUri: "ipfs://bafybeiag26lh2at7iah5xqlrzgj2ei2jd2qel3g5bpccgfj5ktjbvu4qm4/",
                extension: ".png"
            }),
            decompressedSize: data.length,
            compressedData: compressedData,
            count: items.length,
            property: "12 Head rear right",
            variantProperty: variantPropertyParameters
        });
    }

    function addLayer13(NounsCoasterMetadataRenderer renderer, address target)
        internal
    {
        // 13 Expression rear right
        INounsCoasterMetadataRendererTypes.VariantPropertyParameters
            memory variantPropertyParameters;
        variantPropertyParameters
            .offsets = new INounsCoasterMetadataRendererTypes.VariantOffset[](
            0
        );
        variantPropertyParameters.id = 0;
        variantPropertyParameters.count = 0;

        string[] memory items = new string[](4);
        items[0] = "Bored";
        items[1] = "Happy";
        items[2] = "Scared";
        items[3] = "Sick";

        bytes memory data = abi.encode(items);

        VmSafe vm = VmSafe(
            address(uint160(uint256(keccak256("hevm cheat code"))))
        );

        string[] memory inputs = new string[](3);
        inputs[0] = "node";
        inputs[1] = "script/nouns-coasters/deflate.js";
        inputs[2] = vm.toString(data);

        bytes memory compressedData = vm.ffi(inputs);

        // address result = SSTORE2.write(compressedData);

        renderer.addLayer({
            target: target,
            ipfs: INounsCoasterMetadataRendererTypes.IPFSGroup({
                baseUri: "ipfs://bafybeiag26lh2at7iah5xqlrzgj2ei2jd2qel3g5bpccgfj5ktjbvu4qm4/",
                extension: ".png"
            }),
            decompressedSize: data.length,
            compressedData: compressedData,
            count: items.length,
            property: "13 Expression rear right",
            variantProperty: variantPropertyParameters
        });
    }

    function addLayer14(NounsCoasterMetadataRenderer renderer, address target)
        internal
    {
        // 14 Glasses rear right
        INounsCoasterMetadataRendererTypes.VariantPropertyParameters
            memory variantPropertyParameters;
        variantPropertyParameters
            .offsets = new INounsCoasterMetadataRendererTypes.VariantOffset[](
            0
        );
        variantPropertyParameters.id = 0;
        variantPropertyParameters.count = 0;

        string[] memory items = new string[](21);
        items[0] = "Black";
        items[1] = "Black Red Eyes";
        items[2] = "Black Rgb";
        items[3] = "Blue";
        items[4] = "Blue Med Saturated";
        items[5] = "Frog Green";
        items[6] = "Full Black";
        items[7] = "Green Blue Multi";
        items[8] = "Grey Light";
        items[9] = "Guava";
        items[10] = "Hip Rose";
        items[11] = "Honey";
        items[12] = "Magenta";
        items[13] = "Orange";
        items[14] = "Pink Purple Multi";
        items[15] = "Red";
        items[16] = "Smoke";
        items[17] = "Teal";
        items[18] = "Watermelon";
        items[19] = "Yellow Orange Multi";
        items[20] = "Yellow Saturated";

        bytes memory data = abi.encode(items);

        VmSafe vm = VmSafe(
            address(uint160(uint256(keccak256("hevm cheat code"))))
        );

        string[] memory inputs = new string[](3);
        inputs[0] = "node";
        inputs[1] = "script/nouns-coasters/deflate.js";
        inputs[2] = vm.toString(data);

        bytes memory compressedData = vm.ffi(inputs);

        // address result = SSTORE2.write(compressedData);

        renderer.addLayer({
            target: target,
            ipfs: INounsCoasterMetadataRendererTypes.IPFSGroup({
                baseUri: "ipfs://bafybeiag26lh2at7iah5xqlrzgj2ei2jd2qel3g5bpccgfj5ktjbvu4qm4/",
                extension: ".png"
            }),
            decompressedSize: data.length,
            compressedData: compressedData,
            count: items.length,
            property: "14 Glasses rear right",
            variantProperty: variantPropertyParameters
        });
    }

    function addLayer15(NounsCoasterMetadataRenderer renderer, address target)
        internal
    {
        // 15 Body front left
        INounsCoasterMetadataRendererTypes.VariantPropertyParameters
            memory variantPropertyParameters;
        variantPropertyParameters
            .offsets = new INounsCoasterMetadataRendererTypes.VariantOffset[](
            4
        );
        variantPropertyParameters.id = 2;
        variantPropertyParameters.count = 4;
        variantPropertyParameters.offsets[
            0
        ] = INounsCoasterMetadataRendererTypes.VariantOffset({
            startAt: 0,
            count: 30
        });
        variantPropertyParameters.offsets[
            1
        ] = INounsCoasterMetadataRendererTypes.VariantOffset({
            startAt: 30,
            count: 30
        });
        variantPropertyParameters.offsets[
            2
        ] = INounsCoasterMetadataRendererTypes.VariantOffset({
            startAt: 60,
            count: 30
        });
        variantPropertyParameters.offsets[
            3
        ] = INounsCoasterMetadataRendererTypes.VariantOffset({
            startAt: 90,
            count: 30
        });

        string[] memory items = new string[](120);
        items[0] = "1-Both Arms Down Bege Bsod";
        items[1] = "1-Both Arms Down Bege Crt";
        items[2] = "1-Both Arms Down Blue Grey";
        items[3] = "1-Both Arms Down Blue Sky";
        items[4] = "1-Both Arms Down Cold";
        items[5] = "1-Both Arms Down Computer Blue";
        items[6] = "1-Both Arms Down Dark Brown";
        items[7] = "1-Both Arms Down Dark Pink";
        items[8] = "1-Both Arms Down Foggrey";
        items[9] = "1-Both Arms Down Gold";
        items[10] = "1-Both Arms Down Gray Scale 1";
        items[11] = "1-Both Arms Down Gray Scale 7";
        items[12] = "1-Both Arms Down Gray Scale 8";
        items[13] = "1-Both Arms Down Gray Scale 9";
        items[14] = "1-Both Arms Down Green";
        items[15] = "1-Both Arms Down Gunk";
        items[16] = "1-Both Arms Down Hotbrown";
        items[17] = "1-Both Arms Down Magenta";
        items[18] = "1-Both Arms Down Orange";
        items[19] = "1-Both Arms Down Orange Yellow";
        items[20] = "1-Both Arms Down Peachy A";
        items[21] = "1-Both Arms Down Peachy B";
        items[22] = "1-Both Arms Down Purple";
        items[23] = "1-Both Arms Down Red";
        items[24] = "1-Both Arms Down Red Pinkish";
        items[25] = "1-Both Arms Down Rust";
        items[26] = "1-Both Arms Down Slime Green";
        items[27] = "1-Both Arms Down Teal";
        items[28] = "1-Both Arms Down Teal Light";
        items[29] = "1-Both Arms Down Yellow";
        items[30] = "2-Both Arms Up Bege Bsod";
        items[31] = "2-Both Arms Up Bege Crt";
        items[32] = "2-Both Arms Up Blue Grey";
        items[33] = "2-Both Arms Up Blue Sky";
        items[34] = "2-Both Arms Up Cold";
        items[35] = "2-Both Arms Up Computer Blue";
        items[36] = "2-Both Arms Up Dark Brown";
        items[37] = "2-Both Arms Up Dark Pink";
        items[38] = "2-Both Arms Up Foggrey";
        items[39] = "2-Both Arms Up Gold";
        items[40] = "2-Both Arms Up Gray Scale 1";
        items[41] = "2-Both Arms Up Gray Scale 7";
        items[42] = "2-Both Arms Up Gray Scale 8";
        items[43] = "2-Both Arms Up Gray Scale 9";
        items[44] = "2-Both Arms Up Green";
        items[45] = "2-Both Arms Up Gunk";
        items[46] = "2-Both Arms Up Hotbrown";
        items[47] = "2-Both Arms Up Magenta";
        items[48] = "2-Both Arms Up Orange";
        items[49] = "2-Both Arms Up Orange Yellow";
        items[50] = "2-Both Arms Up Peachy A";
        items[51] = "2-Both Arms Up Peachy B";
        items[52] = "2-Both Arms Up Purple";
        items[53] = "2-Both Arms Up Red";
        items[54] = "2-Both Arms Up Redpinkish";
        items[55] = "2-Both Arms Up Rust";
        items[56] = "2-Both Arms Up Slime Green";
        items[57] = "2-Both Arms Up Teal";
        items[58] = "2-Both Arms Up Teal Light";
        items[59] = "2-Both Arms Up Yellow";
        items[60] = "3-Left Arm Up Bege Bsod";
        items[61] = "3-Left Arm Up Bege Crt";
        items[62] = "3-Left Arm Up Blue Grey";
        items[63] = "3-Left Arm Up Blue Sky";
        items[64] = "3-Left Arm Up Cold";
        items[65] = "3-Left Arm Up Computer Blue";
        items[66] = "3-Left Arm Up Dark Brown";
        items[67] = "3-Left Arm Up Dark Pink";
        items[68] = "3-Left Arm Up Foggrey";
        items[69] = "3-Left Arm Up Gold";
        items[70] = "3-Left Arm Up Gray Scale 1";
        items[71] = "3-Left Arm Up Gray Scale 7";
        items[72] = "3-Left Arm Up Gray Scale 8";
        items[73] = "3-Left Arm Up Gray Scale 9";
        items[74] = "3-Left Arm Up Green";
        items[75] = "3-Left Arm Up Gunk";
        items[76] = "3-Left Arm Up Hotbrown";
        items[77] = "3-Left Arm Up Magenta";
        items[78] = "3-Left Arm Up Orange";
        items[79] = "3-Left Arm Up Orange Yellow";
        items[80] = "3-Left Arm Up Peachy A";
        items[81] = "3-Left Arm Up Peachy B";
        items[82] = "3-Left Arm Up Purple";
        items[83] = "3-Left Arm Up Red";
        items[84] = "3-Left Arm Up Redpinkish";
        items[85] = "3-Left Arm Up Rust";
        items[86] = "3-Left Arm Up Slime Green";
        items[87] = "3-Left Arm Up Teal";
        items[88] = "3-Left Arm Up Teal Light";
        items[89] = "3-Left Arm Up Yellow";
        items[90] = "4-BODY_FRONT_LEFT_RIGHT_ARM_UP_BEGE_BSOD";
        items[91] = "4-BODY_FRONT_LEFT_RIGHT_ARM_UP_BEGE_CRT_1";
        items[92] = "4-BODY_FRONT_LEFT_RIGHT_ARM_UP_BLUE_GREY_1";
        items[93] = "4-BODY_FRONT_LEFT_RIGHT_ARM_UP_BLUE_SKY";
        items[94] = "4-BODY_FRONT_LEFT_RIGHT_ARM_UP_COLD_1";
        items[95] = "4-BODY_FRONT_LEFT_RIGHT_ARM_UP_COMPUTER_BLUE_1";
        items[96] = "4-BODY_FRONT_LEFT_RIGHT_ARM_UP_DARK_BROWN_1";
        items[97] = "4-BODY_FRONT_LEFT_RIGHT_ARM_UP_DARK_PINK_1";
        items[98] = "4-BODY_FRONT_LEFT_RIGHT_ARM_UP_FOGGREY_1";
        items[99] = "4-BODY_FRONT_LEFT_RIGHT_ARM_UP_GOLD_1";
        items[100] = "4-BODY_FRONT_LEFT_RIGHT_ARM_UP_GRAY_SCALE_1_1";
        items[101] = "4-BODY_FRONT_LEFT_RIGHT_ARM_UP_GRAY_SCALE_7_1";
        items[102] = "4-BODY_FRONT_LEFT_RIGHT_ARM_UP_GRAY_SCALE_8_1";
        items[103] = "4-BODY_FRONT_LEFT_RIGHT_ARM_UP_GRAY_SCALE_9_1";
        items[104] = "4-BODY_FRONT_LEFT_RIGHT_ARM_UP_GREEN_1";
        items[105] = "4-BODY_FRONT_LEFT_RIGHT_ARM_UP_GUNK_1";
        items[106] = "4-BODY_FRONT_LEFT_RIGHT_ARM_UP_HOTBROWN_1";
        items[107] = "4-BODY_FRONT_LEFT_RIGHT_ARM_UP_MAGENTA_1";
        items[108] = "4-BODY_FRONT_LEFT_RIGHT_ARM_UP_ORANGE_1";
        items[109] = "4-BODY_FRONT_LEFT_RIGHT_ARM_UP_ORANGE_YELLOW_1";
        items[110] = "4-BODY_FRONT_LEFT_RIGHT_ARM_UP_PEACHY_A_1";
        items[111] = "4-BODY_FRONT_LEFT_RIGHT_ARM_UP_PEACHY_B_1";
        items[112] = "4-BODY_FRONT_LEFT_RIGHT_PURPLE_1";
        items[113] = "4-BODY_FRONT_LEFT_RIGHT_RED_1";
        items[114] = "4-BODY_FRONT_LEFT_RIGHT_RED_PINKISH_1";
        items[115] = "4-BODY_FRONT_LEFT_RIGHT_RUST_1";
        items[116] = "4-BODY_FRONT_LEFT_RIGHT_SLIME_GREEN_1";
        items[117] = "4-BODY_FRONT_LEFT_RIGHT_TEAL_1";
        items[118] = "4-BODY_FRONT_LEFT_RIGHT_TEAL_LIGHT_1";
        items[119] = "4-BODY_FRONT_LEFT_RIGHT_YELLOW";

        bytes memory data = abi.encode(items);

        VmSafe vm = VmSafe(
            address(uint160(uint256(keccak256("hevm cheat code"))))
        );

        string[] memory inputs = new string[](3);
        inputs[0] = "node";
        inputs[1] = "script/nouns-coasters/deflate.js";
        inputs[2] = vm.toString(data);

        bytes memory compressedData = vm.ffi(inputs);

        // address result = SSTORE2.write(compressedData);

        renderer.addLayer({
            target: target,
            ipfs: INounsCoasterMetadataRendererTypes.IPFSGroup({
                baseUri: "ipfs://bafybeiag26lh2at7iah5xqlrzgj2ei2jd2qel3g5bpccgfj5ktjbvu4qm4/",
                extension: ".png"
            }),
            decompressedSize: data.length,
            compressedData: compressedData,
            count: items.length,
            property: "15 Body front left",
            variantProperty: variantPropertyParameters
        });
    }

    function addLayer16(NounsCoasterMetadataRenderer renderer, address target)
        internal
    {
        // 16 Accessories front left
        INounsCoasterMetadataRendererTypes.VariantPropertyParameters
            memory variantPropertyParameters;
        variantPropertyParameters
            .offsets = new INounsCoasterMetadataRendererTypes.VariantOffset[](
            4
        );
        variantPropertyParameters.id = 2;
        variantPropertyParameters.count = 4;
        variantPropertyParameters.offsets[
            0
        ] = INounsCoasterMetadataRendererTypes.VariantOffset({
            startAt: 0,
            count: 139
        });
        variantPropertyParameters.offsets[
            1
        ] = INounsCoasterMetadataRendererTypes.VariantOffset({
            startAt: 139,
            count: 137
        });
        variantPropertyParameters.offsets[
            2
        ] = INounsCoasterMetadataRendererTypes.VariantOffset({
            startAt: 276,
            count: 137
        });
        variantPropertyParameters.offsets[
            3
        ] = INounsCoasterMetadataRendererTypes.VariantOffset({
            startAt: 413,
            count: 137
        });

        string[] memory items = new string[](550);
        items[0] = "1-Asset Front Left 1n";
        items[1] = "1-Asset Front Left Aardvark";
        items[2] = "1-Asset Front Left Axe";
        items[3] = "1-Asset Front Left Belly Chamaleon";
        items[4] = "1-Asset Front Left Bird Flying";
        items[5] = "1-Asset Front Left Bird Side";
        items[6] = "1-Asset Front Left Bling Anchor";
        items[7] = "1-Asset Front Left Bling Anvil";
        items[8] = "1-Asset Front Left Bling Arrow";
        items[9] = "1-Asset Front Left Bling Cheese";
        items[10] = "1-Asset Front Left Bling Gold Ingot";
        items[11] = "1-Asset Front Left Bling Love";
        items[12] = "1-Asset Front Left Bling Mask";
        items[13] = "1-Asset Front Left Bling Rings";
        items[14] = "1-Asset Front Left Bling Scissors";
        items[15] = "1-Asset Front Left Both Arms Down Bege Bsod";
        items[16] = "1-Asset Front Left Both Arms Down Belly Chamaleon";
        items[17] = "1-Asset Front Left Both Arms Down Bigwalk Blue Prime";
        items[18] = "1-Asset Front Left Both Arms Down Bigwalk Greylight";
        items[19] = "1-Asset Front Left Both Arms Down Bigwalk Rainbow";
        items[20] = "1-Asset Front Left Both Arms Down Chain Logo";
        items[21] = "1-Asset Front Left Both Arms Down Checker Disco";
        items[22] = "1-Asset Front Left Both Arms Down Checker Rgb";
        items[23] = "1-Asset Front Left Both Arms Down Checker Spaced Black";
        items[24] = "1-Asset Front Left Both Arms Down Checker Spaced White";
        items[25] = "1-Asset Front Left Both Arms Down Checkers Big Green";
        items[26] = "1-Asset Front Left Both Arms Down Checkers Big Red Cold";
        items[27] = "1-Asset Front Left Both Arms Down Checkers Black";
        items[28] = "1-Asset Front Left Both Arms Down Checkers Blue";
        items[29] = "1-Asset Front Left Both Arms Down Checkers Magenta";
        items[30] = "1-Asset Front Left Both Arms Down Checkers Vibrant";
        items[31] = "1-Asset Front Left Both Arms Down Collar Sunset";
        items[32] = "1-Asset Front Left Both Arms Down Decay Gray Dark";
        items[33] = "1-Asset Front Left Both Arms Down Decay Pride";
        items[34] = "1-Asset Front Left Both Arms Down Gradient Dawn";
        items[35] = "1-Asset Front Left Both Arms Down Gradient Dusk";
        items[36] = "1-Asset Front Left Both Arms Down Gradient Glacier";
        items[37] = "1-Asset Front Left Both Arms Down Gradient Ice";
        items[38] = "1-Asset Front Left Both Arms Down Gradient Pride";
        items[39] = "1-Asset Front Left Both Arms Down Gradient Redpink";
        items[40] = "1-Asset Front Left Both Arms Down Gradient Sunset";
        items[41] = "1-Asset Front Left Both Arms Down Gray Scale 1";
        items[42] = "1-Asset Front Left Both Arms Down Gray Scale 9";
        items[43] = "1-Asset Front Left Both Arms Down Grid Simple Bege";
        items[44] = "1-Asset Front Left Both Arms Down Ice Cold";
        items[45] = "1-Asset Front Left Both Arms Down Lines 45 Greens";
        items[46] = "1-Asset Front Left Both Arms Down Lines 45 Rose";
        items[47] = "1-Asset Front Left Both Arms Down Old Shirt";
        items[48] = "1-Asset Front Left Both Arms Down Rainbow Steps";
        items[49] = "1-Asset Front Left Both Arms Down Robot";
        items[50] = "1-Asset Front Left Both Arms Down Safety Vest";
        items[51] = "1-Asset Front Left Both Arms Down Scarf Clown";
        items[52] = "1-Asset Front Left Both Arms Down Shirt Black";
        items[53] = "1-Asset Front Left Both Arms Down Stripes And Checks";
        items[54] = "1-Asset Front Left Both Arms Down Stripes Big Red";
        items[55] = "1-Asset Front Left Both Arms Down Stripes Blit";
        items[56] = "1-Asset Front Left Both Arms Down Stripes Blue Med";
        items[57] = "1-Asset Front Left Both Arms Down Stripes Brown";
        items[58] = "1-Asset Front Left Both Arms Down Stripes Olive";
        items[59] = "1-Asset Front Left Both Arms Down Stripes Red Cold";
        items[60] = "1-Asset Front Left Both Arms Down Taxi Checkers";
        items[61] = "1-Asset Front Left Both Arms Down Tee Yo";
        items[62] = "1-Asset Front Left Both Arms Down Txt Ico";
        items[63] = "1-Asset Front Left Both Arms Down Wall";
        items[64] = "1-Asset Front Left Both Arms Down Woolweave Bicolor";
        items[65] = "1-Asset Front Left Both Arms Down Woolweave Dirt";
        items[66] = "1-Asset Front Left Carrot";
        items[67] = "1-Asset Front Left Chain Logo";
        items[68] = "1-Asset Front Left Chicken";
        items[69] = "1-Asset Front Left Cloud";
        items[70] = "1-Asset Front Left Clover";
        items[71] = "1-Asset Front Left Cow";
        items[72] = "1-Asset Front Left Dinosaur";
        items[73] = "1-Asset Front Left Dollar Bling";
        items[74] = "1-Asset Front Left Dragon";
        items[75] = "1-Asset Front Left Ducky";
        items[76] = "1-Asset Front Left Eth";
        items[77] = "1-Asset Front Left Eye";
        items[78] = "1-Asset Front Left Flash";
        items[79] = "1-Asset Front Left Fries";
        items[80] = "1-Asset Front Left Glasses";
        items[81] = "1-Asset Front Left Glasses Logo";
        items[82] = "1-Asset Front Left Glasses Logo Sun";
        items[83] = "1-Asset Front Left Heart";
        items[84] = "1-Asset Front Left Hoodiestrings Uneven";
        items[85] = "1-Asset Front Left Id";
        items[86] = "1-Asset Front Left Infinity";
        items[87] = "1-Asset Front Left Insignia";
        items[88] = "1-Asset Front Left Leaf";
        items[89] = "1-Asset Front Left Light Bulb";
        items[90] = "1-Asset Front Left Lp";
        items[91] = "1-Asset Front Left Mars Face";
        items[92] = "1-Asset Front Left Matrix White";
        items[93] = "1-Asset Front Left Moon Block";
        items[94] = "1-Asset Front Left None";
        items[95] = "1-Asset Front Left Pizza Bling";
        items[96] = "1-Asset Front Left Pocket Pencil";
        items[97] = "1-Asset Front Left Rain";
        items[98] = "1-Asset Front Left Rgb";
        items[99] = "1-Asset Front Left Secret X";
        items[100] = "1-Asset Front Left Shrimp";
        items[101] = "1-Asset Front Left Slime Splat";
        items[102] = "1-Asset Front Left Small Bling";
        items[103] = "1-Asset Front Left Snowflake";
        items[104] = "1-Asset Front Left Sparkles";
        items[105] = "1-Asset Front Left Stains Blood";
        items[106] = "1-Asset Front Left Stains Zombie";
        items[107] = "1-Asset Front Left Sunset";
        items[108] = "1-Asset Front Left Think";
        items[109] = "1-Asset Front Left Tie Black On White";
        items[110] = "1-Asset Front Left Tie Dye";
        items[111] = "1-Asset Front Left Tie Purple On White";
        items[112] = "1-Asset Front Left Tie Red";
        items[113] = "1-Asset Front Left Txt A2+b2";
        items[114] = "1-Asset Front Left Txt Cc";
        items[115] = "1-Asset Front Left Txt Cc2";
        items[116] = "1-Asset Front Left Txt Copy";
        items[117] = "1-Asset Front Left Txt Dao Black";
        items[118] = "1-Asset Front Left Txt Doom";
        items[119] = "1-Asset Front Left Txt Dope";
        items[120] = "1-Asset Front Left Txt Foo Black";
        items[121] = "1-Asset Front Left Txt Green";
        items[122] = "1-Asset Front Left Txt Io";
        items[123] = "1-Asset Front Left Txt Lmao";
        items[124] = "1-Asset Front Left Txt Lol";
        items[125] = "1-Asset Front Left Txt Mint";
        items[126] = "1-Asset Front Left Txt Nil Grey Dark";
        items[127] = "1-Asset Front Left Txt Noun";
        items[128] = "1-Asset Front Left Txt Noun F0f";
        items[129] = "1-Asset Front Left Txt Noun Multicolor";
        items[130] = "1-Asset Front Left Txt Pi";
        items[131] = "1-Asset Front Left Txt Pop";
        items[132] = "1-Asset Front Left Txt Rofl";
        items[133] = "1-Asset Front Left Txt We";
        items[134] = "1-Asset Front Left Txt Yay";
        items[135] = "1-Asset Front Left Txt Yolo";
        items[136] = "1-Asset Front Left Wave";
        items[137] = "1-Asset Front Left Wet Money";
        items[138] = "1-Asset Front Left Ying Yang";
        items[139] = "2-Asset Front Left 1n";
        items[140] = "2-Asset Front Left Aardvark";
        items[141] = "2-Asset Front Left Axe";
        items[142] = "2-Asset Front Left Belly Chamaleon";
        items[143] = "2-Asset Front Left Bird Flying";
        items[144] = "2-Asset Front Left Bird Side";
        items[145] = "2-Asset Front Left Bling Anchor";
        items[146] = "2-Asset Front Left Bling Anvil";
        items[147] = "2-Asset Front Left Bling Arrow";
        items[148] = "2-Asset Front Left Bling Cheese";
        items[149] = "2-Asset Front Left Bling Gold Ingot";
        items[150] = "2-Asset Front Left Bling Love";
        items[151] = "2-Asset Front Left Bling Mask";
        items[152] = "2-Asset Front Left Bling Rings";
        items[153] = "2-Asset Front Left Bling Scissors";
        items[154] = "2-Asset Front Left Both Arms Up Bege Bsod";
        items[155] = "2-Asset Front Left Both Arms Up Bigwalk Blue Prime";
        items[156] = "2-Asset Front Left Both Arms Up Bigwalk Greylight";
        items[157] = "2-Asset Front Left Both Arms Up Bigwalk Rainbow";
        items[158] = "2-Asset Front Left Both Arms Up Checker Disco";
        items[159] = "2-Asset Front Left Both Arms Up Checker Rgb";
        items[160] = "2-Asset Front Left Both Arms Up Checker Spaced Black";
        items[161] = "2-Asset Front Left Both Arms Up Checker Spaced White";
        items[162] = "2-Asset Front Left Both Arms Up Checkers Big Green";
        items[163] = "2-Asset Front Left Both Arms Up Checkers Big Red Cold";
        items[164] = "2-Asset Front Left Both Arms Up Checkers Black";
        items[165] = "2-Asset Front Left Both Arms Up Checkers Blue";
        items[166] = "2-Asset Front Left Both Arms Up Checkers Magenta";
        items[167] = "2-Asset Front Left Both Arms Up Checkers Vibrant";
        items[168] = "2-Asset Front Left Both Arms Up Collar Sunset";
        items[169] = "2-Asset Front Left Both Arms Up Decay Gray Dark";
        items[170] = "2-Asset Front Left Both Arms Up Decay Pride";
        items[171] = "2-Asset Front Left Both Arms Up Gradient Dawn";
        items[172] = "2-Asset Front Left Both Arms Up Gradient Dusk";
        items[173] = "2-Asset Front Left Both Arms Up Gradient Glacier";
        items[174] = "2-Asset Front Left Both Arms Up Gradient Ice";
        items[175] = "2-Asset Front Left Both Arms Up Gradient Pride";
        items[176] = "2-Asset Front Left Both Arms Up Gradient Redpink";
        items[177] = "2-Asset Front Left Both Arms Up Gradient Sunset";
        items[178] = "2-Asset Front Left Both Arms Up Gray Scale 1";
        items[179] = "2-Asset Front Left Both Arms Up Gray Scale 9";
        items[180] = "2-Asset Front Left Both Arms Up Grid Simple Bege";
        items[181] = "2-Asset Front Left Both Arms Up Ice Cold";
        items[182] = "2-Asset Front Left Both Arms Up Lines 45 Greens";
        items[183] = "2-Asset Front Left Both Arms Up Lines 45 Rose";
        items[184] = "2-Asset Front Left Both Arms Up Old Shirt";
        items[185] = "2-Asset Front Left Both Arms Up Rainbow Steps";
        items[186] = "2-Asset Front Left Both Arms Up Robot";
        items[187] = "2-Asset Front Left Both Arms Up Safety Vest";
        items[188] = "2-Asset Front Left Both Arms Up Scarf Clown";
        items[189] = "2-Asset Front Left Both Arms Up Shirt Black";
        items[190] = "2-Asset Front Left Both Arms Up Stripes And Checks";
        items[191] = "2-Asset Front Left Both Arms Up Stripes Big Red";
        items[192] = "2-Asset Front Left Both Arms Up Stripes Blit";
        items[193] = "2-Asset Front Left Both Arms Up Stripes Blue Med";
        items[194] = "2-Asset Front Left Both Arms Up Stripes Brown";
        items[195] = "2-Asset Front Left Both Arms Up Stripes Olive";
        items[196] = "2-Asset Front Left Both Arms Up Stripes Red Cold";
        items[197] = "2-Asset Front Left Both Arms Up Taxi Checkers";
        items[198] = "2-Asset Front Left Both Arms Up Tee Yo";
        items[199] = "2-Asset Front Left Both Arms Up Txt Ico";
        items[200] = "2-Asset Front Left Both Arms Up Wall";
        items[201] = "2-Asset Front Left Both Arms Up Woolweave Bicolor";
        items[202] = "2-Asset Front Left Both Arms Up Woolweave Dirt";
        items[203] = "2-Asset Front Left Carrot";
        items[204] = "2-Asset Front Left Chain Logo";
        items[205] = "2-Asset Front Left Chicken";
        items[206] = "2-Asset Front Left Cloud";
        items[207] = "2-Asset Front Left Clover";
        items[208] = "2-Asset Front Left Cow";
        items[209] = "2-Asset Front Left Dinosaur";
        items[210] = "2-Asset Front Left Dollar Bling";
        items[211] = "2-Asset Front Left Dragon";
        items[212] = "2-Asset Front Left Ducky";
        items[213] = "2-Asset Front Left Eth";
        items[214] = "2-Asset Front Left Eye";
        items[215] = "2-Asset Front Left Flash";
        items[216] = "2-Asset Front Left Fries";
        items[217] = "2-Asset Front Left Glasses";
        items[218] = "2-Asset Front Left Glasses Logo";
        items[219] = "2-Asset Front Left Glasses Logo Sun";
        items[220] = "2-Asset Front Left Heart";
        items[221] = "2-Asset Front Left Hoodiestrings Uneven";
        items[222] = "2-Asset Front Left Id";
        items[223] = "2-Asset Front Left Infinity";
        items[224] = "2-Asset Front Left Insignia";
        items[225] = "2-Asset Front Left Leaf";
        items[226] = "2-Asset Front Left Light Bulb";
        items[227] = "2-Asset Front Left Lp";
        items[228] = "2-Asset Front Left Mars Face";
        items[229] = "2-Asset Front Left Matrix White";
        items[230] = "2-Asset Front Left Moon Block";
        items[231] = "2-Asset Front Left None";
        items[232] = "2-Asset Front Left Pizza Bling";
        items[233] = "2-Asset Front Left Pocket Pencil";
        items[234] = "2-Asset Front Left Rain";
        items[235] = "2-Asset Front Left Rgb";
        items[236] = "2-Asset Front Left Secret X";
        items[237] = "2-Asset Front Left Shrimp";
        items[238] = "2-Asset Front Left Slime Splat";
        items[239] = "2-Asset Front Left Small Bling";
        items[240] = "2-Asset Front Left Snowflake";
        items[241] = "2-Asset Front Left Sparkles";
        items[242] = "2-Asset Front Left Stains Blood";
        items[243] = "2-Asset Front Left Stains Zombie";
        items[244] = "2-Asset Front Left Sunset";
        items[245] = "2-Asset Front Left Think";
        items[246] = "2-Asset Front Left Tie Black On White";
        items[247] = "2-Asset Front Left Tie Dye";
        items[248] = "2-Asset Front Left Tie Purple On White";
        items[249] = "2-Asset Front Left Tie Red";
        items[250] = "2-Asset Front Left Txt A2+b2";
        items[251] = "2-Asset Front Left Txt Cc";
        items[252] = "2-Asset Front Left Txt Cc2";
        items[253] = "2-Asset Front Left Txt Copy";
        items[254] = "2-Asset Front Left Txt Dao Black";
        items[255] = "2-Asset Front Left Txt Doom";
        items[256] = "2-Asset Front Left Txt Dope";
        items[257] = "2-Asset Front Left Txt Foo Black";
        items[258] = "2-Asset Front Left Txt Green";
        items[259] = "2-Asset Front Left Txt Io";
        items[260] = "2-Asset Front Left Txt Lmao";
        items[261] = "2-Asset Front Left Txt Lol";
        items[262] = "2-Asset Front Left Txt Mint";
        items[263] = "2-Asset Front Left Txt Nil Grey Dark";
        items[264] = "2-Asset Front Left Txt Noun";
        items[265] = "2-Asset Front Left Txt Noun F0f";
        items[266] = "2-Asset Front Left Txt Noun Multicolor";
        items[267] = "2-Asset Front Left Txt Pi";
        items[268] = "2-Asset Front Left Txt Pop";
        items[269] = "2-Asset Front Left Txt Rofl";
        items[270] = "2-Asset Front Left Txt We";
        items[271] = "2-Asset Front Left Txt Yay";
        items[272] = "2-Asset Front Left Txt Yolo";
        items[273] = "2-Asset Front Left Wave";
        items[274] = "2-Asset Front Left Wet Money";
        items[275] = "2-Asset Front Left Ying Yang";
        items[276] = "3-Asset Front Left 1n";
        items[277] = "3-Asset Front Left Aardvark";
        items[278] = "3-Asset Front Left Axe";
        items[279] = "3-Asset Front Left Belly Chamaleon";
        items[280] = "3-Asset Front Left Bird Flying";
        items[281] = "3-Asset Front Left Bird Side";
        items[282] = "3-Asset Front Left Bling Anchor";
        items[283] = "3-Asset Front Left Bling Anvil";
        items[284] = "3-Asset Front Left Bling Arrow";
        items[285] = "3-Asset Front Left Bling Cheese";
        items[286] = "3-Asset Front Left Bling Gold Ingot";
        items[287] = "3-Asset Front Left Bling Love";
        items[288] = "3-Asset Front Left Bling Mask";
        items[289] = "3-Asset Front Left Bling Rings";
        items[290] = "3-Asset Front Left Bling Scissors";
        items[291] = "3-Asset Front Left Carrot";
        items[292] = "3-Asset Front Left Chain Logo";
        items[293] = "3-Asset Front Left Chicken";
        items[294] = "3-Asset Front Left Cloud";
        items[295] = "3-Asset Front Left Clover";
        items[296] = "3-Asset Front Left Cow";
        items[297] = "3-Asset Front Left Dinosaur";
        items[298] = "3-Asset Front Left Dollar Bling";
        items[299] = "3-Asset Front Left Dragon";
        items[300] = "3-Asset Front Left Ducky";
        items[301] = "3-Asset Front Left Eth";
        items[302] = "3-Asset Front Left Eye";
        items[303] = "3-Asset Front Left Flash";
        items[304] = "3-Asset Front Left Fries";
        items[305] = "3-Asset Front Left Glasses";
        items[306] = "3-Asset Front Left Glasses Logo";
        items[307] = "3-Asset Front Left Glasses Logo Sun";
        items[308] = "3-Asset Front Left Heart";
        items[309] = "3-Asset Front Left Hoodiestrings Uneven";
        items[310] = "3-Asset Front Left Id";
        items[311] = "3-Asset Front Left Infinity";
        items[312] = "3-Asset Front Left Insignia";
        items[313] = "3-Asset Front Left Leaf";
        items[314] = "3-Asset Front Left Left Arm Up Bege Bsod";
        items[315] = "3-Asset Front Left Left Arm Up Bigwalk Blue Prime";
        items[316] = "3-Asset Front Left Left Arm Up Bigwalk Greylight";
        items[317] = "3-Asset Front Left Left Arm Up Bigwalk Rainbow";
        items[318] = "3-Asset Front Left Left Arm Up Checker Disco";
        items[319] = "3-Asset Front Left Left Arm Up Checker Rgb";
        items[320] = "3-Asset Front Left Left Arm Up Checker Spaced Black";
        items[321] = "3-Asset Front Left Left Arm Up Checker Spaced White";
        items[322] = "3-Asset Front Left Left Arm Up Checker Vibrant";
        items[323] = "3-Asset Front Left Left Arm Up Checkers Big Green";
        items[324] = "3-Asset Front Left Left Arm Up Checkers Big Red Cold";
        items[325] = "3-Asset Front Left Left Arm Up Checkers Black";
        items[326] = "3-Asset Front Left Left Arm Up Checkers Blue";
        items[327] = "3-Asset Front Left Left Arm Up Checkers Magenta";
        items[328] = "3-Asset Front Left Left Arm Up Collar Sunset";
        items[329] = "3-Asset Front Left Left Arm Up Decay Gray Dark";
        items[330] = "3-Asset Front Left Left Arm Up Decay Pride";
        items[331] = "3-Asset Front Left Left Arm Up Gradient Dawn";
        items[332] = "3-Asset Front Left Left Arm Up Gradient Dusk";
        items[333] = "3-Asset Front Left Left Arm Up Gradient Glacier";
        items[334] = "3-Asset Front Left Left Arm Up Gradient Ice";
        items[335] = "3-Asset Front Left Left Arm Up Gradient Pride";
        items[336] = "3-Asset Front Left Left Arm Up Gradient Redpink";
        items[337] = "3-Asset Front Left Left Arm Up Gradient Sunset";
        items[338] = "3-Asset Front Left Left Arm Up Gray Scale 1";
        items[339] = "3-Asset Front Left Left Arm Up Gray Scale 9";
        items[340] = "3-Asset Front Left Left Arm Up Grid Simple Bege";
        items[341] = "3-Asset Front Left Left Arm Up Ice Cold";
        items[342] = "3-Asset Front Left Left Arm Up Lines 45 Greens";
        items[343] = "3-Asset Front Left Left Arm Up Lines 45 Rose";
        items[344] = "3-Asset Front Left Left Arm Up Old Shirt";
        items[345] = "3-Asset Front Left Left Arm Up Rainbow Steps";
        items[346] = "3-Asset Front Left Left Arm Up Robot";
        items[347] = "3-Asset Front Left Left Arm Up Safety Vest";
        items[348] = "3-Asset Front Left Left Arm Up Scarf Clown";
        items[349] = "3-Asset Front Left Left Arm Up Shirt Black";
        items[350] = "3-Asset Front Left Left Arm Up Stripes And Checks";
        items[351] = "3-Asset Front Left Left Arm Up Stripes Big Red";
        items[352] = "3-Asset Front Left Left Arm Up Stripes Blit";
        items[353] = "3-Asset Front Left Left Arm Up Stripes Blue Med";
        items[354] = "3-Asset Front Left Left Arm Up Stripes Brown";
        items[355] = "3-Asset Front Left Left Arm Up Stripes Olive";
        items[356] = "3-Asset Front Left Left Arm Up Stripes Red Cold";
        items[357] = "3-Asset Front Left Left Arm Up Taxi Checkers";
        items[358] = "3-Asset Front Left Left Arm Up Tee Yo";
        items[359] = "3-Asset Front Left Left Arm Up Txt Ico";
        items[360] = "3-Asset Front Left Left Arm Up Wall";
        items[361] = "3-Asset Front Left Left Arm Up Woolweave Bicolor";
        items[362] = "3-Asset Front Left Left Arm Up Woolweave Dirt";
        items[363] = "3-Asset Front Left Light Bulb";
        items[364] = "3-Asset Front Left Lp";
        items[365] = "3-Asset Front Left Mars Face";
        items[366] = "3-Asset Front Left Matrix White";
        items[367] = "3-Asset Front Left Moon Block";
        items[368] = "3-Asset Front Left None";
        items[369] = "3-Asset Front Left Pizza Bling";
        items[370] = "3-Asset Front Left Pocket Pencil";
        items[371] = "3-Asset Front Left Rain";
        items[372] = "3-Asset Front Left Rgb";
        items[373] = "3-Asset Front Left Secret X";
        items[374] = "3-Asset Front Left Shrimp";
        items[375] = "3-Asset Front Left Slime Splat";
        items[376] = "3-Asset Front Left Small Bling";
        items[377] = "3-Asset Front Left Snowflake";
        items[378] = "3-Asset Front Left Sparkles";
        items[379] = "3-Asset Front Left Stains Blood";
        items[380] = "3-Asset Front Left Stains Zombie";
        items[381] = "3-Asset Front Left Sunset";
        items[382] = "3-Asset Front Left Think";
        items[383] = "3-Asset Front Left Tie Black On White";
        items[384] = "3-Asset Front Left Tie Dye";
        items[385] = "3-Asset Front Left Tie Purple On White";
        items[386] = "3-Asset Front Left Tie Red";
        items[387] = "3-Asset Front Left Txt A2+b2";
        items[388] = "3-Asset Front Left Txt Cc";
        items[389] = "3-Asset Front Left Txt Cc2";
        items[390] = "3-Asset Front Left Txt Copy";
        items[391] = "3-Asset Front Left Txt Dao Black";
        items[392] = "3-Asset Front Left Txt Doom";
        items[393] = "3-Asset Front Left Txt Dope";
        items[394] = "3-Asset Front Left Txt Foo Black";
        items[395] = "3-Asset Front Left Txt Green";
        items[396] = "3-Asset Front Left Txt Io";
        items[397] = "3-Asset Front Left Txt Lmao";
        items[398] = "3-Asset Front Left Txt Lol";
        items[399] = "3-Asset Front Left Txt Mint";
        items[400] = "3-Asset Front Left Txt Nil Grey Dark";
        items[401] = "3-Asset Front Left Txt Noun";
        items[402] = "3-Asset Front Left Txt Noun F0f";
        items[403] = "3-Asset Front Left Txt Noun Multicolor";
        items[404] = "3-Asset Front Left Txt Pi";
        items[405] = "3-Asset Front Left Txt Pop";
        items[406] = "3-Asset Front Left Txt Rofl";
        items[407] = "3-Asset Front Left Txt We";
        items[408] = "3-Asset Front Left Txt Yay";
        items[409] = "3-Asset Front Left Txt Yolo";
        items[410] = "3-Asset Front Left Wave";
        items[411] = "3-Asset Front Left Wet Money";
        items[412] = "3-Asset Front Left Ying Yang";
        items[413] = "4-Asset Front Left 1n";
        items[414] = "4-Asset Front Left Aardvark";
        items[415] = "4-Asset Front Left Axe";
        items[416] = "4-Asset Front Left Belly Chamaleon";
        items[417] = "4-Asset Front Left Bird Flying";
        items[418] = "4-Asset Front Left Bird Side";
        items[419] = "4-Asset Front Left Bling Anchor";
        items[420] = "4-Asset Front Left Bling Anvil";
        items[421] = "4-Asset Front Left Bling Arrow";
        items[422] = "4-Asset Front Left Bling Cheese";
        items[423] = "4-Asset Front Left Bling Gold Ingot";
        items[424] = "4-Asset Front Left Bling Love";
        items[425] = "4-Asset Front Left Bling Mask";
        items[426] = "4-Asset Front Left Bling Rings";
        items[427] = "4-Asset Front Left Bling Scissors";
        items[428] = "4-Asset Front Left Carrot";
        items[429] = "4-Asset Front Left Chain Logo";
        items[430] = "4-Asset Front Left Chicken";
        items[431] = "4-Asset Front Left Cloud";
        items[432] = "4-Asset Front Left Clover";
        items[433] = "4-Asset Front Left Cow";
        items[434] = "4-Asset Front Left Dinosaur";
        items[435] = "4-Asset Front Left Dollar Bling";
        items[436] = "4-Asset Front Left Dragon";
        items[437] = "4-Asset Front Left Ducky";
        items[438] = "4-Asset Front Left Eth";
        items[439] = "4-Asset Front Left Eye";
        items[440] = "4-Asset Front Left Flash";
        items[441] = "4-Asset Front Left Fries";
        items[442] = "4-Asset Front Left Glasses";
        items[443] = "4-Asset Front Left Glasses Logo";
        items[444] = "4-Asset Front Left Glasses Logo Sun";
        items[445] = "4-Asset Front Left Heart";
        items[446] = "4-Asset Front Left Hoodiestrings Uneven";
        items[447] = "4-Asset Front Left Id";
        items[448] = "4-Asset Front Left Infinity";
        items[449] = "4-Asset Front Left Insignia";
        items[450] = "4-Asset Front Left Leaf";
        items[451] = "4-Asset Front Left Light Bulb";
        items[452] = "4-Asset Front Left Lp";
        items[453] = "4-Asset Front Left Mars Face";
        items[454] = "4-Asset Front Left Matrix White";
        items[455] = "4-Asset Front Left Moon Block";
        items[456] = "4-Asset Front Left None";
        items[457] = "4-Asset Front Left Pizza Bling";
        items[458] = "4-Asset Front Left Pocket Pencil";
        items[459] = "4-Asset Front Left Rain";
        items[460] = "4-Asset Front Left Rgb";
        items[461] = "4-Asset Front Left Right Arm Up Bege Bsod";
        items[462] = "4-Asset Front Left Right Arm Up Big Walk Greylight";
        items[463] = "4-Asset Front Left Right Arm Up Bigwalk Blue Prime";
        items[464] = "4-Asset Front Left Right Arm Up Bigwalk Rainbow";
        items[465] = "4-Asset Front Left Right Arm Up Checker Disco";
        items[466] = "4-Asset Front Left Right Arm Up Checker Rgb";
        items[467] = "4-Asset Front Left Right Arm Up Checkers Big Green";
        items[468] = "4-Asset Front Left Right Arm Up Checkers Big Red Cold";
        items[469] = "4-Asset Front Left Right Arm Up Checkers Black";
        items[470] = "4-Asset Front Left Right Arm Up Checkers Blue";
        items[471] = "4-Asset Front Left Right Arm Up Checkers Magenta";
        items[472] = "4-Asset Front Left Right Arm Up Checkers Spaced Black";
        items[473] = "4-Asset Front Left Right Arm Up Checkers Spaced White";
        items[474] = "4-Asset Front Left Right Arm Up Checkers Vibrant";
        items[475] = "4-Asset Front Left Right Arm Up Collar Sunset";
        items[476] = "4-Asset Front Left Right Arm Up Decay Gray Dark";
        items[477] = "4-Asset Front Left Right Arm Up Decay Pride";
        items[478] = "4-Asset Front Left Right Arm Up Gradient Dawn";
        items[479] = "4-Asset Front Left Right Arm Up Gradient Dusk";
        items[480] = "4-Asset Front Left Right Arm Up Gradient Glacier";
        items[481] = "4-Asset Front Left Right Arm Up Gradient Ice";
        items[482] = "4-Asset Front Left Right Arm Up Gradient Pride";
        items[483] = "4-Asset Front Left Right Arm Up Gradient Redpink";
        items[484] = "4-Asset Front Left Right Arm Up Gradient Sunset";
        items[485] = "4-Asset Front Left Right Arm Up Gray Scale 1";
        items[486] = "4-Asset Front Left Right Arm Up Gray Scale 9";
        items[487] = "4-Asset Front Left Right Arm Up Grid Simple Bege";
        items[488] = "4-Asset Front Left Right Arm Up Ice Cold";
        items[489] = "4-Asset Front Left Right Arm Up Lines 45 Greens";
        items[490] = "4-Asset Front Left Right Arm Up Lines 45 Rose";
        items[491] = "4-Asset Front Left Right Arm Up Old Shirt";
        items[492] = "4-Asset Front Left Right Arm Up Olive";
        items[493] = "4-Asset Front Left Right Arm Up Rainbow Steps";
        items[494] = "4-Asset Front Left Right Arm Up Robot";
        items[495] = "4-Asset Front Left Right Arm Up Safety Vest";
        items[496] = "4-Asset Front Left Right Arm Up Scarf Clown";
        items[497] = "4-Asset Front Left Right Arm Up Shirt Black";
        items[498] = "4-Asset Front Left Right Arm Up Stripes And Checks";
        items[499] = "4-Asset Front Left Right Arm Up Stripes Big Red";
        items[500] = "4-Asset Front Left Right Arm Up Stripes Blit";
        items[501] = "4-Asset Front Left Right Arm Up Stripes Blue Med";
        items[502] = "4-Asset Front Left Right Arm Up Stripes Brown";
        items[503] = "4-Asset Front Left Right Arm Up Stripes Red Cold";
        items[504] = "4-Asset Front Left Right Arm Up Taxi Checkers";
        items[505] = "4-Asset Front Left Right Arm Up Tee Yo";
        items[506] = "4-Asset Front Left Right Arm Up Txt Ico";
        items[507] = "4-Asset Front Left Right Arm Up Wall";
        items[508] = "4-Asset Front Left Right Arm Up Woolweave Bicolor";
        items[509] = "4-Asset Front Left Right Arm Up Woolweave Dirt";
        items[510] = "4-Asset Front Left Secret X";
        items[511] = "4-Asset Front Left Shrimp";
        items[512] = "4-Asset Front Left Slime Splat";
        items[513] = "4-Asset Front Left Small Bling";
        items[514] = "4-Asset Front Left Snowflake";
        items[515] = "4-Asset Front Left Sparkles";
        items[516] = "4-Asset Front Left Stains Blood";
        items[517] = "4-Asset Front Left Stains Zombie";
        items[518] = "4-Asset Front Left Sunset";
        items[519] = "4-Asset Front Left Think";
        items[520] = "4-Asset Front Left Tie Black On White";
        items[521] = "4-Asset Front Left Tie Dye";
        items[522] = "4-Asset Front Left Tie Purple On White";
        items[523] = "4-Asset Front Left Tie Red";
        items[524] = "4-Asset Front Left Txt A2+b2";
        items[525] = "4-Asset Front Left Txt Cc";
        items[526] = "4-Asset Front Left Txt Cc2";
        items[527] = "4-Asset Front Left Txt Copy";
        items[528] = "4-Asset Front Left Txt Dao Black";
        items[529] = "4-Asset Front Left Txt Doom";
        items[530] = "4-Asset Front Left Txt Dope";
        items[531] = "4-Asset Front Left Txt Foo Black";
        items[532] = "4-Asset Front Left Txt Green";
        items[533] = "4-Asset Front Left Txt Io";
        items[534] = "4-Asset Front Left Txt Lmao";
        items[535] = "4-Asset Front Left Txt Lol";
        items[536] = "4-Asset Front Left Txt Mint";
        items[537] = "4-Asset Front Left Txt Nil Grey Dark";
        items[538] = "4-Asset Front Left Txt Noun";
        items[539] = "4-Asset Front Left Txt Noun F0f";
        items[540] = "4-Asset Front Left Txt Noun Multicolor";
        items[541] = "4-Asset Front Left Txt Pi";
        items[542] = "4-Asset Front Left Txt Pop";
        items[543] = "4-Asset Front Left Txt Rofl";
        items[544] = "4-Asset Front Left Txt We";
        items[545] = "4-Asset Front Left Txt Yay";
        items[546] = "4-Asset Front Left Txt Yolo";
        items[547] = "4-Asset Front Left Wave";
        items[548] = "4-Asset Front Left Wet Money";
        items[549] = "4-Asset Front Left Ying Yang";

        bytes memory data = abi.encode(items);

        VmSafe vm = VmSafe(
            address(uint160(uint256(keccak256("hevm cheat code"))))
        );

        string[] memory inputs = new string[](3);
        inputs[0] = "node";
        inputs[1] = "script/nouns-coasters/deflate.js";
        inputs[2] = vm.toString(data);

        bytes memory compressedData = vm.ffi(inputs);

        // address result = SSTORE2.write(compressedData);

        renderer.addLayer({
            target: target,
            ipfs: INounsCoasterMetadataRendererTypes.IPFSGroup({
                baseUri: "ipfs://bafybeiag26lh2at7iah5xqlrzgj2ei2jd2qel3g5bpccgfj5ktjbvu4qm4/",
                extension: ".png"
            }),
            decompressedSize: data.length,
            compressedData: compressedData,
            count: items.length,
            property: "16 Accessories front left",
            variantProperty: variantPropertyParameters
        });
    }

    function addLayer17(NounsCoasterMetadataRenderer renderer, address target)
        internal
    {
        // 17 Head front left
        INounsCoasterMetadataRendererTypes.VariantPropertyParameters
            memory variantPropertyParameters;
        variantPropertyParameters
            .offsets = new INounsCoasterMetadataRendererTypes.VariantOffset[](
            0
        );
        variantPropertyParameters.id = 0;
        variantPropertyParameters.count = 0;

        string[] memory items = new string[](940);
        items[0] = "Aardvark Bored";
        items[1] = "Aardvark Happy";
        items[2] = "Aardvark Scared";
        items[3] = "Aardvark Sick";
        items[4] = "Abstract Bored";
        items[5] = "Abstract Happy";
        items[6] = "Abstract Scared";
        items[7] = "Abstract Sick";
        items[8] = "Ape Bored";
        items[9] = "Ape Happy";
        items[10] = "Ape Scared";
        items[11] = "Ape Sick";
        items[12] = "Bag Bored";
        items[13] = "Bag Happy";
        items[14] = "Bag Scared";
        items[15] = "Bag Sick";
        items[16] = "Bagpipe Bored";
        items[17] = "Bagpipe Happy";
        items[18] = "Bagpipe Scared";
        items[19] = "Bagpipe Sick";
        items[20] = "Banana Bored";
        items[21] = "Banana Happy";
        items[22] = "Banana Scared";
        items[23] = "Banana Sick";
        items[24] = "Bank Bored";
        items[25] = "Bank Happy";
        items[26] = "Bank Scared";
        items[27] = "Bank Sick";
        items[28] = "Baseball Gameball Bored";
        items[29] = "Baseball Gameball Happy";
        items[30] = "Baseball Gameball Scared";
        items[31] = "Baseball Gameball Sick";
        items[32] = "Bat Bored";
        items[33] = "Bat Happy";
        items[34] = "Bat Scared";
        items[35] = "Bat Sick";
        items[36] = "Bear Bored";
        items[37] = "Bear Happy";
        items[38] = "Bear Scared";
        items[39] = "Bear Sick";
        items[40] = "Beer Bored";
        items[41] = "Beer Happy";
        items[42] = "Beer Scared";
        items[43] = "Beer Sick";
        items[44] = "Beet Bored";
        items[45] = "Beet Happy";
        items[46] = "Beet Scared";
        items[47] = "Beet Sick";
        items[48] = "Bell Bored";
        items[49] = "Bell Happy";
        items[50] = "Bell Scared";
        items[51] = "Bell Sick";
        items[52] = "Bigfoot Bored";
        items[53] = "Bigfoot Happy";
        items[54] = "Bigfoot Scared";
        items[55] = "Bigfoot Sick";
        items[56] = "Bigfoot Yeti Bored";
        items[57] = "Bigfoot Yeti Happy";
        items[58] = "Bigfoot Yeti Scared";
        items[59] = "Bigfoot Yeti Sick";
        items[60] = "Blackhole Bored";
        items[61] = "Blackhole Happy";
        items[62] = "Blackhole Scared";
        items[63] = "Blackhole Sick";
        items[64] = "Blueberry Bored";
        items[65] = "Blueberry Happy";
        items[66] = "Blueberry Scared";
        items[67] = "Blueberry Sick";
        items[68] = "Bomb Bored";
        items[69] = "Bomb Happy";
        items[70] = "Bomb Scared";
        items[71] = "Bomb Sick";
        items[72] = "Bonsai Bored";
        items[73] = "Bonsai Happy";
        items[74] = "Bonsai Scared";
        items[75] = "Bonsai Sick";
        items[76] = "Boombox Bored";
        items[77] = "Boombox Happy";
        items[78] = "Boombox Scared";
        items[79] = "Boombox Sick";
        items[80] = "Boot Bored";
        items[81] = "Boot Happy";
        items[82] = "Boot Scared";
        items[83] = "Boot Sick";
        items[84] = "Box Bored";
        items[85] = "Box Happy";
        items[86] = "Box Scared";
        items[87] = "Box Sick";
        items[88] = "Boxingglove Bored";
        items[89] = "Boxingglove Happy";
        items[90] = "Boxingglove Scared";
        items[91] = "Boxingglove Sick";
        items[92] = "Brain Bored";
        items[93] = "Brain Happy";
        items[94] = "Brain Scared";
        items[95] = "Brain Sick";
        items[96] = "Bubble Speech Bored";
        items[97] = "Bubble Speech Happy";
        items[98] = "Bubble Speech Scared";
        items[99] = "Bubble Speech Sick";
        items[100] = "Bubblegum Bored";
        items[101] = "Bubblegum Happy";
        items[102] = "Bubblegum Scared";
        items[103] = "Bubblegum Sick";
        items[104] = "Burger Dollarmenu Bored";
        items[105] = "Burger Dollarmenu Happy";
        items[106] = "Burger Dollarmenu Scared";
        items[107] = "Burger Dollarmenu Sick";
        items[108] = "Cake Bored";
        items[109] = "Cake Happy";
        items[110] = "Cake Scared";
        items[111] = "Cake Sick";
        items[112] = "Calculator Bored";
        items[113] = "Calculator Happy";
        items[114] = "Calculator Scared";
        items[115] = "Calculator Sick";
        items[116] = "Calendar Bored";
        items[117] = "Calendar Happy";
        items[118] = "Calendar Scared";
        items[119] = "Calendar Sick";
        items[120] = "Camcorder Bored";
        items[121] = "Camcorder Happy";
        items[122] = "Camcorder Scared";
        items[123] = "Camcorder Sick";
        items[124] = "Candy Bar Bored";
        items[125] = "Candy Bar Happy";
        items[126] = "Candy Bar Scared";
        items[127] = "Candy Bar Sick";
        items[128] = "Cannedham Bored";
        items[129] = "Cannedham Happy";
        items[130] = "Cannedham Scared";
        items[131] = "Cannedham Sick";
        items[132] = "Car Bored";
        items[133] = "Car Happy";
        items[134] = "Car Scared";
        items[135] = "Car Sick";
        items[136] = "Cash Register Bored";
        items[137] = "Cash Register Happy";
        items[138] = "Cash Register Scared";
        items[139] = "Cash Register Sick";
        items[140] = "Cassettetape Bored";
        items[141] = "Cassettetape Happy";
        items[142] = "Cassettetape Scared";
        items[143] = "Cassettetape Sick";
        items[144] = "Cat Bored";
        items[145] = "Cat Happy";
        items[146] = "Cat Scared";
        items[147] = "Cat Sick";
        items[148] = "Cd Bored";
        items[149] = "Cd Happy";
        items[150] = "Cd Scared";
        items[151] = "Cd Sick";
        items[152] = "Chain Bored";
        items[153] = "Chain Happy";
        items[154] = "Chain Scared";
        items[155] = "Chain Sick";
        items[156] = "Chainsaw Bored";
        items[157] = "Chainsaw Happy";
        items[158] = "Chainsaw Scared";
        items[159] = "Chainsaw Sick";
        items[160] = "Chameleon Bored";
        items[161] = "Chameleon Happy";
        items[162] = "Chameleon Scared";
        items[163] = "Chameleon Sick";
        items[164] = "Chart Bars Bored";
        items[165] = "Chart Bars Happy";
        items[166] = "Chart Bars Scared";
        items[167] = "Chart Bars Sick";
        items[168] = "Cheese Bored";
        items[169] = "Cheese Happy";
        items[170] = "Cheese Scared";
        items[171] = "Cheese Sick";
        items[172] = "Chefhat Bored";
        items[173] = "Chefhat Happy";
        items[174] = "Chefhat Scared";
        items[175] = "Chefhat Sick";
        items[176] = "Cherry Bored";
        items[177] = "Cherry Happy";
        items[178] = "Cherry Scared";
        items[179] = "Cherry Sick";
        items[180] = "Chicken Bored";
        items[181] = "Chicken Happy";
        items[182] = "Chicken Scared";
        items[183] = "Chicken Sick";
        items[184] = "Chipboard Bored";
        items[185] = "Chipboard Happy";
        items[186] = "Chipboard Scared";
        items[187] = "Chipboard Sick";
        items[188] = "Chips Bored";
        items[189] = "Chips Happy";
        items[190] = "Chips Scared";
        items[191] = "Chips Sick";
        items[192] = "Cloud Bored";
        items[193] = "Cloud Happy";
        items[194] = "Cloud Scared";
        items[195] = "Cloud Sick";
        items[196] = "Clover Bored";
        items[197] = "Clover Happy";
        items[198] = "Clover Scared";
        items[199] = "Clover Sick";
        items[200] = "Clutch Bored";
        items[201] = "Clutch Happy";
        items[202] = "Clutch Scared";
        items[203] = "Clutch Sick";
        items[204] = "Coffeebean Bored";
        items[205] = "Coffeebean Happy";
        items[206] = "Coffeebean Scared";
        items[207] = "Coffeebean Sick";
        items[208] = "Cone Bored";
        items[209] = "Cone Happy";
        items[210] = "Cone Scared";
        items[211] = "Cone Sick";
        items[212] = "Console Handheld Bored";
        items[213] = "Console Handheld Happy";
        items[214] = "Console Handheld Scared";
        items[215] = "Console Handheld Sick";
        items[216] = "Cookie Bored";
        items[217] = "Cookie Happy";
        items[218] = "Cookie Scared";
        items[219] = "Cookie Sick";
        items[220] = "Cordlessphone Bored";
        items[221] = "Cordlessphone Happy";
        items[222] = "Cordlessphone Scared";
        items[223] = "Cordlessphone Sick";
        items[224] = "Cottonball Bored";
        items[225] = "Cottonball Happy";
        items[226] = "Cottonball Scared";
        items[227] = "Cottonball Sick";
        items[228] = "Couch Bored";
        items[229] = "Couch Happy";
        items[230] = "Couch Scared";
        items[231] = "Couch Sick";
        items[232] = "Cow Bored";
        items[233] = "Cow Happy";
        items[234] = "Cow Scared";
        items[235] = "Cow Sick";
        items[236] = "Crab Bored";
        items[237] = "Crab Happy";
        items[238] = "Crab Scared";
        items[239] = "Crab Sick";
        items[240] = "Crane Bored";
        items[241] = "Crane Happy";
        items[242] = "Crane Scared";
        items[243] = "Crane Sick";
        items[244] = "Croc Hat Bored";
        items[245] = "Croc Hat Happy";
        items[246] = "Croc Hat Scared";
        items[247] = "Croc Hat Sick";
        items[248] = "Crown Bored";
        items[249] = "Crown Happy";
        items[250] = "Crown Scared";
        items[251] = "Crown Sick";
        items[252] = "Crt Bsod Bored";
        items[253] = "Crt Bsod Happy";
        items[254] = "Crt Bsod Scared";
        items[255] = "Crt Bsod Sick";
        items[256] = "Crystalball Bored";
        items[257] = "Crystallball Happy";
        items[258] = "Crystallball Scared";
        items[259] = "Crystallball Sick";
        items[260] = "Diamond Blue Bored";
        items[261] = "Diamond Blue Happy";
        items[262] = "Diamond Blue Scared";
        items[263] = "Diamond Blue Sick";
        items[264] = "Diamond Red Bored";
        items[265] = "Diamond Red Happy";
        items[266] = "Diamond Red Scared";
        items[267] = "Diamond Red Sick";
        items[268] = "Dictionary Bored";
        items[269] = "Dictionary Happy";
        items[270] = "Dictionary Scared";
        items[271] = "Dictonary Sick";
        items[272] = "Dino Bored";
        items[273] = "Dino Happy";
        items[274] = "Dino Scared";
        items[275] = "Dino Sick";
        items[276] = "Dna Bored";
        items[277] = "Dna Happy";
        items[278] = "Dna Scared";
        items[279] = "Dna Sick";
        items[280] = "Dog Bored";
        items[281] = "Dog Happy";
        items[282] = "Dog Scared";
        items[283] = "Dog Sick";
        items[284] = "Doughnut Bored";
        items[285] = "Doughnut Happy";
        items[286] = "Doughnut Scared";
        items[287] = "Doughnut Sick";
        items[288] = "Drill Bored";
        items[289] = "Drill Happy";
        items[290] = "Drill Scared";
        items[291] = "Drill Sick";
        items[292] = "Duck Bored";
        items[293] = "Duck Happy";
        items[294] = "Duck Scared";
        items[295] = "Duck Sick";
        items[296] = "Ducky Bored";
        items[297] = "Ducky Happy";
        items[298] = "Ducky Scared";
        items[299] = "Ducky Sick";
        items[300] = "Earth Bored";
        items[301] = "Earth Happy";
        items[302] = "Earth Scared";
        items[303] = "Earth Sick";
        items[304] = "Egg Bored";
        items[305] = "Egg Happy";
        items[306] = "Egg Scared";
        items[307] = "Egg Sick";
        items[308] = "Faberge Bored";
        items[309] = "Faberge Happy";
        items[310] = "Faberge Scared";
        items[311] = "Faberge Sick";
        items[312] = "Factory Dark Bored";
        items[313] = "Factory Dark Happy";
        items[314] = "Factory Dark Scared";
        items[315] = "Factory Dark Sick";
        items[316] = "Fan Bored";
        items[317] = "Fan Happy";
        items[318] = "Fan Scared";
        items[319] = "Fan Sick";
        items[320] = "Fence Bored";
        items[321] = "Fence Happy";
        items[322] = "Fence Scared";
        items[323] = "Fence Sick";
        items[324] = "Film 35mm Bored";
        items[325] = "Film 35mm Happy";
        items[326] = "Film 35mm Scared";
        items[327] = "Film 35mm Sick";
        items[328] = "Film Strip Bored";
        items[329] = "Film Strip Happy";
        items[330] = "Film Strip Scared";
        items[331] = "Film Strip Sick";
        items[332] = "Fir Bored";
        items[333] = "Fir Happy";
        items[334] = "Fir Scared";
        items[335] = "Fir Sick";
        items[336] = "Firehydrant Bored";
        items[337] = "Firehydrant Happy";
        items[338] = "Firehydrant Scared";
        items[339] = "Firehydrant Sick";
        items[340] = "Flamingo Bored";
        items[341] = "Flamingo Happy";
        items[342] = "Flamingo Scared";
        items[343] = "Flamingo Sick";
        items[344] = "Flower Bored";
        items[345] = "Flower Happy";
        items[346] = "Flower Scared";
        items[347] = "Flower Sick";
        items[348] = "Fox Bored";
        items[349] = "Fox Happy";
        items[350] = "Fox Scared";
        items[351] = "Fox Sick";
        items[352] = "Frog Bored";
        items[353] = "Frog Happy";
        items[354] = "Frog Scared";
        items[355] = "Frog Sick";
        items[356] = "Garlic Bored";
        items[357] = "Garlic Happy";
        items[358] = "Garlic Scared";
        items[359] = "Garlic Sick";
        items[360] = "Gavel Bored";
        items[361] = "Gavel Happy";
        items[362] = "Gavel Scared";
        items[363] = "Gavel Sick";
        items[364] = "Ghost B Bored";
        items[365] = "Ghost B Happy";
        items[366] = "Ghost B Scared";
        items[367] = "Ghost B Sick";
        items[368] = "Glasses Big Bored";
        items[369] = "Glasses Big Happy";
        items[370] = "Glasses Big Scared";
        items[371] = "Glasses Big Sick";
        items[372] = "Gnomes Bored";
        items[373] = "Gnomes Happy";
        items[374] = "Gnomes Scared";
        items[375] = "Gnomes Sick";
        items[376] = "Goat Bored";
        items[377] = "Goat Happy";
        items[378] = "Goat Scared";
        items[379] = "Goat Sick";
        items[380] = "Goldcoin Bored";
        items[381] = "Goldcoin Happy";
        items[382] = "Goldcoin Scared";
        items[383] = "Goldcoin Sick";
        items[384] = "Goldfish Bored";
        items[385] = "Goldfish Happy";
        items[386] = "Goldfish Scared";
        items[387] = "Goldfish Sick";
        items[388] = "Grouper Bored";
        items[389] = "Grouper Happy";
        items[390] = "Grouper Scared";
        items[391] = "Grouper Sick";
        items[392] = "Hair Bored";
        items[393] = "Hair Happy";
        items[394] = "Hair Scared";
        items[395] = "Hair Sick";
        items[396] = "Hanger Bored";
        items[397] = "Hanger Happy";
        items[398] = "Hanger Scared";
        items[399] = "Hanger Sick";
        items[400] = "Hardhat Bored";
        items[401] = "Hardhat Happy";
        items[402] = "Hardhat Scared";
        items[403] = "Hardhat Sick";
        items[404] = "Heart Bored";
        items[405] = "Heart Happy";
        items[406] = "Heart Scared";
        items[407] = "Heart Sick";
        items[408] = "Helicopter Bored";
        items[409] = "Helicopter Happy";
        items[410] = "Helicopter Scared";
        items[411] = "Helicopter Sick";
        items[412] = "Highheel Bored";
        items[413] = "Highheel Happy";
        items[414] = "Highheel Scared";
        items[415] = "Highheel Sick";
        items[416] = "Hockeypuck Bored";
        items[417] = "Hockeypuck Happy";
        items[418] = "Hockeypuck Scared";
        items[419] = "Hockeypuck Sick";
        items[420] = "Horse Deepfried Bored";
        items[421] = "Horse Deepfried Happy";
        items[422] = "Horse Deepfried Scared";
        items[423] = "Horse Deepfried Sick";
        items[424] = "Hotdog Bored";
        items[425] = "Hotdog Happy";
        items[426] = "Hotdog Scared";
        items[427] = "Hotdog Sick";
        items[428] = "House Bored";
        items[429] = "House Happy";
        items[430] = "House Scared";
        items[431] = "House Sick";
        items[432] = "Icepop B Bored";
        items[433] = "Icepop B Happy";
        items[434] = "Icepop B Scared";
        items[435] = "Icepop B Sick";
        items[436] = "Igloo Bored";
        items[437] = "Igloo Happy";
        items[438] = "Igloo Scared";
        items[439] = "Igloo Sick";
        items[440] = "Island Bored";
        items[441] = "Island Happy";
        items[442] = "Island Scared";
        items[443] = "Island Sick";
        items[444] = "Jellyfish Bored";
        items[445] = "Jellyfish Happy";
        items[446] = "Jellyfish Scared";
        items[447] = "Jellyfish Sick";
        items[448] = "Jupiter Bored";
        items[449] = "Jupiter Happy";
        items[450] = "Jupiter Scared";
        items[451] = "Jupiter Sick";
        items[452] = "Kangaroo Bored";
        items[453] = "Kangaroo Happy";
        items[454] = "Kangaroo Scared";
        items[455] = "Kangaroo Sick";
        items[456] = "Ketchup Bored";
        items[457] = "Ketchup Happy";
        items[458] = "Ketchup Scared";
        items[459] = "Ketchup Sick";
        items[460] = "Laptop Bored";
        items[461] = "Laptop Happy";
        items[462] = "Laptop Scared";
        items[463] = "Laptop Sick";
        items[464] = "Lightning Bolt Bored";
        items[465] = "Lightning Bolt Happy";
        items[466] = "Lightning Bolt Scared";
        items[467] = "Lightning Bolt Sick";
        items[468] = "Lint Bored";
        items[469] = "Lint Happy";
        items[470] = "Lint Scared";
        items[471] = "Lint Sick";
        items[472] = "Lips Bored";
        items[473] = "Lips Happy";
        items[474] = "Lips Scared";
        items[475] = "Lips Sick";
        items[476] = "Lipstick2 Bored";
        items[477] = "Lipstick2 Happy";
        items[478] = "Lipstick2 Scared";
        items[479] = "Lipstick2 Sick";
        items[480] = "Lock Bored";
        items[481] = "Lock Happy";
        items[482] = "Lock Scared";
        items[483] = "Lock Sick";
        items[484] = "Macaroni Bored";
        items[485] = "Macaroni Happy";
        items[486] = "Macaroni Scared";
        items[487] = "Macaroni Sick";
        items[488] = "Mailbox Bored";
        items[489] = "Mailbox Happy";
        items[490] = "Mailbox Scared";
        items[491] = "Mailbox Sick";
        items[492] = "Maze Bored";
        items[493] = "Maze Happy";
        items[494] = "Maze Scared";
        items[495] = "Maze Sick";
        items[496] = "Microwave Bored";
        items[497] = "Microwave Happy";
        items[498] = "Microwave Scared";
        items[499] = "Microwave Sick";
        items[500] = "Milk Bored";
        items[501] = "Milk Happy";
        items[502] = "Milk Scared";
        items[503] = "Milk Sick";
        items[504] = "Mirror Bored";
        items[505] = "Mirror Happy";
        items[506] = "Mirror Scared";
        items[507] = "Mirror Sick";
        items[508] = "Mixer Bored";
        items[509] = "Mixer Happy";
        items[510] = "Mixer Scared";
        items[511] = "Mixer Sick";
        items[512] = "Moon Bored";
        items[513] = "Moon Happy";
        items[514] = "Moon Scared";
        items[515] = "Moon Sick";
        items[516] = "Moose Bored";
        items[517] = "Moose Happy";
        items[518] = "Moose Scared";
        items[519] = "Moose Sick";
        items[520] = "Mosquito Bored";
        items[521] = "Mosquito Happy";
        items[522] = "Mosquito Scared";
        items[523] = "Mosquito Sick";
        items[524] = "Mountain Snowcap Bored";
        items[525] = "Mountain Snowcap Happy";
        items[526] = "Mountain Snowcap Scared";
        items[527] = "Mountain Snowcap Sick";
        items[528] = "Mouse Bored";
        items[529] = "Mouse Happy";
        items[530] = "Mouse Scared";
        items[531] = "Mouse Sick";
        items[532] = "Mug Bored";
        items[533] = "Mug Happy";
        items[534] = "Mug Scared";
        items[535] = "Mug Sick";
        items[536] = "Mushroom Bored";
        items[537] = "Mushroom Happy";
        items[538] = "Mushroom Scared";
        items[539] = "Mushroom Sick";
        items[540] = "Mustard Bored";
        items[541] = "Mustard Happy";
        items[542] = "Mustard Scared";
        items[543] = "Mustard Sick";
        items[544] = "Nigiri Bored";
        items[545] = "Nigiri Happy";
        items[546] = "Nigiri Scared";
        items[547] = "Nigiri Sick";
        items[548] = "Noodles Bored";
        items[549] = "Noodles Happy";
        items[550] = "Noodles Scared";
        items[551] = "Noodles Sick";
        items[552] = "Onion Bored";
        items[553] = "Onion Happy";
        items[554] = "Onion Scared";
        items[555] = "Onion Sick";
        items[556] = "Orangutan Bored";
        items[557] = "Orangutan Happy";
        items[558] = "Orangutan Scared";
        items[559] = "Orangutan Sick";
        items[560] = "Orca Bored";
        items[561] = "Orca Happy";
        items[562] = "Orca Scared";
        items[563] = "Orca Sick";
        items[564] = "Otter Bored";
        items[565] = "Otter Happy";
        items[566] = "Otter Scared";
        items[567] = "Otter Sick";
        items[568] = "Outlet Bored";
        items[569] = "Outlet Happy";
        items[570] = "Outlet Scared";
        items[571] = "Outlet Sick";
        items[572] = "Owl Bored";
        items[573] = "Owl Happy";
        items[574] = "Owl Scared";
        items[575] = "Owl Sick";
        items[576] = "Oyster Bored";
        items[577] = "Oyster Happy";
        items[578] = "Oyster Scared";
        items[579] = "Oyster Sick";
        items[580] = "Paintbrush Bored";
        items[581] = "Paintbrush Happy";
        items[582] = "Paintbrush Scared";
        items[583] = "Paintbrush Sick";
        items[584] = "Panda Bored";
        items[585] = "Panda Happy";
        items[586] = "Panda Scared";
        items[587] = "Panda Sick";
        items[588] = "Paperclip Bored";
        items[589] = "Paperclip Happy";
        items[590] = "Paperclip Scared";
        items[591] = "Paperclip Sick";
        items[592] = "Peanut Bored";
        items[593] = "Peanut Happy";
        items[594] = "Peanut Scared";
        items[595] = "Peanut Sick";
        items[596] = "Pencil Tip Bored";
        items[597] = "Pencil Tip Happy";
        items[598] = "Pencil Tip Scared";
        items[599] = "Pencil Tip Sick";
        items[600] = "Peyote Bored";
        items[601] = "Peyote Happy";
        items[602] = "Peyote Scared";
        items[603] = "Peyote Sick";
        items[604] = "Piano Bored";
        items[605] = "Piano Happy";
        items[606] = "Piano Scared";
        items[607] = "Piano Sick";
        items[608] = "Pickle Bored";
        items[609] = "Pickle Happy";
        items[610] = "Pickle Scared";
        items[611] = "Pickle Sick";
        items[612] = "Pie Bored";
        items[613] = "Pie Happy";
        items[614] = "Pie Scared";
        items[615] = "Pie Sick";
        items[616] = "Piggybank Bored";
        items[617] = "Piggybank Happy";
        items[618] = "Piggybank Scared";
        items[619] = "Piggybank Sick";
        items[620] = "Pill Bored";
        items[621] = "Pill Happy";
        items[622] = "Pill Scared";
        items[623] = "Pill Sick";
        items[624] = "Pillow Bored";
        items[625] = "Pillow Happy";
        items[626] = "Pillow Scared";
        items[627] = "Pillow Sick";
        items[628] = "Pineapple Bored";
        items[629] = "Pineapple Happy";
        items[630] = "Pineapple Scared";
        items[631] = "Pineapple Sick";
        items[632] = "Pipe Bored";
        items[633] = "Pipe Happy";
        items[634] = "Pipe Scared";
        items[635] = "Pipe Sick";
        items[636] = "Pirateship Bored";
        items[637] = "Pirateship Happy";
        items[638] = "Pirateship Scared";
        items[639] = "Pirateship Sick";
        items[640] = "Pizza Bored";
        items[641] = "Pizza Happy";
        items[642] = "Pizza Scared";
        items[643] = "Pizza Sick";
        items[644] = "Plane Bored";
        items[645] = "Plane Happy";
        items[646] = "Plane Scared";
        items[647] = "Plane Sick";
        items[648] = "Pop Bored";
        items[649] = "Pop Happy";
        items[650] = "Pop Scared";
        items[651] = "Pop Sick";
        items[652] = "Porkbao Bored";
        items[653] = "Porkbao Happy";
        items[654] = "Porkbao Scared";
        items[655] = "Porkbao Sick";
        items[656] = "Pufferfish Bored";
        items[657] = "Pufferfish Happy";
        items[658] = "Pufferfish Scared";
        items[659] = "Pufferfish Sick";
        items[660] = "Pumpkin Bored";
        items[661] = "Pumpkin Happy";
        items[662] = "Pumpkin Scared";
        items[663] = "Pumpkin Sick";
        items[664] = "Pyramid Bored";
        items[665] = "Pyramid Happy";
        items[666] = "Pyramid Scared";
        items[667] = "Pyramid Sick";
        items[668] = "Queencrown Bored";
        items[669] = "Queencrown Happy";
        items[670] = "Queencrown Scared";
        items[671] = "Queencrown Sick";
        items[672] = "Rabbit Bored";
        items[673] = "Rabbit Happy";
        items[674] = "Rabbit Scared";
        items[675] = "Rabbit Sick";
        items[676] = "Rainbow Bored";
        items[677] = "Rainbow Happy";
        items[678] = "Rainbow Scared";
        items[679] = "Rainbow Sick";
        items[680] = "Rangefinder Bored";
        items[681] = "Rangefinder Happy";
        items[682] = "Rangefinder Scared";
        items[683] = "Rangefinder Sick";
        items[684] = "Raven Bored";
        items[685] = "Raven Happy";
        items[686] = "Raven Scared";
        items[687] = "Raven Sick";
        items[688] = "Retainer Bored";
        items[689] = "Retainer Happy";
        items[690] = "Retainer Scared";
        items[691] = "Retainer Sick";
        items[692] = "Rgb Bored";
        items[693] = "Rgb Happy";
        items[694] = "Rgb Scared";
        items[695] = "Rgb Sick";
        items[696] = "Ring Bored";
        items[697] = "Ring Happy";
        items[698] = "Ring Scared";
        items[699] = "Ring Sick";
        items[700] = "Road Bored";
        items[701] = "Road Happy";
        items[702] = "Road Scared";
        items[703] = "Road Sick";
        items[704] = "Robot Bored";
        items[705] = "Robot Happy";
        items[706] = "Robot Scared";
        items[707] = "Robot Sick";
        items[708] = "Rock Bored";
        items[709] = "Rock Happy";
        items[710] = "Rock Scared";
        items[711] = "Rock Sick";
        items[712] = "Rosebud Bored";
        items[713] = "Rosebud Happy";
        items[714] = "Rosebud Scared";
        items[715] = "Rosebud Sick";
        items[716] = "Ruler Triangular Bored";
        items[717] = "Ruler Triangular Happy";
        items[718] = "Ruler Triangular Scared";
        items[719] = "Ruler Triangular Sick";
        items[720] = "Safe Bored";
        items[721] = "Safe Happy";
        items[722] = "Safe Scared";
        items[723] = "Safe Sick";
        items[724] = "Saguaro Bored";
        items[725] = "Saguaro Happy";
        items[726] = "Saguaro Scared";
        items[727] = "Saguaro Sick";
        items[728] = "Sailboat Bored";
        items[729] = "Sailboat Happy";
        items[730] = "Sailboat Scared";
        items[731] = "Sailboat Sick";
        items[732] = "Sandwich Bored";
        items[733] = "Sandwich Happy";
        items[734] = "Sandwich Scared";
        items[735] = "Sandwich Sick";
        items[736] = "Saturn Bored";
        items[737] = "Saturn Happy";
        items[738] = "Saturn Scared";
        items[739] = "Saturn Sick";
        items[740] = "Saw Bored";
        items[741] = "Saw Happy";
        items[742] = "Saw Scared";
        items[743] = "Saw Sick";
        items[744] = "Scorpion Bored";
        items[745] = "Scorpion Happy";
        items[746] = "Scorpion Scared";
        items[747] = "Scorpion Sick";
        items[748] = "Shark Bored";
        items[749] = "Shark Happy";
        items[750] = "Shark Scared";
        items[751] = "Shark Sick";
        items[752] = "Shower Bored";
        items[753] = "Shower Happy";
        items[754] = "Shower Scared";
        items[755] = "Shower Sick";
        items[756] = "Skateboard Bored";
        items[757] = "Skateboard Happy";
        items[758] = "Skateboard Scared";
        items[759] = "Skateboard Sick";
        items[760] = "Skeleton Hat Bored";
        items[761] = "Skeleton Hat Happy";
        items[762] = "Skeleton Hat Scared";
        items[763] = "Skeleton Hat Sick";
        items[764] = "Skilift Bored";
        items[765] = "Skilift Happy";
        items[766] = "Skilift Scared";
        items[767] = "Skilift Sick";
        items[768] = "Snowglobe Bored";
        items[769] = "Snowglobe Happy";
        items[770] = "Snowglobe Scared";
        items[771] = "Snowglobe Sick";
        items[772] = "Snowman Bored";
        items[773] = "Snowman Happy";
        items[774] = "Snowman Scared";
        items[775] = "Snowman Sick";
        items[776] = "Snowmobile Bored";
        items[777] = "Snowmobile Happy";
        items[778] = "Snowmobile Scared";
        items[779] = "Snowmobile Sick";
        items[780] = "Spaghetti Bored";
        items[781] = "Spaghetti Happy";
        items[782] = "Spaghetti Scared";
        items[783] = "Spaghetti Sick";
        items[784] = "Sponge Bored";
        items[785] = "Sponge Happy";
        items[786] = "Sponge Scared";
        items[787] = "Sponge Sick";
        items[788] = "Squid Bored";
        items[789] = "Squid Happy";
        items[790] = "Squid Scared";
        items[791] = "Squid Sick";
        items[792] = "Stapler Bored";
        items[793] = "Stapler Happy";
        items[794] = "Stapler Scared";
        items[795] = "Stapler Sick";
        items[796] = "Star Sparkles Bored";
        items[797] = "Star Sparkles Happy";
        items[798] = "Star Sparkles Scared";
        items[799] = "Star Sparkles Sick";
        items[800] = "Steak Bored";
        items[801] = "Steak Happy";
        items[802] = "Steak Scared";
        items[803] = "Steak Sick";
        items[804] = "Sunset Bored";
        items[805] = "Sunset Happy";
        items[806] = "Sunset Scared";
        items[807] = "Sunset Sick";
        items[808] = "Taco Classic Bored";
        items[809] = "Taco Classic Happy";
        items[810] = "Taco Classic Scared";
        items[811] = "Taco Classic Sick";
        items[812] = "Taxi Bored";
        items[813] = "Taxi Happy";
        items[814] = "Taxi Scared";
        items[815] = "Taxi Sick";
        items[816] = "Thumbsup Bored";
        items[817] = "Thumbsup Happy";
        items[818] = "Thumbsup Scared";
        items[819] = "Thumbsup Sick";
        items[820] = "Toaster Bored";
        items[821] = "Toaster Happy";
        items[822] = "Toaster Scared";
        items[823] = "Toaster Sick";
        items[824] = "Tooth Bored";
        items[825] = "Tooth Happy";
        items[826] = "Tooth Scared";
        items[827] = "Tooth Sick";
        items[828] = "Toothbrush Bored";
        items[829] = "Toothbrush Happy";
        items[830] = "Toothbrush Scared";
        items[831] = "Toothbrush Sick";
        items[832] = "Tornado Bored";
        items[833] = "Tornado Happy";
        items[834] = "Tornado Scared";
        items[835] = "Tornado Sick";
        items[836] = "Trashcan Bored";
        items[837] = "Trashcan Happy";
        items[838] = "Trashcan Scared";
        items[839] = "Trashcan Sick";
        items[840] = "Treasurechest Bored";
        items[841] = "Treasurechest Happy";
        items[842] = "Treasurechest Scared";
        items[843] = "Treasurechest Sick";
        items[844] = "Turing Bored";
        items[845] = "Turing Happy";
        items[846] = "Turing Scared";
        items[847] = "Turing Sick";
        items[848] = "Ufo Bored";
        items[849] = "Ufo Happy";
        items[850] = "Ufo Scared";
        items[851] = "Ufo Sick";
        items[852] = "Undead Bored";
        items[853] = "Undead Happy";
        items[854] = "Undead Scared";
        items[855] = "Undead Sick";
        items[856] = "Unicorn Bored";
        items[857] = "Unicorn Happy";
        items[858] = "Unicorn Scared";
        items[859] = "Unicorn Sick";
        items[860] = "Vending Machine Bored";
        items[861] = "Vending Machine Happy";
        items[862] = "Vending Machine Scared";
        items[863] = "Vending Machine Sick";
        items[864] = "Vent Bored";
        items[865] = "Vent Happy";
        items[866] = "Vent Scared";
        items[867] = "Vent Sick";
        items[868] = "Void Bored";
        items[869] = "Void Happy";
        items[870] = "Void Scared";
        items[871] = "Void Sick";
        items[872] = "Volcano Bored";
        items[873] = "Volcano Happy";
        items[874] = "Volcano Scared";
        items[875] = "Volcano Sick";
        items[876] = "Volleyball Bored";
        items[877] = "Volleyball Happy";
        items[878] = "Volleyball Scared";
        items[879] = "Volleyball Sick";
        items[880] = "Wall Bored";
        items[881] = "Wall Happy";
        items[882] = "Wall Scared";
        items[883] = "Wall Sick";
        items[884] = "Wallet Bored";
        items[885] = "Wallet Happy";
        items[886] = "Wallet Scared";
        items[887] = "Wallet Sick";
        items[888] = "Washingmachine Bored";
        items[889] = "Washingmachine Happy";
        items[890] = "Washingmachine Scared";
        items[891] = "Washingmachine Sick";
        items[892] = "Watch Bored";
        items[893] = "Watch Happy";
        items[894] = "Watch Scared";
        items[895] = "Watch Sick";
        items[896] = "Watermelon Bored";
        items[897] = "Watermelon Happy";
        items[898] = "Watermelon Scared";
        items[899] = "Watermelon Sick";
        items[900] = "Wave Bored";
        items[901] = "Wave Happy";
        items[902] = "Wave Scared";
        items[903] = "Wave Sick";
        items[904] = "Weed Bored";
        items[905] = "Weed Happy";
        items[906] = "Weed Scared";
        items[907] = "Weed Sick";
        items[908] = "Weight Bored";
        items[909] = "Weight Happy";
        items[910] = "Weight Scared";
        items[911] = "Weight Sick";
        items[912] = "Werewolf Bored";
        items[913] = "Werewolf Happy";
        items[914] = "Werewolf Scared";
        items[915] = "Werewolf Sick";
        items[916] = "Whale Alive Bored";
        items[917] = "Whale Alive Happy";
        items[918] = "Whale Alive Scared";
        items[919] = "Whale Alive Sick";
        items[920] = "Whale Bored";
        items[921] = "Whale Happy";
        items[922] = "Whale Scared";
        items[923] = "Whale Sick";
        items[924] = "Wine Barrel Bored";
        items[925] = "Wine Barrel Happy";
        items[926] = "Wine Barrel Scared";
        items[927] = "Wine Barrel Sick";
        items[928] = "Wine Bored";
        items[929] = "Wine Happy";
        items[930] = "Wine Scared";
        items[931] = "Wine Sick";
        items[932] = "Wizardhat Bored";
        items[933] = "Wizardhat Happy";
        items[934] = "Wizardhat Scared";
        items[935] = "Wizardhat Sick";
        items[936] = "Zebra Bored";
        items[937] = "Zebra Happy";
        items[938] = "Zebra Scared";
        items[939] = "Zebra Sick";

        bytes memory data = abi.encode(items);

        VmSafe vm = VmSafe(
            address(uint160(uint256(keccak256("hevm cheat code"))))
        );

        string[] memory inputs = new string[](3);
        inputs[0] = "node";
        inputs[1] = "script/nouns-coasters/deflate.js";
        inputs[2] = vm.toString(data);

        bytes memory compressedData = vm.ffi(inputs);

        // address result = SSTORE2.write(compressedData);

        renderer.addLayer({
            target: target,
            ipfs: INounsCoasterMetadataRendererTypes.IPFSGroup({
                baseUri: "ipfs://bafybeiag26lh2at7iah5xqlrzgj2ei2jd2qel3g5bpccgfj5ktjbvu4qm4/",
                extension: ".png"
            }),
            decompressedSize: data.length,
            compressedData: compressedData,
            count: items.length,
            property: "17 Head front left",
            variantProperty: variantPropertyParameters
        });
    }

    function addLayer18(NounsCoasterMetadataRenderer renderer, address target)
        internal
    {
        // 18 Expression front left
        INounsCoasterMetadataRendererTypes.VariantPropertyParameters
            memory variantPropertyParameters;
        variantPropertyParameters
            .offsets = new INounsCoasterMetadataRendererTypes.VariantOffset[](
            0
        );
        variantPropertyParameters.id = 0;
        variantPropertyParameters.count = 0;

        string[] memory items = new string[](4);
        items[0] = "Bored";
        items[1] = "Happy";
        items[2] = "Scared";
        items[3] = "Sick";

        bytes memory data = abi.encode(items);

        VmSafe vm = VmSafe(
            address(uint160(uint256(keccak256("hevm cheat code"))))
        );

        string[] memory inputs = new string[](3);
        inputs[0] = "node";
        inputs[1] = "script/nouns-coasters/deflate.js";
        inputs[2] = vm.toString(data);

        bytes memory compressedData = vm.ffi(inputs);

        // address result = SSTORE2.write(compressedData);

        renderer.addLayer({
            target: target,
            ipfs: INounsCoasterMetadataRendererTypes.IPFSGroup({
                baseUri: "ipfs://bafybeiag26lh2at7iah5xqlrzgj2ei2jd2qel3g5bpccgfj5ktjbvu4qm4/",
                extension: ".png"
            }),
            decompressedSize: data.length,
            compressedData: compressedData,
            count: items.length,
            property: "18 Expression front left",
            variantProperty: variantPropertyParameters
        });
    }

    function addLayer19(NounsCoasterMetadataRenderer renderer, address target)
        internal
    {
        // 19 Glasses front left
        INounsCoasterMetadataRendererTypes.VariantPropertyParameters
            memory variantPropertyParameters;
        variantPropertyParameters
            .offsets = new INounsCoasterMetadataRendererTypes.VariantOffset[](
            0
        );
        variantPropertyParameters.id = 0;
        variantPropertyParameters.count = 0;

        string[] memory items = new string[](21);
        items[0] = "Black";
        items[1] = "Black Red Eyes";
        items[2] = "Black Rgb";
        items[3] = "Blue";
        items[4] = "Blue Med Saturated";
        items[5] = "Frog Green";
        items[6] = "Full Black";
        items[7] = "Green Blue Multi";
        items[8] = "Grey Light";
        items[9] = "Guava";
        items[10] = "Hip Rose";
        items[11] = "Honey";
        items[12] = "Magenta";
        items[13] = "Orange";
        items[14] = "Pink Purple Multi";
        items[15] = "Red";
        items[16] = "Smoke";
        items[17] = "Teal";
        items[18] = "Watermelon";
        items[19] = "Yellow Orange Multi";
        items[20] = "Yellow Saturated";

        bytes memory data = abi.encode(items);

        VmSafe vm = VmSafe(
            address(uint160(uint256(keccak256("hevm cheat code"))))
        );

        string[] memory inputs = new string[](3);
        inputs[0] = "node";
        inputs[1] = "script/nouns-coasters/deflate.js";
        inputs[2] = vm.toString(data);

        bytes memory compressedData = vm.ffi(inputs);

        // address result = SSTORE2.write(compressedData);

        renderer.addLayer({
            target: target,
            ipfs: INounsCoasterMetadataRendererTypes.IPFSGroup({
                baseUri: "ipfs://bafybeiag26lh2at7iah5xqlrzgj2ei2jd2qel3g5bpccgfj5ktjbvu4qm4/",
                extension: ".png"
            }),
            decompressedSize: data.length,
            compressedData: compressedData,
            count: items.length,
            property: "19 Glasses front left",
            variantProperty: variantPropertyParameters
        });
    }

    function addLayer20(NounsCoasterMetadataRenderer renderer, address target)
        internal
    {
        // 20 Body front right
        INounsCoasterMetadataRendererTypes.VariantPropertyParameters
            memory variantPropertyParameters;
        variantPropertyParameters
            .offsets = new INounsCoasterMetadataRendererTypes.VariantOffset[](
            4
        );
        variantPropertyParameters.id = 3;
        variantPropertyParameters.count = 4;
        variantPropertyParameters.offsets[
            0
        ] = INounsCoasterMetadataRendererTypes.VariantOffset({
            startAt: 0,
            count: 30
        });
        variantPropertyParameters.offsets[
            1
        ] = INounsCoasterMetadataRendererTypes.VariantOffset({
            startAt: 30,
            count: 30
        });
        variantPropertyParameters.offsets[
            2
        ] = INounsCoasterMetadataRendererTypes.VariantOffset({
            startAt: 60,
            count: 30
        });
        variantPropertyParameters.offsets[
            3
        ] = INounsCoasterMetadataRendererTypes.VariantOffset({
            startAt: 90,
            count: 30
        });

        string[] memory items = new string[](120);
        items[0] = "1-Both Arms Down Bege Bsod";
        items[1] = "1-Both Arms Down Bege Crt";
        items[2] = "1-Both Arms Down Blue Grey";
        items[3] = "1-Both Arms Down Blue Sky";
        items[4] = "1-Both Arms Down Cold";
        items[5] = "1-Both Arms Down Computer Blue";
        items[6] = "1-Both Arms Down Dark Brown";
        items[7] = "1-Both Arms Down Dark Pink";
        items[8] = "1-Both Arms Down Foggrey";
        items[9] = "1-Both Arms Down Gold";
        items[10] = "1-Both Arms Down Gray Scale 1";
        items[11] = "1-Both Arms Down Gray Scale 7";
        items[12] = "1-Both Arms Down Gray Scale 8";
        items[13] = "1-Both Arms Down Gray Scale 9";
        items[14] = "1-Both Arms Down Green";
        items[15] = "1-Both Arms Down Gunk";
        items[16] = "1-Both Arms Down Hotbrown";
        items[17] = "1-Both Arms Down Magenta";
        items[18] = "1-Both Arms Down Orange";
        items[19] = "1-Both Arms Down Orange Yellow";
        items[20] = "1-Both Arms Down Peachy A";
        items[21] = "1-Both Arms Down Peachy B";
        items[22] = "1-Both Arms Down Purple";
        items[23] = "1-Both Arms Down Red";
        items[24] = "1-Both Arms Down Red Pinkish";
        items[25] = "1-Both Arms Down Rust";
        items[26] = "1-Both Arms Down Slime Green";
        items[27] = "1-Both Arms Down Teal";
        items[28] = "1-Both Arms Down Teal Light";
        items[29] = "1-Both Arms Down Yellow";
        items[30] = "2-Both Arms Up Bege Bsod";
        items[31] = "2-Both Arms Up Bege Crt";
        items[32] = "2-Both Arms Up Blue Grey";
        items[33] = "2-Both Arms Up Blue Sky";
        items[34] = "2-Both Arms Up Cold";
        items[35] = "2-Both Arms Up Computer Blue";
        items[36] = "2-Both Arms Up Dark Brown";
        items[37] = "2-Both Arms Up Dark Pink";
        items[38] = "2-Both Arms Up Foggrey";
        items[39] = "2-Both Arms Up Gold";
        items[40] = "2-Both Arms Up Gray Scale 1";
        items[41] = "2-Both Arms Up Gray Scale 7";
        items[42] = "2-Both Arms Up Gray Scale 8";
        items[43] = "2-Both Arms Up Gray Scale 9";
        items[44] = "2-Both Arms Up Green";
        items[45] = "2-Both Arms Up Gunk";
        items[46] = "2-Both Arms Up Hotbrown";
        items[47] = "2-Both Arms Up Magenta";
        items[48] = "2-Both Arms Up Orange";
        items[49] = "2-Both Arms Up Orange Yellow";
        items[50] = "2-Both Arms Up Peachy A";
        items[51] = "2-Both Arms Up Peachy B";
        items[52] = "2-Both Arms Up Purple";
        items[53] = "2-Both Arms Up Red";
        items[54] = "2-Both Arms Up Red Pinkish";
        items[55] = "2-Both Arms Up Rust";
        items[56] = "2-Both Arms Up Slime Green";
        items[57] = "2-Both Arms Up Teal";
        items[58] = "2-Both Arms Up Teal Light";
        items[59] = "2-Both Arms Up Yellow";
        items[60] = "3-Left Arm Up Bege Bsod";
        items[61] = "3-Left Arm Up Bege Crt";
        items[62] = "3-Left Arm Up Blue Grey";
        items[63] = "3-Left Arm Up Blue Sky";
        items[64] = "3-Left Arm Up Cold";
        items[65] = "3-Left Arm Up Computer Blue";
        items[66] = "3-Left Arm Up Dark Brown";
        items[67] = "3-Left Arm Up Dark Pink";
        items[68] = "3-Left Arm Up Foggrey";
        items[69] = "3-Left Arm Up Gold";
        items[70] = "3-Left Arm Up Gray Scale 1";
        items[71] = "3-Left Arm Up Gray Scale 7";
        items[72] = "3-Left Arm Up Gray Scale 8";
        items[73] = "3-Left Arm Up Gray Scale 9";
        items[74] = "3-Left Arm Up Green";
        items[75] = "3-Left Arm Up Gunk";
        items[76] = "3-Left Arm Up Hotbrown";
        items[77] = "3-Left Arm Up Magenta";
        items[78] = "3-Left Arm Up Orange";
        items[79] = "3-Left Arm Up Orange Yellow";
        items[80] = "3-Left Arm Up Peachy A";
        items[81] = "3-Left Arm Up Peachy B";
        items[82] = "3-Left Arm Up Purple";
        items[83] = "3-Left Arm Up Red";
        items[84] = "3-Left Arm Up Red Pinkish";
        items[85] = "3-Left Arm Up Rust";
        items[86] = "3-Left Arm Up Slime Green";
        items[87] = "3-Left Arm Up Teal";
        items[88] = "3-Left Arm Up Teal Light";
        items[89] = "3-Left Arm Up Yellow";
        items[90] = "4-Right Arm Up Bege Bsod";
        items[91] = "4-Right Arm Up Bege Crt";
        items[92] = "4-Right Arm Up Blue Grey";
        items[93] = "4-Right Arm Up Blue Sky";
        items[94] = "4-Right Arm Up Cold";
        items[95] = "4-Right Arm Up Computer Blue";
        items[96] = "4-Right Arm Up Dark Brown";
        items[97] = "4-Right Arm Up Dark Pink";
        items[98] = "4-Right Arm Up Foggrey";
        items[99] = "4-Right Arm Up Gold";
        items[100] = "4-Right Arm Up Gray Scale 1";
        items[101] = "4-Right Arm Up Gray Scale 7";
        items[102] = "4-Right Arm Up Gray Scale 8";
        items[103] = "4-Right Arm Up Gray Scale 9";
        items[104] = "4-Right Arm Up Green";
        items[105] = "4-Right Arm Up Gunk";
        items[106] = "4-Right Arm Up Hotbrown";
        items[107] = "4-Right Arm Up Magenta";
        items[108] = "4-Right Arm Up Orange";
        items[109] = "4-Right Arm Up Orange Yellow";
        items[110] = "4-Right Arm Up Peachy A";
        items[111] = "4-Right Arm Up Peachy B";
        items[112] = "4-Right Arm Up Purple";
        items[113] = "4-Right Arm Up Red";
        items[114] = "4-Right Arm Up Red Pinkish";
        items[115] = "4-Right Arm Up Rust";
        items[116] = "4-Right Arm Up Slime Green";
        items[117] = "4-Right Arm Up Teal";
        items[118] = "4-Right Arm Up Teal Light";
        items[119] = "4-Right Arm Up Yellow";

        bytes memory data = abi.encode(items);

        VmSafe vm = VmSafe(
            address(uint160(uint256(keccak256("hevm cheat code"))))
        );

        string[] memory inputs = new string[](3);
        inputs[0] = "node";
        inputs[1] = "script/nouns-coasters/deflate.js";
        inputs[2] = vm.toString(data);

        bytes memory compressedData = vm.ffi(inputs);

        // address result = SSTORE2.write(compressedData);

        renderer.addLayer({
            target: target,
            ipfs: INounsCoasterMetadataRendererTypes.IPFSGroup({
                baseUri: "ipfs://bafybeiag26lh2at7iah5xqlrzgj2ei2jd2qel3g5bpccgfj5ktjbvu4qm4/",
                extension: ".png"
            }),
            decompressedSize: data.length,
            compressedData: compressedData,
            count: items.length,
            property: "20 Body front right",
            variantProperty: variantPropertyParameters
        });
    }

    function addLayer21(NounsCoasterMetadataRenderer renderer, address target)
        internal
    {
        // 21 Accessories front right
        INounsCoasterMetadataRendererTypes.VariantPropertyParameters
            memory variantPropertyParameters;
        variantPropertyParameters
            .offsets = new INounsCoasterMetadataRendererTypes.VariantOffset[](
            4
        );
        variantPropertyParameters.id = 3;
        variantPropertyParameters.count = 4;
        variantPropertyParameters.offsets[
            0
        ] = INounsCoasterMetadataRendererTypes.VariantOffset({
            startAt: 0,
            count: 139
        });
        variantPropertyParameters.offsets[
            1
        ] = INounsCoasterMetadataRendererTypes.VariantOffset({
            startAt: 139,
            count: 137
        });
        variantPropertyParameters.offsets[
            2
        ] = INounsCoasterMetadataRendererTypes.VariantOffset({
            startAt: 276,
            count: 137
        });
        variantPropertyParameters.offsets[
            3
        ] = INounsCoasterMetadataRendererTypes.VariantOffset({
            startAt: 413,
            count: 137
        });

        string[] memory items = new string[](550);
        items[0] = "1-Asset Front Right 1n";
        items[1] = "1-Asset Front Right Aardvark";
        items[2] = "1-Asset Front Right Axe";
        items[3] = "1-Asset Front Right Belly Chamaleon";
        items[4] = "1-Asset Front Right Bird Flying";
        items[5] = "1-Asset Front Right Bird Side";
        items[6] = "1-Asset Front Right Bling Anchor";
        items[7] = "1-Asset Front Right Bling Anvil";
        items[8] = "1-Asset Front Right Bling Arrow";
        items[9] = "1-Asset Front Right Bling Cheese";
        items[10] = "1-Asset Front Right Bling Gold Ingot";
        items[11] = "1-Asset Front Right Bling Love";
        items[12] = "1-Asset Front Right Bling Mask";
        items[13] = "1-Asset Front Right Bling Rings";
        items[14] = "1-Asset Front Right Bling Sparkles";
        items[15] = "1-Asset Front Right Both Arms Down Bege Bsod";
        items[16] = "1-Asset Front Right Both Arms Down Belly Chamaleon";
        items[17] = "1-Asset Front Right Both Arms Down Big Walk Blue Prime";
        items[18] = "1-Asset Front Right Both Arms Down Big Walk Grey Light";
        items[19] = "1-Asset Front Right Both Arms Down Big Walk Rainbow";
        items[20] = "1-Asset Front Right Both Arms Down Chain Logo";
        items[21] = "1-Asset Front Right Both Arms Down Checker Disco";
        items[22] = "1-Asset Front Right Both Arms Down Checker Rgb";
        items[23] = "1-Asset Front Right Both Arms Down Checker Spaced Black";
        items[24] = "1-Asset Front Right Both Arms Down Checker Spaced White";
        items[25] = "1-Asset Front Right Both Arms Down Checker Vibrant";
        items[26] = "1-Asset Front Right Both Arms Down Checkers Big Green";
        items[27] = "1-Asset Front Right Both Arms Down Checkers Big Red Cold";
        items[28] = "1-Asset Front Right Both Arms Down Checkers Black";
        items[29] = "1-Asset Front Right Both Arms Down Checkers Blue";
        items[30] = "1-Asset Front Right Both Arms Down Checkers Magenta";
        items[31] = "1-Asset Front Right Both Arms Down Collar Sunset";
        items[32] = "1-Asset Front Right Both Arms Down Decay Gray Dark";
        items[33] = "1-Asset Front Right Both Arms Down Decay Pride";
        items[34] = "1-Asset Front Right Both Arms Down Gradient Dawn";
        items[35] = "1-Asset Front Right Both Arms Down Gradient Dusk";
        items[36] = "1-Asset Front Right Both Arms Down Gradient Glacier";
        items[37] = "1-Asset Front Right Both Arms Down Gradient Ice";
        items[38] = "1-Asset Front Right Both Arms Down Gradient Pride";
        items[39] = "1-Asset Front Right Both Arms Down Gradient Redpink";
        items[40] = "1-Asset Front Right Both Arms Down Gradient Sunset";
        items[41] = "1-Asset Front Right Both Arms Down Gray Scale 1";
        items[42] = "1-Asset Front Right Both Arms Down Gray Scale 9";
        items[43] = "1-Asset Front Right Both Arms Down Grid Simple Bege";
        items[44] = "1-Asset Front Right Both Arms Down Ice Cold";
        items[45] = "1-Asset Front Right Both Arms Down Lines 45 Greens";
        items[46] = "1-Asset Front Right Both Arms Down Lines 45 Rose";
        items[47] = "1-Asset Front Right Both Arms Down Old Shirt";
        items[48] = "1-Asset Front Right Both Arms Down Rainbow Steps";
        items[49] = "1-Asset Front Right Both Arms Down Robot";
        items[50] = "1-Asset Front Right Both Arms Down Safety Vest";
        items[51] = "1-Asset Front Right Both Arms Down Scarf Clown";
        items[52] = "1-Asset Front Right Both Arms Down Shirt Black";
        items[53] = "1-Asset Front Right Both Arms Down Stripes And Checks";
        items[54] = "1-Asset Front Right Both Arms Down Stripes Big Red";
        items[55] = "1-Asset Front Right Both Arms Down Stripes Blit";
        items[56] = "1-Asset Front Right Both Arms Down Stripes Blue Med";
        items[57] = "1-Asset Front Right Both Arms Down Stripes Brown";
        items[58] = "1-Asset Front Right Both Arms Down Stripes Olive";
        items[59] = "1-Asset Front Right Both Arms Down Stripes Red Cold";
        items[60] = "1-Asset Front Right Both Arms Down Taxi Checkers";
        items[61] = "1-Asset Front Right Both Arms Down Tee Yo";
        items[62] = "1-Asset Front Right Both Arms Down Txt Ico";
        items[63] = "1-Asset Front Right Both Arms Down Wall";
        items[64] = "1-Asset Front Right Both Arms Down Woolweave Bicolor";
        items[65] = "1-Asset Front Right Both Arms Down Woolweave Dirt";
        items[66] = "1-Asset Front Right Carrot";
        items[67] = "1-Asset Front Right Chain Logo";
        items[68] = "1-Asset Front Right Chicken";
        items[69] = "1-Asset Front Right Cloud";
        items[70] = "1-Asset Front Right Clover";
        items[71] = "1-Asset Front Right Cow";
        items[72] = "1-Asset Front Right Dinosaur";
        items[73] = "1-Asset Front Right Dollar Bling";
        items[74] = "1-Asset Front Right Doom";
        items[75] = "1-Asset Front Right Dragon";
        items[76] = "1-Asset Front Right Ducky";
        items[77] = "1-Asset Front Right Eth";
        items[78] = "1-Asset Front Right Eye";
        items[79] = "1-Asset Front Right Flash";
        items[80] = "1-Asset Front Right Foo Black";
        items[81] = "1-Asset Front Right Fries";
        items[82] = "1-Asset Front Right Glasses";
        items[83] = "1-Asset Front Right Glasses Logo";
        items[84] = "1-Asset Front Right Glasses Logo Sun";
        items[85] = "1-Asset Front Right Heart";
        items[86] = "1-Asset Front Right Hoodiestrings Uneven";
        items[87] = "1-Asset Front Right Id";
        items[88] = "1-Asset Front Right Infinity";
        items[89] = "1-Asset Front Right Insignia";
        items[90] = "1-Asset Front Right Leaf";
        items[91] = "1-Asset Front Right Light Bulb";
        items[92] = "1-Asset Front Right Lp";
        items[93] = "1-Asset Front Right Mars Face";
        items[94] = "1-Asset Front Right Matrix White";
        items[95] = "1-Asset Front Right Moon Block";
        items[96] = "1-Asset Front Right None";
        items[97] = "1-Asset Front Right Noun Txt Multicolor";
        items[98] = "1-Asset Front Right Pizza Bling";
        items[99] = "1-Asset Front Right Pocket Pencil";
        items[100] = "1-Asset Front Right Rain";
        items[101] = "1-Asset Front Right Rgb";
        items[102] = "1-Asset Front Right Scissors";
        items[103] = "1-Asset Front Right Secret X";
        items[104] = "1-Asset Front Right Shrimp";
        items[105] = "1-Asset Front Right Slime Splat";
        items[106] = "1-Asset Front Right Small Bling";
        items[107] = "1-Asset Front Right Snowflake";
        items[108] = "1-Asset Front Right Stains Blood";
        items[109] = "1-Asset Front Right Stains Zombie";
        items[110] = "1-Asset Front Right Sunset";
        items[111] = "1-Asset Front Right Think";
        items[112] = "1-Asset Front Right Tie Black On White";
        items[113] = "1-Asset Front Right Tie Dye";
        items[114] = "1-Asset Front Right Tie Purple";
        items[115] = "1-Asset Front Right Tie Red";
        items[116] = "1-Asset Front Right Txt A2+b2";
        items[117] = "1-Asset Front Right Txt Cc";
        items[118] = "1-Asset Front Right Txt Cc 2";
        items[119] = "1-Asset Front Right Txt Copy";
        items[120] = "1-Asset Front Right Txt Dao Black";
        items[121] = "1-Asset Front Right Txt Dope";
        items[122] = "1-Asset Front Right Txt Io";
        items[123] = "1-Asset Front Right Txt Lmao";
        items[124] = "1-Asset Front Right Txt Lol";
        items[125] = "1-Asset Front Right Txt Mint";
        items[126] = "1-Asset Front Right Txt Nil Grey Dark";
        items[127] = "1-Asset Front Right Txt Noun";
        items[128] = "1-Asset Front Right Txt Noun F0f";
        items[129] = "1-Asset Front Right Txt Noun Green";
        items[130] = "1-Asset Front Right Txt Pi";
        items[131] = "1-Asset Front Right Txt Pop";
        items[132] = "1-Asset Front Right Txt Rofl";
        items[133] = "1-Asset Front Right Txt We";
        items[134] = "1-Asset Front Right Txt Yay";
        items[135] = "1-Asset Front Right Txt Yolo";
        items[136] = "1-Asset Front Right Wave";
        items[137] = "1-Asset Front Right Wet Money";
        items[138] = "1-Asset Front Right Ying Yang";
        items[139] = "2-Asset Front Right 1n";
        items[140] = "2-Asset Front Right Aardvark";
        items[141] = "2-Asset Front Right Axe";
        items[142] = "2-Asset Front Right Belly Chamaleon";
        items[143] = "2-Asset Front Right Bird Flying";
        items[144] = "2-Asset Front Right Bird Side";
        items[145] = "2-Asset Front Right Bling Anchor";
        items[146] = "2-Asset Front Right Bling Anvil";
        items[147] = "2-Asset Front Right Bling Arrow";
        items[148] = "2-Asset Front Right Bling Cheese";
        items[149] = "2-Asset Front Right Bling Gold Ingot";
        items[150] = "2-Asset Front Right Bling Love";
        items[151] = "2-Asset Front Right Bling Mask";
        items[152] = "2-Asset Front Right Bling Rings";
        items[153] = "2-Asset Front Right Bling Sparkles";
        items[154] = "2-Asset Front Right Both Arms Up Bege Bsod";
        items[155] = "2-Asset Front Right Both Arms Up Bigwalk Blue Prime";
        items[156] = "2-Asset Front Right Both Arms Up Bigwalk Grey Light";
        items[157] = "2-Asset Front Right Both Arms Up Bigwalk Rainbow";
        items[158] = "2-Asset Front Right Both Arms Up Brown";
        items[159] = "2-Asset Front Right Both Arms Up Checker Disco";
        items[160] = "2-Asset Front Right Both Arms Up Checker Rgb";
        items[161] = "2-Asset Front Right Both Arms Up Checker Spaced Black";
        items[162] = "2-Asset Front Right Both Arms Up Checker Spaced White";
        items[163] = "2-Asset Front Right Both Arms Up Checker Vibrant";
        items[164] = "2-Asset Front Right Both Arms Up Checkers Big Green";
        items[165] = "2-Asset Front Right Both Arms Up Checkers Big Red Cold";
        items[166] = "2-Asset Front Right Both Arms Up Checkers Black";
        items[167] = "2-Asset Front Right Both Arms Up Checkers Blue";
        items[168] = "2-Asset Front Right Both Arms Up Checkers Magenta";
        items[169] = "2-Asset Front Right Both Arms Up Collar Sunset";
        items[170] = "2-Asset Front Right Both Arms Up Decay Gray Dark";
        items[171] = "2-Asset Front Right Both Arms Up Decay Pride";
        items[172] = "2-Asset Front Right Both Arms Up Gradient Dawn";
        items[173] = "2-Asset Front Right Both Arms Up Gradient Dusk";
        items[174] = "2-Asset Front Right Both Arms Up Gradient Glacier";
        items[175] = "2-Asset Front Right Both Arms Up Gradient Ice";
        items[176] = "2-Asset Front Right Both Arms Up Gradient Pride";
        items[177] = "2-Asset Front Right Both Arms Up Gradient Redpink";
        items[178] = "2-Asset Front Right Both Arms Up Gradient Sunset";
        items[179] = "2-Asset Front Right Both Arms Up Gray Scale 1";
        items[180] = "2-Asset Front Right Both Arms Up Gray Scale 9";
        items[181] = "2-Asset Front Right Both Arms Up Grid Simple Bege";
        items[182] = "2-Asset Front Right Both Arms Up Ice Cold";
        items[183] = "2-Asset Front Right Both Arms Up Lines 45 Greens";
        items[184] = "2-Asset Front Right Both Arms Up Lines 45 Rose";
        items[185] = "2-Asset Front Right Both Arms Up Old Shirt";
        items[186] = "2-Asset Front Right Both Arms Up Rainbow Steps";
        items[187] = "2-Asset Front Right Both Arms Up Robot";
        items[188] = "2-Asset Front Right Both Arms Up Safety Vest";
        items[189] = "2-Asset Front Right Both Arms Up Scarf Clown";
        items[190] = "2-Asset Front Right Both Arms Up Shirt Black";
        items[191] = "2-Asset Front Right Both Arms Up Stripes And Checks";
        items[192] = "2-Asset Front Right Both Arms Up Stripes Big Red";
        items[193] = "2-Asset Front Right Both Arms Up Stripes Blit";
        items[194] = "2-Asset Front Right Both Arms Up Stripes Blue Med";
        items[195] = "2-Asset Front Right Both Arms Up Stripes Olive";
        items[196] = "2-Asset Front Right Both Arms Up Stripes Red Cold";
        items[197] = "2-Asset Front Right Both Arms Up Taxi Checkers";
        items[198] = "2-Asset Front Right Both Arms Up Tee Yo";
        items[199] = "2-Asset Front Right Both Arms Up Txt Ico";
        items[200] = "2-Asset Front Right Both Arms Up Wall";
        items[201] = "2-Asset Front Right Both Arms Up Woolweave Bicolor";
        items[202] = "2-Asset Front Right Both Arms Up Woolweave Dirt";
        items[203] = "2-Asset Front Right Carrot";
        items[204] = "2-Asset Front Right Chain Logo";
        items[205] = "2-Asset Front Right Chicken";
        items[206] = "2-Asset Front Right Cloud";
        items[207] = "2-Asset Front Right Clover";
        items[208] = "2-Asset Front Right Cow";
        items[209] = "2-Asset Front Right Dinosaur";
        items[210] = "2-Asset Front Right Dollar Bling";
        items[211] = "2-Asset Front Right Doom";
        items[212] = "2-Asset Front Right Dragon";
        items[213] = "2-Asset Front Right Ducky";
        items[214] = "2-Asset Front Right Eth";
        items[215] = "2-Asset Front Right Eye";
        items[216] = "2-Asset Front Right Flash";
        items[217] = "2-Asset Front Right Foo Black";
        items[218] = "2-Asset Front Right Fries";
        items[219] = "2-Asset Front Right Glasses";
        items[220] = "2-Asset Front Right Glasses Logo";
        items[221] = "2-Asset Front Right Glasses Logo Sun";
        items[222] = "2-Asset Front Right Heart";
        items[223] = "2-Asset Front Right Hoodiestrings Uneven";
        items[224] = "2-Asset Front Right Id";
        items[225] = "2-Asset Front Right Infinity";
        items[226] = "2-Asset Front Right Insignia";
        items[227] = "2-Asset Front Right Leaf";
        items[228] = "2-Asset Front Right Light Bulb";
        items[229] = "2-Asset Front Right Lp";
        items[230] = "2-Asset Front Right Mars Face";
        items[231] = "2-Asset Front Right Matrix White";
        items[232] = "2-Asset Front Right Moon Block";
        items[233] = "2-Asset Front Right None";
        items[234] = "2-Asset Front Right Noun Txt Multicolor";
        items[235] = "2-Asset Front Right Pizza Bling";
        items[236] = "2-Asset Front Right Pocket Pencil";
        items[237] = "2-Asset Front Right Rain";
        items[238] = "2-Asset Front Right Rgb";
        items[239] = "2-Asset Front Right Scissors";
        items[240] = "2-Asset Front Right Secret X";
        items[241] = "2-Asset Front Right Shrimp";
        items[242] = "2-Asset Front Right Slime Splat";
        items[243] = "2-Asset Front Right Small Bling";
        items[244] = "2-Asset Front Right Snowflake";
        items[245] = "2-Asset Front Right Stains Blood";
        items[246] = "2-Asset Front Right Stains Zombie";
        items[247] = "2-Asset Front Right Sunset";
        items[248] = "2-Asset Front Right Think";
        items[249] = "2-Asset Front Right Tie Black On White";
        items[250] = "2-Asset Front Right Tie Dye";
        items[251] = "2-Asset Front Right Tie Purple";
        items[252] = "2-Asset Front Right Tie Red";
        items[253] = "2-Asset Front Right Txt A2+b2";
        items[254] = "2-Asset Front Right Txt Cc";
        items[255] = "2-Asset Front Right Txt Cc 2";
        items[256] = "2-Asset Front Right Txt Copy";
        items[257] = "2-Asset Front Right Txt Dao Black";
        items[258] = "2-Asset Front Right Txt Dope";
        items[259] = "2-Asset Front Right Txt Io";
        items[260] = "2-Asset Front Right Txt Lmao";
        items[261] = "2-Asset Front Right Txt Lol";
        items[262] = "2-Asset Front Right Txt Mint";
        items[263] = "2-Asset Front Right Txt Nil Grey Dark";
        items[264] = "2-Asset Front Right Txt Noun";
        items[265] = "2-Asset Front Right Txt Noun F0f";
        items[266] = "2-Asset Front Right Txt Noun Green";
        items[267] = "2-Asset Front Right Txt Pi";
        items[268] = "2-Asset Front Right Txt Pop";
        items[269] = "2-Asset Front Right Txt Rofl";
        items[270] = "2-Asset Front Right Txt We";
        items[271] = "2-Asset Front Right Txt Yay";
        items[272] = "2-Asset Front Right Txt Yolo";
        items[273] = "2-Asset Front Right Wave";
        items[274] = "2-Asset Front Right Wet Money";
        items[275] = "2-Asset Front Right Ying Yang";
        items[276] = "3-Asset Front Right 1n";
        items[277] = "3-Asset Front Right Aardvark";
        items[278] = "3-Asset Front Right Axe";
        items[279] = "3-Asset Front Right Belly Chamaleon";
        items[280] = "3-Asset Front Right Bird Flying";
        items[281] = "3-Asset Front Right Bird Side";
        items[282] = "3-Asset Front Right Bling Anchor";
        items[283] = "3-Asset Front Right Bling Anvil";
        items[284] = "3-Asset Front Right Bling Arrow";
        items[285] = "3-Asset Front Right Bling Cheese";
        items[286] = "3-Asset Front Right Bling Gold Ingot";
        items[287] = "3-Asset Front Right Bling Love";
        items[288] = "3-Asset Front Right Bling Mask";
        items[289] = "3-Asset Front Right Bling Rings";
        items[290] = "3-Asset Front Right Bling Sparkles";
        items[291] = "3-Asset Front Right Carrot";
        items[292] = "3-Asset Front Right Chain Logo";
        items[293] = "3-Asset Front Right Chicken";
        items[294] = "3-Asset Front Right Cloud";
        items[295] = "3-Asset Front Right Clover";
        items[296] = "3-Asset Front Right Cow";
        items[297] = "3-Asset Front Right Dinosaur";
        items[298] = "3-Asset Front Right Dollar Bling";
        items[299] = "3-Asset Front Right Doom";
        items[300] = "3-Asset Front Right Dragon";
        items[301] = "3-Asset Front Right Ducky";
        items[302] = "3-Asset Front Right Eth";
        items[303] = "3-Asset Front Right Eye";
        items[304] = "3-Asset Front Right Flash";
        items[305] = "3-Asset Front Right Foo Black";
        items[306] = "3-Asset Front Right Fries";
        items[307] = "3-Asset Front Right Glasses";
        items[308] = "3-Asset Front Right Glasses Logo";
        items[309] = "3-Asset Front Right Glasses Logo Sun";
        items[310] = "3-Asset Front Right Heart";
        items[311] = "3-Asset Front Right Hoodiestrings Uneven";
        items[312] = "3-Asset Front Right Id";
        items[313] = "3-Asset Front Right Infinity";
        items[314] = "3-Asset Front Right Insignia";
        items[315] = "3-Asset Front Right Leaf";
        items[316] = "3-Asset Front Right Left Arm Up Bege Bsod";
        items[317] = "3-Asset Front Right Left Arm Up Bigwalk Blue Prime";
        items[318] = "3-Asset Front Right Left Arm Up Bigwalk Grey Light";
        items[319] = "3-Asset Front Right Left Arm Up Bigwalk Rainbow";
        items[320] = "3-Asset Front Right Left Arm Up Checker Disco";
        items[321] = "3-Asset Front Right Left Arm Up Checker Rgb";
        items[322] = "3-Asset Front Right Left Arm Up Checker Spaced Black";
        items[323] = "3-Asset Front Right Left Arm Up Checker Spaced White";
        items[324] = "3-Asset Front Right Left Arm Up Checker Vibrant";
        items[325] = "3-Asset Front Right Left Arm Up Checkers Big Black";
        items[326] = "3-Asset Front Right Left Arm Up Checkers Big Green";
        items[327] = "3-Asset Front Right Left Arm Up Checkers Big Red Cold";
        items[328] = "3-Asset Front Right Left Arm Up Checkers Blue";
        items[329] = "3-Asset Front Right Left Arm Up Checkers Magenta";
        items[330] = "3-Asset Front Right Left Arm Up Collar Sunset";
        items[331] = "3-Asset Front Right Left Arm Up Decay Gray Dark";
        items[332] = "3-Asset Front Right Left Arm Up Decay Pride";
        items[333] = "3-Asset Front Right Left Arm Up Gradient Dawn";
        items[334] = "3-Asset Front Right Left Arm Up Gradient Dusk";
        items[335] = "3-Asset Front Right Left Arm Up Gradient Glacier";
        items[336] = "3-Asset Front Right Left Arm Up Gradient Ice";
        items[337] = "3-Asset Front Right Left Arm Up Gradient Pride";
        items[338] = "3-Asset Front Right Left Arm Up Gradient Redpink";
        items[339] = "3-Asset Front Right Left Arm Up Gradient Sunset";
        items[340] = "3-Asset Front Right Left Arm Up Gray Scale 1";
        items[341] = "3-Asset Front Right Left Arm Up Gray Scale 9";
        items[342] = "3-Asset Front Right Left Arm Up Grid Simple Bege";
        items[343] = "3-Asset Front Right Left Arm Up Ice Cold";
        items[344] = "3-Asset Front Right Left Arm Up Lines 45 Greens";
        items[345] = "3-Asset Front Right Left Arm Up Lines 45 Rose";
        items[346] = "3-Asset Front Right Left Arm Up Old Shirt";
        items[347] = "3-Asset Front Right Left Arm Up Rainbow Steps";
        items[348] = "3-Asset Front Right Left Arm Up Robot";
        items[349] = "3-Asset Front Right Left Arm Up Safety Vest";
        items[350] = "3-Asset Front Right Left Arm Up Scarf Clown";
        items[351] = "3-Asset Front Right Left Arm Up Shirt Black";
        items[352] = "3-Asset Front Right Left Arm Up Stripes And Checks";
        items[353] = "3-Asset Front Right Left Arm Up Stripes Big Red";
        items[354] = "3-Asset Front Right Left Arm Up Stripes Blit";
        items[355] = "3-Asset Front Right Left Arm Up Stripes Blue Med";
        items[356] = "3-Asset Front Right Left Arm Up Stripes Brown";
        items[357] = "3-Asset Front Right Left Arm Up Stripes Olive";
        items[358] = "3-Asset Front Right Left Arm Up Stripes Red Cold";
        items[359] = "3-Asset Front Right Left Arm Up Taxi Checkers";
        items[360] = "3-Asset Front Right Left Arm Up Tee Yo";
        items[361] = "3-Asset Front Right Left Arm Up Txt Ico";
        items[362] = "3-Asset Front Right Left Arm Up Wall";
        items[363] = "3-Asset Front Right Left Arm Up Woolweave Bicolor";
        items[364] = "3-Asset Front Right Left Arm Up Woolweave Dirt";
        items[365] = "3-Asset Front Right Light Bulb";
        items[366] = "3-Asset Front Right Lp";
        items[367] = "3-Asset Front Right Mars Face";
        items[368] = "3-Asset Front Right Matrix White";
        items[369] = "3-Asset Front Right Moon Block";
        items[370] = "3-Asset Front Right None";
        items[371] = "3-Asset Front Right Noun Txt Multicolor";
        items[372] = "3-Asset Front Right Pizza Bling";
        items[373] = "3-Asset Front Right Pocket Pencil";
        items[374] = "3-Asset Front Right Rain";
        items[375] = "3-Asset Front Right Rgb";
        items[376] = "3-Asset Front Right Scissors";
        items[377] = "3-Asset Front Right Secret X";
        items[378] = "3-Asset Front Right Shrimp";
        items[379] = "3-Asset Front Right Slime Splat";
        items[380] = "3-Asset Front Right Small Bling";
        items[381] = "3-Asset Front Right Snowflake";
        items[382] = "3-Asset Front Right Stains Blood";
        items[383] = "3-Asset Front Right Stains Zombie";
        items[384] = "3-Asset Front Right Sunset";
        items[385] = "3-Asset Front Right Think";
        items[386] = "3-Asset Front Right Tie Black On White";
        items[387] = "3-Asset Front Right Tie Dye";
        items[388] = "3-Asset Front Right Tie Purple";
        items[389] = "3-Asset Front Right Tie Red";
        items[390] = "3-Asset Front Right Txt A2+b2";
        items[391] = "3-Asset Front Right Txt Cc";
        items[392] = "3-Asset Front Right Txt Cc 2";
        items[393] = "3-Asset Front Right Txt Copy";
        items[394] = "3-Asset Front Right Txt Dao Black";
        items[395] = "3-Asset Front Right Txt Dope";
        items[396] = "3-Asset Front Right Txt Io";
        items[397] = "3-Asset Front Right Txt Lmao";
        items[398] = "3-Asset Front Right Txt Lol";
        items[399] = "3-Asset Front Right Txt Mint";
        items[400] = "3-Asset Front Right Txt Nil Grey Dark";
        items[401] = "3-Asset Front Right Txt Noun";
        items[402] = "3-Asset Front Right Txt Noun F0f";
        items[403] = "3-Asset Front Right Txt Noun Green";
        items[404] = "3-Asset Front Right Txt Pi";
        items[405] = "3-Asset Front Right Txt Pop";
        items[406] = "3-Asset Front Right Txt Rofl";
        items[407] = "3-Asset Front Right Txt We";
        items[408] = "3-Asset Front Right Txt Yay";
        items[409] = "3-Asset Front Right Txt Yolo";
        items[410] = "3-Asset Front Right Wave";
        items[411] = "3-Asset Front Right Wet Money";
        items[412] = "3-Asset Front Right Ying Yang";
        items[413] = "4-Asset Front Right 1n";
        items[414] = "4-Asset Front Right Aardvark";
        items[415] = "4-Asset Front Right Axe";
        items[416] = "4-Asset Front Right Belly Chamaleon";
        items[417] = "4-Asset Front Right Bird Flying";
        items[418] = "4-Asset Front Right Bird Side";
        items[419] = "4-Asset Front Right Bling Anchor";
        items[420] = "4-Asset Front Right Bling Anvil";
        items[421] = "4-Asset Front Right Bling Arrow";
        items[422] = "4-Asset Front Right Bling Cheese";
        items[423] = "4-Asset Front Right Bling Gold Ingot";
        items[424] = "4-Asset Front Right Bling Love";
        items[425] = "4-Asset Front Right Bling Mask";
        items[426] = "4-Asset Front Right Bling Rings";
        items[427] = "4-Asset Front Right Bling Sparkles";
        items[428] = "4-Asset Front Right Carrot";
        items[429] = "4-Asset Front Right Chain Logo";
        items[430] = "4-Asset Front Right Chicken";
        items[431] = "4-Asset Front Right Cloud";
        items[432] = "4-Asset Front Right Clover";
        items[433] = "4-Asset Front Right Cow";
        items[434] = "4-Asset Front Right Dinosaur";
        items[435] = "4-Asset Front Right Dollar Bling";
        items[436] = "4-Asset Front Right Doom";
        items[437] = "4-Asset Front Right Dragon";
        items[438] = "4-Asset Front Right Ducky";
        items[439] = "4-Asset Front Right Eth";
        items[440] = "4-Asset Front Right Eye";
        items[441] = "4-Asset Front Right Flash";
        items[442] = "4-Asset Front Right Foo Black";
        items[443] = "4-Asset Front Right Fries";
        items[444] = "4-Asset Front Right Glasses";
        items[445] = "4-Asset Front Right Glasses Logo";
        items[446] = "4-Asset Front Right Glasses Logo Sun";
        items[447] = "4-Asset Front Right Heart";
        items[448] = "4-Asset Front Right Hoodiestrings Uneven";
        items[449] = "4-Asset Front Right Id";
        items[450] = "4-Asset Front Right Infinity";
        items[451] = "4-Asset Front Right Insignia";
        items[452] = "4-Asset Front Right Leaf";
        items[453] = "4-Asset Front Right Light Bulb";
        items[454] = "4-Asset Front Right Lp";
        items[455] = "4-Asset Front Right Mars Face";
        items[456] = "4-Asset Front Right Matrix White";
        items[457] = "4-Asset Front Right Moon Block";
        items[458] = "4-Asset Front Right None";
        items[459] = "4-Asset Front Right Noun Txt Multicolor";
        items[460] = "4-Asset Front Right Pizza Bling";
        items[461] = "4-Asset Front Right Pocket Pencil";
        items[462] = "4-Asset Front Right Rain";
        items[463] = "4-Asset Front Right Rgb";
        items[464] = "4-Asset Front Right Right Arm Up Bege Bsod";
        items[465] = "4-Asset Front Right Right Arm Up Bigwalk Blue Prime";
        items[466] = "4-Asset Front Right Right Arm Up Bigwalk Grey Light";
        items[467] = "4-Asset Front Right Right Arm Up Bigwalk Rainbow";
        items[468] = "4-Asset Front Right Right Arm Up Checker Disco";
        items[469] = "4-Asset Front Right Right Arm Up Checker Rgb";
        items[470] = "4-Asset Front Right Right Arm Up Checker Spaced Black";
        items[471] = "4-Asset Front Right Right Arm Up Checker Spaced White";
        items[472] = "4-Asset Front Right Right Arm Up Checker Vibrant";
        items[473] = "4-Asset Front Right Right Arm Up Checkers Big Green";
        items[474] = "4-Asset Front Right Right Arm Up Checkers Big Red Cold";
        items[475] = "4-Asset Front Right Right Arm Up Checkers Black";
        items[476] = "4-Asset Front Right Right Arm Up Checkers Blue";
        items[477] = "4-Asset Front Right Right Arm Up Checkers Magenta";
        items[478] = "4-Asset Front Right Right Arm Up Collar Sunset";
        items[479] = "4-Asset Front Right Right Arm Up Decay Gray Dark";
        items[480] = "4-Asset Front Right Right Arm Up Decay Pride";
        items[481] = "4-Asset Front Right Right Arm Up Gradient Dawn";
        items[482] = "4-Asset Front Right Right Arm Up Gradient Dusk";
        items[483] = "4-Asset Front Right Right Arm Up Gradient Glacier";
        items[484] = "4-Asset Front Right Right Arm Up Gradient Ice";
        items[485] = "4-Asset Front Right Right Arm Up Gradient Pride";
        items[486] = "4-Asset Front Right Right Arm Up Gradient Redpink";
        items[487] = "4-Asset Front Right Right Arm Up Gradient Sunset";
        items[488] = "4-Asset Front Right Right Arm Up Gray Scale 1";
        items[489] = "4-Asset Front Right Right Arm Up Gray Scale 9";
        items[490] = "4-Asset Front Right Right Arm Up Grid Simple Bege";
        items[491] = "4-Asset Front Right Right Arm Up Ice Cold";
        items[492] = "4-Asset Front Right Right Arm Up Lines 45 Greens";
        items[493] = "4-Asset Front Right Right Arm Up Lines 45 Rose";
        items[494] = "4-Asset Front Right Right Arm Up Old Shirt";
        items[495] = "4-Asset Front Right Right Arm Up Rainbow Steps";
        items[496] = "4-Asset Front Right Right Arm Up Robot";
        items[497] = "4-Asset Front Right Right Arm Up Safety Vest";
        items[498] = "4-Asset Front Right Right Arm Up Scarf Clown";
        items[499] = "4-Asset Front Right Right Arm Up Shirt Black";
        items[500] = "4-Asset Front Right Right Arm Up Stripes And Checks";
        items[501] = "4-Asset Front Right Right Arm Up Stripes Big Red";
        items[502] = "4-Asset Front Right Right Arm Up Stripes Blit";
        items[503] = "4-Asset Front Right Right Arm Up Stripes Blue Med";
        items[504] = "4-Asset Front Right Right Arm Up Stripes Brown";
        items[505] = "4-Asset Front Right Right Arm Up Stripes Olive";
        items[506] = "4-Asset Front Right Right Arm Up Stripes Red Cold";
        items[507] = "4-Asset Front Right Right Arm Up Taxi Checkers";
        items[508] = "4-Asset Front Right Right Arm Up Tee Yo";
        items[509] = "4-Asset Front Right Right Arm Up Txt Ico";
        items[510] = "4-Asset Front Right Right Arm Up Wall";
        items[511] = "4-Asset Front Right Right Arm Up Woolweave Bicolor";
        items[512] = "4-Asset Front Right Right Arm Up Woolweave Dirt";
        items[513] = "4-Asset Front Right Scissors";
        items[514] = "4-Asset Front Right Secret X";
        items[515] = "4-Asset Front Right Shrimp";
        items[516] = "4-Asset Front Right Slime Splat";
        items[517] = "4-Asset Front Right Small Bling";
        items[518] = "4-Asset Front Right Snowflake";
        items[519] = "4-Asset Front Right Stains Blood";
        items[520] = "4-Asset Front Right Stains Zombie";
        items[521] = "4-Asset Front Right Sunset";
        items[522] = "4-Asset Front Right Think";
        items[523] = "4-Asset Front Right Tie Black On White";
        items[524] = "4-Asset Front Right Tie Dye";
        items[525] = "4-Asset Front Right Tie Purple";
        items[526] = "4-Asset Front Right Tie Red";
        items[527] = "4-Asset Front Right Txt A2+b2";
        items[528] = "4-Asset Front Right Txt Cc";
        items[529] = "4-Asset Front Right Txt Cc 2";
        items[530] = "4-Asset Front Right Txt Copy";
        items[531] = "4-Asset Front Right Txt Dao Black";
        items[532] = "4-Asset Front Right Txt Dope";
        items[533] = "4-Asset Front Right Txt Io";
        items[534] = "4-Asset Front Right Txt Lmao";
        items[535] = "4-Asset Front Right Txt Lol";
        items[536] = "4-Asset Front Right Txt Mint";
        items[537] = "4-Asset Front Right Txt Nil Grey Dark";
        items[538] = "4-Asset Front Right Txt Noun";
        items[539] = "4-Asset Front Right Txt Noun F0f";
        items[540] = "4-Asset Front Right Txt Noun Green";
        items[541] = "4-Asset Front Right Txt Pi";
        items[542] = "4-Asset Front Right Txt Pop";
        items[543] = "4-Asset Front Right Txt Rofl";
        items[544] = "4-Asset Front Right Txt We";
        items[545] = "4-Asset Front Right Txt Yay";
        items[546] = "4-Asset Front Right Txt Yolo";
        items[547] = "4-Asset Front Right Wave";
        items[548] = "4-Asset Front Right Wet Money";
        items[549] = "4-Asset Front Right Ying Yang";

        bytes memory data = abi.encode(items);

        VmSafe vm = VmSafe(
            address(uint160(uint256(keccak256("hevm cheat code"))))
        );

        string[] memory inputs = new string[](3);
        inputs[0] = "node";
        inputs[1] = "script/nouns-coasters/deflate.js";
        inputs[2] = vm.toString(data);

        bytes memory compressedData = vm.ffi(inputs);

        // address result = SSTORE2.write(compressedData);

        renderer.addLayer({
            target: target,
            ipfs: INounsCoasterMetadataRendererTypes.IPFSGroup({
                baseUri: "ipfs://bafybeiag26lh2at7iah5xqlrzgj2ei2jd2qel3g5bpccgfj5ktjbvu4qm4/",
                extension: ".png"
            }),
            decompressedSize: data.length,
            compressedData: compressedData,
            count: items.length,
            property: "21 Accessories front right",
            variantProperty: variantPropertyParameters
        });
    }

    function addLayer22(NounsCoasterMetadataRenderer renderer, address target)
        internal
    {
        // 22 Head front right
        INounsCoasterMetadataRendererTypes.VariantPropertyParameters
            memory variantPropertyParameters;
        variantPropertyParameters
            .offsets = new INounsCoasterMetadataRendererTypes.VariantOffset[](
            0
        );
        variantPropertyParameters.id = 0;
        variantPropertyParameters.count = 0;

        string[] memory items = new string[](940);
        items[0] = "Aardvark Bored";
        items[1] = "Aardvark Happy";
        items[2] = "Aardvark Scared";
        items[3] = "Aardvark Sick";
        items[4] = "Abstract Bored";
        items[5] = "Abstract Happy";
        items[6] = "Abstract Scared";
        items[7] = "Abstract Sick";
        items[8] = "Ape Bored";
        items[9] = "Ape Happy";
        items[10] = "Ape Scared";
        items[11] = "Ape Sick";
        items[12] = "Bag Bored";
        items[13] = "Bag Happy";
        items[14] = "Bag Scared";
        items[15] = "Bag Sick";
        items[16] = "Bagpipe Bored";
        items[17] = "Bagpipe Happy";
        items[18] = "Bagpipe Scared";
        items[19] = "Bagpipe Sick";
        items[20] = "Banana Bored";
        items[21] = "Banana Happy";
        items[22] = "Banana Scared";
        items[23] = "Banana Sick";
        items[24] = "Bank Bored";
        items[25] = "Bank Happy";
        items[26] = "Bank Scared";
        items[27] = "Bank Sick";
        items[28] = "Baseball Gameball Bored";
        items[29] = "Baseball Gameball Happy";
        items[30] = "Baseball Gameball Scared";
        items[31] = "Baseball Gameball Sick";
        items[32] = "Bat Bored";
        items[33] = "Bat Happy";
        items[34] = "Bat Scared";
        items[35] = "Bat Sick";
        items[36] = "Bear Bored";
        items[37] = "Bear Happy";
        items[38] = "Bear Scared";
        items[39] = "Bear Sick";
        items[40] = "Beer Bored";
        items[41] = "Beer Happy";
        items[42] = "Beer Scared";
        items[43] = "Beer Sick";
        items[44] = "Beet Bored";
        items[45] = "Beet Happy";
        items[46] = "Beet Scared";
        items[47] = "Beet Sick";
        items[48] = "Bell Bored";
        items[49] = "Bell Happy";
        items[50] = "Bell Scared";
        items[51] = "Bell Sick";
        items[52] = "Bigfoot Bored";
        items[53] = "Bigfoot Happy";
        items[54] = "Bigfoot Scared";
        items[55] = "Bigfoot Sick";
        items[56] = "Bigfoot Yeti Bored";
        items[57] = "Bigfoot Yeti Happy";
        items[58] = "Bigfoot Yeti Scared";
        items[59] = "Bigfoot Yeti Sick";
        items[60] = "Blackhole Bored";
        items[61] = "Blackhole Happy";
        items[62] = "Blackhole Scared";
        items[63] = "Blackhole Sick";
        items[64] = "Blueberry Happy";
        items[65] = "Blueberry Scared";
        items[66] = "Blueberry Sick";
        items[67] = "Blueblerry Bored";
        items[68] = "Bomb Bored";
        items[69] = "Bomb Happy";
        items[70] = "Bomb Scared";
        items[71] = "Bomb Sick";
        items[72] = "Bonsai Bored";
        items[73] = "Bonsai Happy";
        items[74] = "Bonsai Scared";
        items[75] = "Bonsai Sick";
        items[76] = "Boombox Bored";
        items[77] = "Boombox Happy";
        items[78] = "Boombox Scared";
        items[79] = "Boombox Sick";
        items[80] = "Boot Bored";
        items[81] = "Boot Happy";
        items[82] = "Boot Scared";
        items[83] = "Boot Sick";
        items[84] = "Box Bored";
        items[85] = "Box Happy";
        items[86] = "Box Scared";
        items[87] = "Box Sick";
        items[88] = "Boxingglove Bored";
        items[89] = "Boxingglove Happy";
        items[90] = "Boxingglove Scared";
        items[91] = "Boxingglove Sick";
        items[92] = "Brain Bored";
        items[93] = "Brain Happy";
        items[94] = "Brain Scared";
        items[95] = "Brain Sick";
        items[96] = "Bubble Speech Bored";
        items[97] = "Bubble Speech Happy";
        items[98] = "Bubble Speech Scared";
        items[99] = "Bubble Speech Sick";
        items[100] = "Bubblegum Bored";
        items[101] = "Bubblegum Happy";
        items[102] = "Bubblegum Scared";
        items[103] = "Bubblegum Sick";
        items[104] = "Burger Dollarmenu Bored";
        items[105] = "Burger Dollarmenu Happy";
        items[106] = "Burger Dollarmenu Scared";
        items[107] = "Burger Dollarmenu Sick";
        items[108] = "Cake Bored";
        items[109] = "Cake Happy";
        items[110] = "Cake Scared";
        items[111] = "Cake Sick";
        items[112] = "Calculator Bored";
        items[113] = "Calculator Happy";
        items[114] = "Calculator Scared";
        items[115] = "Calculator Sick";
        items[116] = "Calendar Bored";
        items[117] = "Calendar Happy";
        items[118] = "Calendar Scared";
        items[119] = "Calendar Sick";
        items[120] = "Camcorder Bored";
        items[121] = "Camcorder Happy";
        items[122] = "Camcorder Scared";
        items[123] = "Camcorder Sick";
        items[124] = "Candy Bar Bored";
        items[125] = "Candy Bar Happy";
        items[126] = "Candy Bar Scared";
        items[127] = "Candy Bar Sick";
        items[128] = "Cannedham Bored";
        items[129] = "Cannedham Happy";
        items[130] = "Cannedham Scared";
        items[131] = "Cannedham Sick";
        items[132] = "Car Bored";
        items[133] = "Car Happy";
        items[134] = "Car Scared";
        items[135] = "Car Sick";
        items[136] = "Cash Register Bored";
        items[137] = "Cash Register Happy";
        items[138] = "Cash Register Scared";
        items[139] = "Cash Register Sick";
        items[140] = "Cassettetape Bored";
        items[141] = "Cassettetape Happy";
        items[142] = "Cassettetape Scared";
        items[143] = "Cassettetape Sick";
        items[144] = "Cat Bored";
        items[145] = "Cat Happy";
        items[146] = "Cat Scared";
        items[147] = "Cat Sick";
        items[148] = "Cd Bored";
        items[149] = "Cd Happy";
        items[150] = "Cd Scared";
        items[151] = "Cd Sick";
        items[152] = "Chain Bored";
        items[153] = "Chain Happy";
        items[154] = "Chain Scared";
        items[155] = "Chain Sick";
        items[156] = "Chainsaw Bored";
        items[157] = "Chainsaw Happy";
        items[158] = "Chainsaw Scared";
        items[159] = "Chainsaw Sick";
        items[160] = "Chameleon Bored";
        items[161] = "Chameleon Happy";
        items[162] = "Chameleon Scared";
        items[163] = "Chameleon Sick";
        items[164] = "Chart Bars Bored";
        items[165] = "Chart Bars Happy";
        items[166] = "Chart Bars Scared";
        items[167] = "Chart Bars Sick";
        items[168] = "Cheese Bored";
        items[169] = "Cheese Happy";
        items[170] = "Cheese Scared";
        items[171] = "Cheese Sick";
        items[172] = "Chefhat Bored";
        items[173] = "Chefhat Happy";
        items[174] = "Chefhat Scared";
        items[175] = "Chefhat Sick";
        items[176] = "Cherry Bored";
        items[177] = "Cherry Happy";
        items[178] = "Cherry Scared";
        items[179] = "Cherry Sick";
        items[180] = "Chicken Bored";
        items[181] = "Chicken Happy";
        items[182] = "Chicken Scared";
        items[183] = "Chicken Sick";
        items[184] = "Chipboard Bored";
        items[185] = "Chipboard Happy";
        items[186] = "Chipboard Scared";
        items[187] = "Chipboard Sick";
        items[188] = "Chips Bored";
        items[189] = "Chips Happy";
        items[190] = "Chips Scared";
        items[191] = "Chips Sick";
        items[192] = "Cloud Bored";
        items[193] = "Cloud Happy";
        items[194] = "Cloud Scared";
        items[195] = "Cloud Sick";
        items[196] = "Clover Bored";
        items[197] = "Clover Happy";
        items[198] = "Clover Scared";
        items[199] = "Clover Sick";
        items[200] = "Clutch Bored";
        items[201] = "Clutch Happy";
        items[202] = "Clutch Scared";
        items[203] = "Clutch Sick";
        items[204] = "Coffeebean Bored";
        items[205] = "Coffeebean Happy";
        items[206] = "Coffeebean Scared";
        items[207] = "Coffeebean Sick";
        items[208] = "Cone Bored";
        items[209] = "Cone Happy";
        items[210] = "Cone Scared";
        items[211] = "Cone Sick";
        items[212] = "Console Handheld Bored";
        items[213] = "Console Handheld Happy";
        items[214] = "Console Handheld Scared";
        items[215] = "Console Handheld Sick";
        items[216] = "Cookie Bored";
        items[217] = "Cookie Happy";
        items[218] = "Cookie Scared";
        items[219] = "Cookie Sick";
        items[220] = "Cordlessphone Bored";
        items[221] = "Cordlessphone Happy";
        items[222] = "Cordlessphone Scared";
        items[223] = "Cordlessphone Sick";
        items[224] = "Cottonball Bored";
        items[225] = "Cottonball Happy";
        items[226] = "Cottonball Scared";
        items[227] = "Cottonball Sick";
        items[228] = "Couch Bored";
        items[229] = "Couch Happy";
        items[230] = "Couch Scared";
        items[231] = "Couch Sick";
        items[232] = "Cow Bored";
        items[233] = "Cow Happy";
        items[234] = "Cow Scared";
        items[235] = "Cow Sick";
        items[236] = "Crab Bored";
        items[237] = "Crab Happy";
        items[238] = "Crab Scared";
        items[239] = "Crab Sick";
        items[240] = "Crane Bored";
        items[241] = "Crane Happy";
        items[242] = "Crane Scared";
        items[243] = "Crane Sick";
        items[244] = "Croc Hat Bored";
        items[245] = "Croc Hat Happy";
        items[246] = "Croc Hat Scared";
        items[247] = "Croc Hat Sick";
        items[248] = "Crown Bored";
        items[249] = "Crown Happy";
        items[250] = "Crown Scared";
        items[251] = "Crown Sick";
        items[252] = "Crt Bsod Bored";
        items[253] = "Crt Bsod Happy";
        items[254] = "Crt Bsod Scared";
        items[255] = "Crt Bsod Sick";
        items[256] = "Crystallball Bored";
        items[257] = "Crystallball Happy";
        items[258] = "Crystallball Scared";
        items[259] = "Crystallball Sick";
        items[260] = "Diamond Blue Bored";
        items[261] = "Diamond Blue Happy";
        items[262] = "Diamond Blue Scared";
        items[263] = "Diamond Blue Sick";
        items[264] = "Diamond Red Bored";
        items[265] = "Diamond Red Happy";
        items[266] = "Diamond Red Scared";
        items[267] = "Diamond Red Sick";
        items[268] = "Dictionary Bored";
        items[269] = "Dictionary Happy";
        items[270] = "Dictionary Scared";
        items[271] = "Dictionary Sick";
        items[272] = "Dino Bored";
        items[273] = "Dino Happy";
        items[274] = "Dino Scared";
        items[275] = "Dino Sick";
        items[276] = "Dna Bored";
        items[277] = "Dna Happy";
        items[278] = "Dna Scared";
        items[279] = "Dna Sick";
        items[280] = "Dog Bored";
        items[281] = "Dog Happy";
        items[282] = "Dog Scared";
        items[283] = "Dog Sick";
        items[284] = "Doughnut Bored";
        items[285] = "Doughnut Happy";
        items[286] = "Doughnut Scared";
        items[287] = "Doughtnut Sick";
        items[288] = "Drill Bored";
        items[289] = "Drill Happy";
        items[290] = "Drill Scared";
        items[291] = "Drill Sick";
        items[292] = "Duck Bored";
        items[293] = "Duck Happy";
        items[294] = "Duck Scared";
        items[295] = "Duck Sick";
        items[296] = "Ducky Bored";
        items[297] = "Ducky Happy";
        items[298] = "Ducky Scared";
        items[299] = "Ducky Sick";
        items[300] = "Earth Bored";
        items[301] = "Earth Happy";
        items[302] = "Earth Scared";
        items[303] = "Earth Sick";
        items[304] = "Egg Bored";
        items[305] = "Egg Happy";
        items[306] = "Egg Scared";
        items[307] = "Egg Sick";
        items[308] = "Faberge Bored";
        items[309] = "Faberge Happy";
        items[310] = "Faberge Scared";
        items[311] = "Faberge Sick";
        items[312] = "Factory Dark Bored";
        items[313] = "Factory Dark Happy";
        items[314] = "Factory Dark Scared";
        items[315] = "Factory Dark Sick";
        items[316] = "Fan Bored";
        items[317] = "Fan Happy";
        items[318] = "Fan Scared";
        items[319] = "Fan Sick";
        items[320] = "Fence Bored";
        items[321] = "Fence Happy";
        items[322] = "Fence Scared";
        items[323] = "Fence Sick";
        items[324] = "Film 35mm Bored";
        items[325] = "Film 35mm Happy";
        items[326] = "Film 35mm Scared";
        items[327] = "Film 35mm Sick";
        items[328] = "Film Strip Bored";
        items[329] = "Film Strip Happy";
        items[330] = "Film Strip Scared";
        items[331] = "Film Strip Sick";
        items[332] = "Fir Bored";
        items[333] = "Fir Happy";
        items[334] = "Fir Scared";
        items[335] = "Fir Sick";
        items[336] = "Firehydrant Bored";
        items[337] = "Firehydrant Happy";
        items[338] = "Firehydrant Scared";
        items[339] = "Firehydrant Sick";
        items[340] = "Flamingo Bored";
        items[341] = "Flamingo Happy";
        items[342] = "Flamingo Scared";
        items[343] = "Flamingo Sick";
        items[344] = "Flower Bored";
        items[345] = "Flower Happy";
        items[346] = "Flower Scared";
        items[347] = "Flower Sick";
        items[348] = "Fox Bored";
        items[349] = "Fox Happy";
        items[350] = "Fox Scared";
        items[351] = "Fox Sick";
        items[352] = "Frog Bored";
        items[353] = "Frog Happy";
        items[354] = "Frog Scared";
        items[355] = "Frog Sick";
        items[356] = "Garlic Bored";
        items[357] = "Garlic Happy";
        items[358] = "Garlic Scared";
        items[359] = "Garlic Sick";
        items[360] = "Gavel Bored";
        items[361] = "Gavel Happy";
        items[362] = "Gavel Scared";
        items[363] = "Gavel Sick";
        items[364] = "Ghost B Bored";
        items[365] = "Ghost B Happy";
        items[366] = "Ghost B Scared";
        items[367] = "Ghost B Sick";
        items[368] = "Glasses Big Bored";
        items[369] = "Glasses Big Happy";
        items[370] = "Glasses Big Scared";
        items[371] = "Glasses Big Sick";
        items[372] = "Gnomes Bored";
        items[373] = "Gnomes Happy";
        items[374] = "Gnomes Scared";
        items[375] = "Gnomes Sick";
        items[376] = "Goat Bored";
        items[377] = "Goat Happy";
        items[378] = "Goat Scared";
        items[379] = "Goat Sick";
        items[380] = "Goldcoin Bored";
        items[381] = "Goldcoin Happy";
        items[382] = "Goldcoin Scared";
        items[383] = "Goldcoin Sick";
        items[384] = "Goldfish Bored";
        items[385] = "Goldfish Happy";
        items[386] = "Goldfish Scared";
        items[387] = "Goldfish Sick";
        items[388] = "Grouper Bored";
        items[389] = "Grouper Happy";
        items[390] = "Grouper Scared";
        items[391] = "Grouper Sick";
        items[392] = "Hair Bored";
        items[393] = "Hair Happy";
        items[394] = "Hair Scared";
        items[395] = "Hair Sick";
        items[396] = "Hanger Bored";
        items[397] = "Hanger Happy";
        items[398] = "Hanger Scared";
        items[399] = "Hanger Sick";
        items[400] = "Hardhat Bored";
        items[401] = "Hardhat Happy";
        items[402] = "Hardhat Scared";
        items[403] = "Hardhat Sick";
        items[404] = "Heart Bored";
        items[405] = "Heart Happy";
        items[406] = "Heart Scared";
        items[407] = "Heart Sick";
        items[408] = "Helicopter Bored";
        items[409] = "Helicopter Happy";
        items[410] = "Helicopter Scared";
        items[411] = "Helicopter Sick";
        items[412] = "Highheel Bored";
        items[413] = "Highheel Happy";
        items[414] = "Highheel Scared";
        items[415] = "Highheel Sick";
        items[416] = "Hockeypuck Bored";
        items[417] = "Hockeypuck Happy";
        items[418] = "Hockeypuck Scared";
        items[419] = "Hockeypuck Sick";
        items[420] = "Horse Deepfried Bored";
        items[421] = "Horse Deepfried Happy";
        items[422] = "Horse Deepfried Scared";
        items[423] = "Horse Deepfried Sick";
        items[424] = "Hotdog Bored";
        items[425] = "Hotdog Happy";
        items[426] = "Hotdog Scared";
        items[427] = "Hotdog Sick";
        items[428] = "House Bored";
        items[429] = "House Happy";
        items[430] = "House Scared";
        items[431] = "House Sick";
        items[432] = "Icepop B Bored";
        items[433] = "Icepop B Happy";
        items[434] = "Icepop B Scared";
        items[435] = "Icepop B Sick";
        items[436] = "Igloo Bored";
        items[437] = "Igloo Happy";
        items[438] = "Igloo Scared";
        items[439] = "Igloo Sick";
        items[440] = "Island Bored";
        items[441] = "Island Happy";
        items[442] = "Island Scared";
        items[443] = "Island Sick";
        items[444] = "Jellyfish Bored";
        items[445] = "Jellyfish Happy";
        items[446] = "Jellyfish Scared";
        items[447] = "Jellyfish Sick";
        items[448] = "Jupiter Bored";
        items[449] = "Jupiter Happy";
        items[450] = "Jupiter Scared";
        items[451] = "Jupiter Sick";
        items[452] = "Kangaroo Bored";
        items[453] = "Kangaroo Happy";
        items[454] = "Kangaroo Scared";
        items[455] = "Kangaroo Sick";
        items[456] = "Ketchup Bored";
        items[457] = "Ketchup Happy";
        items[458] = "Ketchup Scared";
        items[459] = "Ketchup Sick";
        items[460] = "Laptop Bored";
        items[461] = "Laptop Happy";
        items[462] = "Laptop Scared";
        items[463] = "Laptop Sick";
        items[464] = "Lightning Bolt Bored";
        items[465] = "Lightning Bolt Happy";
        items[466] = "Lightning Bolt Scared";
        items[467] = "Lightning Bolt Sick";
        items[468] = "Lint Bored";
        items[469] = "Lint Happy";
        items[470] = "Lint Scared";
        items[471] = "Lint Sick";
        items[472] = "Lips Bored";
        items[473] = "Lips Happy";
        items[474] = "Lips Scared";
        items[475] = "Lips Sick";
        items[476] = "Lipstick2 Bored";
        items[477] = "Lipstick2 Happy";
        items[478] = "Lipstick2 Scared";
        items[479] = "Lipstick2 Sick";
        items[480] = "Lock Bored";
        items[481] = "Lock Happy";
        items[482] = "Lock Scared";
        items[483] = "Lock Sick";
        items[484] = "Macaroni Bored";
        items[485] = "Macaroni Happy";
        items[486] = "Macaroni Scared";
        items[487] = "Macaroni Sick";
        items[488] = "Mailbox Bored";
        items[489] = "Mailbox Happy";
        items[490] = "Mailbox Scared";
        items[491] = "Mailbox Sick";
        items[492] = "Maze Bored";
        items[493] = "Maze Happy";
        items[494] = "Maze Scared";
        items[495] = "Maze Sick";
        items[496] = "Microwave Bored";
        items[497] = "Microwave Happy";
        items[498] = "Microwave Scared";
        items[499] = "Microwave Sick";
        items[500] = "Milk Bored";
        items[501] = "Milk Happy";
        items[502] = "Milk Scared";
        items[503] = "Milk Sick";
        items[504] = "Mirror Bored";
        items[505] = "Mirror Happy";
        items[506] = "Mirror Scared";
        items[507] = "Mirror Sick";
        items[508] = "Mixer Bored";
        items[509] = "Mixer Happy";
        items[510] = "Mixer Scared";
        items[511] = "Mixer Sick";
        items[512] = "Moon Bored";
        items[513] = "Moon Happy";
        items[514] = "Moon Scared";
        items[515] = "Moon Sick";
        items[516] = "Moose Bored";
        items[517] = "Moose Happy";
        items[518] = "Moose Scared";
        items[519] = "Moose Sick";
        items[520] = "Mosquito Bored";
        items[521] = "Mosquito Happy";
        items[522] = "Mosquito Scared";
        items[523] = "Mosquito Sick";
        items[524] = "Mountain Snowcap Bored";
        items[525] = "Mountain Snowcap Happy";
        items[526] = "Mountain Snowcap Scared";
        items[527] = "Mountain Snowcap Sick";
        items[528] = "Mouse Bored";
        items[529] = "Mouse Happy";
        items[530] = "Mouse Scared";
        items[531] = "Mouse Sick";
        items[532] = "Mug Bored";
        items[533] = "Mug Happy";
        items[534] = "Mug Scared";
        items[535] = "Mug Sick";
        items[536] = "Mushroom Bored";
        items[537] = "Mushroom Happy";
        items[538] = "Mushroom Scared";
        items[539] = "Mushroom Sick";
        items[540] = "Mustard Bored";
        items[541] = "Mustard Happy";
        items[542] = "Mustard Scared";
        items[543] = "Mustard Sick";
        items[544] = "Nigiri Bored";
        items[545] = "Nigiri Happy";
        items[546] = "Nigiri Scared";
        items[547] = "Nigiri Sick";
        items[548] = "Noodles Bored";
        items[549] = "Noodles Happy";
        items[550] = "Noodles Scared";
        items[551] = "Noodles Sick";
        items[552] = "Onion Bored";
        items[553] = "Onion Happy";
        items[554] = "Onion Scared";
        items[555] = "Onion Sick";
        items[556] = "Orangutan Bored";
        items[557] = "Orangutan Happy";
        items[558] = "Orangutan Scared";
        items[559] = "Orangutan Sick";
        items[560] = "Orca Bored";
        items[561] = "Orca Happy";
        items[562] = "Orca Scared";
        items[563] = "Orca Sick";
        items[564] = "Otter Bored";
        items[565] = "Otter Happy";
        items[566] = "Otter Scared";
        items[567] = "Otter Sick";
        items[568] = "Outlet Bored";
        items[569] = "Outlet Happy";
        items[570] = "Outlet Scared";
        items[571] = "Outlet Sick";
        items[572] = "Owl Bored";
        items[573] = "Owl Happy";
        items[574] = "Owl Scared";
        items[575] = "Owl Sick";
        items[576] = "Oyster Bored";
        items[577] = "Oyster Happy";
        items[578] = "Oyster Scared";
        items[579] = "Oyster Sick";
        items[580] = "Paintbrush Bored";
        items[581] = "Paintbrush Happy";
        items[582] = "Paintbrush Scared";
        items[583] = "Paintbrush Sick";
        items[584] = "Panda Bored";
        items[585] = "Panda Happy";
        items[586] = "Panda Scared";
        items[587] = "Panda Sick";
        items[588] = "Paperclip Bored";
        items[589] = "Paperclip Happy";
        items[590] = "Paperclip Scared";
        items[591] = "Paperclip Sick";
        items[592] = "Peanut Bored";
        items[593] = "Peanut Happy";
        items[594] = "Peanut Scared";
        items[595] = "Peanut Sick";
        items[596] = "Pencil Tip Bored";
        items[597] = "Pencil Tip Happy";
        items[598] = "Pencil Tip Scared";
        items[599] = "Pencil Tip Sick";
        items[600] = "Peyote Bored";
        items[601] = "Peyote Happy";
        items[602] = "Peyote Scared";
        items[603] = "Peyote Sick";
        items[604] = "Piano Bored";
        items[605] = "Piano Happy";
        items[606] = "Piano Scared";
        items[607] = "Piano Sick";
        items[608] = "Pickle Bored";
        items[609] = "Pickle Happy";
        items[610] = "Pickle Scared";
        items[611] = "Pickle Sick";
        items[612] = "Pie Bored";
        items[613] = "Pie Happy";
        items[614] = "Pie Scared";
        items[615] = "Pie Sick";
        items[616] = "Piggybank Bored";
        items[617] = "Piggybank Happy";
        items[618] = "Piggybank Scared";
        items[619] = "Piggybank Sick";
        items[620] = "Pill Bored";
        items[621] = "Pill Happy";
        items[622] = "Pill Scared";
        items[623] = "Pill Sick";
        items[624] = "Pillow Bored";
        items[625] = "Pillow Happy";
        items[626] = "Pillow Scared";
        items[627] = "Pillow Sick";
        items[628] = "Pineapple Bored";
        items[629] = "Pineapple Happy";
        items[630] = "Pineapple Scared";
        items[631] = "Pineapple Sick";
        items[632] = "Pipe Bored";
        items[633] = "Pipe Happy";
        items[634] = "Pipe Scared";
        items[635] = "Pipe Sick";
        items[636] = "Pirateship Bored";
        items[637] = "Pirateship Happy";
        items[638] = "Pirateship Scared";
        items[639] = "Pirateship Sick";
        items[640] = "Pizza Bored";
        items[641] = "Pizza Happy";
        items[642] = "Pizza Scared";
        items[643] = "Pizza Sick";
        items[644] = "Plane Bored";
        items[645] = "Plane Happy";
        items[646] = "Plane Scared";
        items[647] = "Plane Sick";
        items[648] = "Pop Bored";
        items[649] = "Pop Happy";
        items[650] = "Pop Scared";
        items[651] = "Pop Sick";
        items[652] = "Porkbao Bored";
        items[653] = "Porkbao Happy";
        items[654] = "Porkbao Scared";
        items[655] = "Porkbao Sick";
        items[656] = "Pufferfish Bored";
        items[657] = "Pufferfish Happy";
        items[658] = "Pufferfish Scared";
        items[659] = "Pufferfish Sick";
        items[660] = "Pumpkin Bored";
        items[661] = "Pumpkin Happy";
        items[662] = "Pumpkin Scared";
        items[663] = "Pumpkin Sick";
        items[664] = "Pyramid Bored";
        items[665] = "Pyramid Happy";
        items[666] = "Pyramid Scared";
        items[667] = "Pyramid Sick";
        items[668] = "Queencrown Bored";
        items[669] = "Queencrown Happy";
        items[670] = "Queencrown Scared";
        items[671] = "Queencrown Sick";
        items[672] = "Rabbit Bored";
        items[673] = "Rabbit Happy";
        items[674] = "Rabbit Scared";
        items[675] = "Rabbit Sick";
        items[676] = "Rainbow Bored";
        items[677] = "Rainbow Happy";
        items[678] = "Rainbow Scared";
        items[679] = "Rainbow Sick";
        items[680] = "Rangefinder Bored";
        items[681] = "Rangefinder Happy";
        items[682] = "Rangefinder Scared";
        items[683] = "Rangefinder Sick";
        items[684] = "Raven Bored";
        items[685] = "Raven Happy";
        items[686] = "Raven Scared";
        items[687] = "Raven Sick";
        items[688] = "Retainer Bored";
        items[689] = "Retainer Happy";
        items[690] = "Retainer Scared";
        items[691] = "Retainer Sick";
        items[692] = "Rgb Bored";
        items[693] = "Rgb Happy";
        items[694] = "Rgb Scared";
        items[695] = "Rgb Sick";
        items[696] = "Ring Bored";
        items[697] = "Ring Happy";
        items[698] = "Ring Scared";
        items[699] = "Ring Sick";
        items[700] = "Road Bored";
        items[701] = "Road Happy";
        items[702] = "Road Scared";
        items[703] = "Road Sick";
        items[704] = "Robot Bored";
        items[705] = "Robot Happy";
        items[706] = "Robot Scared";
        items[707] = "Robot Sick";
        items[708] = "Rock Bored";
        items[709] = "Rock Happy";
        items[710] = "Rock Scared";
        items[711] = "Rock Sick";
        items[712] = "Rosebud Bored";
        items[713] = "Rosebud Happy";
        items[714] = "Rosebud Scared";
        items[715] = "Rosebud Sick";
        items[716] = "Ruler Triangular Bored";
        items[717] = "Ruler Triangular Happy";
        items[718] = "Ruler Triangular Scared";
        items[719] = "Ruler Triangular Sick";
        items[720] = "Safe Bored";
        items[721] = "Safe Happy";
        items[722] = "Safe Scared";
        items[723] = "Safe Sick";
        items[724] = "Saguaro Bored";
        items[725] = "Saguaro Happy";
        items[726] = "Saguaro Scared";
        items[727] = "Saguaro Sick";
        items[728] = "Sailboat Bored";
        items[729] = "Sailboat Happy";
        items[730] = "Sailboat Scared";
        items[731] = "Sailboat Sick";
        items[732] = "Sandwich Bored";
        items[733] = "Sandwich Happy";
        items[734] = "Sandwich Scared";
        items[735] = "Sandwich Sick";
        items[736] = "Saturn Bored";
        items[737] = "Saturn Happy";
        items[738] = "Saturn Scared";
        items[739] = "Saturn Sick";
        items[740] = "Saw Bored";
        items[741] = "Saw Happy";
        items[742] = "Saw Scared";
        items[743] = "Saw Sick";
        items[744] = "Scorpion Bored";
        items[745] = "Scorpion Happy";
        items[746] = "Scorpion Scared";
        items[747] = "Scorpion Sick";
        items[748] = "Shark Bored";
        items[749] = "Shark Happy";
        items[750] = "Shark Scared";
        items[751] = "Shark Sick";
        items[752] = "Shower Bored";
        items[753] = "Shower Happy";
        items[754] = "Shower Scared";
        items[755] = "Shower Sick";
        items[756] = "Skateboard Bored";
        items[757] = "Skateboard Happy";
        items[758] = "Skateboard Scared";
        items[759] = "Skateboard Sick";
        items[760] = "Skeleton Hat Bored";
        items[761] = "Skeleton Hat Happy";
        items[762] = "Skeleton Hat Scared";
        items[763] = "Skeleton Hat Sick";
        items[764] = "Skilift Bored";
        items[765] = "Skilift Happy";
        items[766] = "Skilift Scared";
        items[767] = "Skilift Sick";
        items[768] = "Snowglobe Bored";
        items[769] = "Snowglobe Happy";
        items[770] = "Snowglobe Scared";
        items[771] = "Snowglobe Sick";
        items[772] = "Snowman Bored";
        items[773] = "Snowman Happy";
        items[774] = "Snowman Scared";
        items[775] = "Snowman Sick";
        items[776] = "Snowmobile Bored";
        items[777] = "Snowmobile Happy";
        items[778] = "Snowmobile Scared";
        items[779] = "Snowmobile Sick";
        items[780] = "Spaghetti Bored";
        items[781] = "Spaghetti Happy";
        items[782] = "Spaghetti Scared";
        items[783] = "Spaghetti Sick";
        items[784] = "Sponge Bored";
        items[785] = "Sponge Happy";
        items[786] = "Sponge Scared";
        items[787] = "Sponge Sick";
        items[788] = "Squid Bored";
        items[789] = "Squid Happy";
        items[790] = "Squid Scared";
        items[791] = "Squid Sick";
        items[792] = "Stapler Bored";
        items[793] = "Stapler Happy";
        items[794] = "Stapler Scared";
        items[795] = "Stapler Sick";
        items[796] = "Star Sparkles Bored";
        items[797] = "Star Sparkles Happy";
        items[798] = "Star Sparkles Scared";
        items[799] = "Star Sparkles Sick";
        items[800] = "Steak Bored";
        items[801] = "Steak Happy";
        items[802] = "Steak Scared";
        items[803] = "Steak Sick";
        items[804] = "Sunset Bored";
        items[805] = "Sunset Happy";
        items[806] = "Sunset Scared";
        items[807] = "Sunset Sick";
        items[808] = "Taco Bored";
        items[809] = "Taco Happy";
        items[810] = "Taco Scared";
        items[811] = "Taco Sick";
        items[812] = "Taxi Bored";
        items[813] = "Taxi Happy";
        items[814] = "Taxi Scared";
        items[815] = "Taxi Sick";
        items[816] = "Thumbsup Bored";
        items[817] = "Thumbsup Happy";
        items[818] = "Thumbsup Scared";
        items[819] = "Thumbsup Sick";
        items[820] = "Toaster Bored";
        items[821] = "Toaster Happy";
        items[822] = "Toaster Scared";
        items[823] = "Toaster Sick";
        items[824] = "Tooth Bored";
        items[825] = "Tooth Happy";
        items[826] = "Tooth Scared";
        items[827] = "Tooth Sick";
        items[828] = "Toothbrush Fresh Bored";
        items[829] = "Toothbrush Fresh Happy";
        items[830] = "Toothbrush Fresh Scared";
        items[831] = "Toothbrush Fresh Sick";
        items[832] = "Tornado Bored";
        items[833] = "Tornado Happy";
        items[834] = "Tornado Scared";
        items[835] = "Tornado Sick";
        items[836] = "Trashcan Bored";
        items[837] = "Trashcan Happy";
        items[838] = "Trashcan Scared";
        items[839] = "Trashcan Sick";
        items[840] = "Treasurechest Bored";
        items[841] = "Treasurechest Happy";
        items[842] = "Treasurechest Scared";
        items[843] = "Treasurechest Sick";
        items[844] = "Turing Bored";
        items[845] = "Turing Happy";
        items[846] = "Turing Scared";
        items[847] = "Turing Sick";
        items[848] = "Ufo Bored";
        items[849] = "Ufo Happy";
        items[850] = "Ufo Scared";
        items[851] = "Ufo Sick";
        items[852] = "Undead Bored";
        items[853] = "Undead Happy";
        items[854] = "Undead Scared";
        items[855] = "Undead Sick";
        items[856] = "Unicorn Bored";
        items[857] = "Unicorn Happy";
        items[858] = "Unicorn Scared";
        items[859] = "Unicorn Sick";
        items[860] = "Vending Machine Bored";
        items[861] = "Vending Machine Happy";
        items[862] = "Vending Machine Scared";
        items[863] = "Vending Machine Sick";
        items[864] = "Vent Bored";
        items[865] = "Vent Happy";
        items[866] = "Vent Scared";
        items[867] = "Vent Sick";
        items[868] = "Void Bored";
        items[869] = "Void Happy";
        items[870] = "Void Scared";
        items[871] = "Void Sick";
        items[872] = "Volcano Bored";
        items[873] = "Volcano Happy";
        items[874] = "Volcano Scared";
        items[875] = "Volcano Sick";
        items[876] = "Volleyball Bored";
        items[877] = "Volleyball Happy";
        items[878] = "Volleyball Scared";
        items[879] = "Volleyball Sick";
        items[880] = "Wall Bored";
        items[881] = "Wall Happy";
        items[882] = "Wall Scared";
        items[883] = "Wall Sick";
        items[884] = "Wallet Bored";
        items[885] = "Wallet Happy";
        items[886] = "Wallet Scared";
        items[887] = "Wallet Sick";
        items[888] = "Washingmachine Bored";
        items[889] = "Washingmachine Happy";
        items[890] = "Washingmachine Scared";
        items[891] = "Washingmachine Sick";
        items[892] = "Watch Bored";
        items[893] = "Watch Happy";
        items[894] = "Watch Scared";
        items[895] = "Watch Sick";
        items[896] = "Watermelon Bored";
        items[897] = "Watermelon Happy";
        items[898] = "Watermelon Scared";
        items[899] = "Watermelon Sick";
        items[900] = "Wave Bored";
        items[901] = "Wave Happy";
        items[902] = "Wave Scared";
        items[903] = "Wave Sick";
        items[904] = "Weed Bored";
        items[905] = "Weed Happy";
        items[906] = "Weed Scared";
        items[907] = "Weed Sick";
        items[908] = "Weight Bored";
        items[909] = "Weight Happy";
        items[910] = "Weight Scared";
        items[911] = "Weight Sick";
        items[912] = "Werewolf Bored";
        items[913] = "Werewolf Happy";
        items[914] = "Werewolf Scared";
        items[915] = "Werewolf Sick";
        items[916] = "Whale Alive Bored";
        items[917] = "Whale Alive Happy";
        items[918] = "Whale Alive Scared";
        items[919] = "Whale Alive Sick";
        items[920] = "Whale Bored";
        items[921] = "Whale Happy";
        items[922] = "Whale Scared";
        items[923] = "Whale Sick";
        items[924] = "Wine Barrel Bored";
        items[925] = "Wine Barrel Happy";
        items[926] = "Wine Barrel Scared";
        items[927] = "Wine Barrel Sick";
        items[928] = "Wine Bored";
        items[929] = "Wine Happy";
        items[930] = "Wine Scared";
        items[931] = "Wine Sick";
        items[932] = "Wizardhat Bored";
        items[933] = "Wizardhat Happy";
        items[934] = "Wizardhat Scared";
        items[935] = "Wizardhat Sick";
        items[936] = "Zebra Bored";
        items[937] = "Zebra Happy";
        items[938] = "Zebra Scared";
        items[939] = "Zebra Sick";

        bytes memory data = abi.encode(items);

        VmSafe vm = VmSafe(
            address(uint160(uint256(keccak256("hevm cheat code"))))
        );

        string[] memory inputs = new string[](3);
        inputs[0] = "node";
        inputs[1] = "script/nouns-coasters/deflate.js";
        inputs[2] = vm.toString(data);

        bytes memory compressedData = vm.ffi(inputs);

        // address result = SSTORE2.write(compressedData);

        renderer.addLayer({
            target: target,
            ipfs: INounsCoasterMetadataRendererTypes.IPFSGroup({
                baseUri: "ipfs://bafybeiag26lh2at7iah5xqlrzgj2ei2jd2qel3g5bpccgfj5ktjbvu4qm4/",
                extension: ".png"
            }),
            decompressedSize: data.length,
            compressedData: compressedData,
            count: items.length,
            property: "22 Head front right",
            variantProperty: variantPropertyParameters
        });
    }

    function addLayer23(NounsCoasterMetadataRenderer renderer, address target)
        internal
    {
        // 23 Expression front right
        INounsCoasterMetadataRendererTypes.VariantPropertyParameters
            memory variantPropertyParameters;
        variantPropertyParameters
            .offsets = new INounsCoasterMetadataRendererTypes.VariantOffset[](
            0
        );
        variantPropertyParameters.id = 0;
        variantPropertyParameters.count = 0;

        string[] memory items = new string[](4);
        items[0] = "Bored";
        items[1] = "Happy";
        items[2] = "Scared";
        items[3] = "Sick";

        bytes memory data = abi.encode(items);

        VmSafe vm = VmSafe(
            address(uint160(uint256(keccak256("hevm cheat code"))))
        );

        string[] memory inputs = new string[](3);
        inputs[0] = "node";
        inputs[1] = "script/nouns-coasters/deflate.js";
        inputs[2] = vm.toString(data);

        bytes memory compressedData = vm.ffi(inputs);

        // address result = SSTORE2.write(compressedData);

        renderer.addLayer({
            target: target,
            ipfs: INounsCoasterMetadataRendererTypes.IPFSGroup({
                baseUri: "ipfs://bafybeiag26lh2at7iah5xqlrzgj2ei2jd2qel3g5bpccgfj5ktjbvu4qm4/",
                extension: ".png"
            }),
            decompressedSize: data.length,
            compressedData: compressedData,
            count: items.length,
            property: "23 Expression front right",
            variantProperty: variantPropertyParameters
        });
    }

    function addLayer24(NounsCoasterMetadataRenderer renderer, address target)
        internal
    {
        // 24 Glasses front right
        INounsCoasterMetadataRendererTypes.VariantPropertyParameters
            memory variantPropertyParameters;
        variantPropertyParameters
            .offsets = new INounsCoasterMetadataRendererTypes.VariantOffset[](
            0
        );
        variantPropertyParameters.id = 0;
        variantPropertyParameters.count = 0;

        string[] memory items = new string[](21);
        items[0] = "Black";
        items[1] = "Black Red Eyes";
        items[2] = "Black Rgb";
        items[3] = "Blue";
        items[4] = "Blue Med Saturated";
        items[5] = "Frog Green";
        items[6] = "Full Black";
        items[7] = "Green Blue Multi";
        items[8] = "Grey Light";
        items[9] = "Guava";
        items[10] = "Hip Rose";
        items[11] = "Honey";
        items[12] = "Magenta";
        items[13] = "Orange";
        items[14] = "Pink Purple Multi";
        items[15] = "Red";
        items[16] = "Smoke";
        items[17] = "Teal";
        items[18] = "Watermelon";
        items[19] = "Yellow Orange Multi";
        items[20] = "Yellow Saturated";

        bytes memory data = abi.encode(items);

        VmSafe vm = VmSafe(
            address(uint160(uint256(keccak256("hevm cheat code"))))
        );

        string[] memory inputs = new string[](3);
        inputs[0] = "node";
        inputs[1] = "script/nouns-coasters/deflate.js";
        inputs[2] = vm.toString(data);

        bytes memory compressedData = vm.ffi(inputs);

        // address result = SSTORE2.write(compressedData);

        renderer.addLayer({
            target: target,
            ipfs: INounsCoasterMetadataRendererTypes.IPFSGroup({
                baseUri: "ipfs://bafybeiag26lh2at7iah5xqlrzgj2ei2jd2qel3g5bpccgfj5ktjbvu4qm4/",
                extension: ".png"
            }),
            decompressedSize: data.length,
            compressedData: compressedData,
            count: items.length,
            property: "24 Glasses front right",
            variantProperty: variantPropertyParameters
        });
    }
}
