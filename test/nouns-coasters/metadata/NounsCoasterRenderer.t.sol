// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import {NounsCoasterMetadataRenderer} from "../../../src/nouns-coasters/metadata/NounsCoasterMetadataRenderer.sol";
import {INounsCoasterMetadataRendererTypes} from "../../../src/nouns-coasters/interfaces/INounsCoasterMetadataRendererTypes.sol";
import {CoasterHelper} from "../../../src/nouns-coasters/metadata/CoasterHelper.sol";
import {MetadataRenderAdminCheck} from "zora-drops-contracts/metadata/MetadataRenderAdminCheck.sol";
import {IMetadataRenderer} from "zora-drops-contracts/interfaces/IMetadataRenderer.sol";
import {DropMockBase} from "./DropMockBase.sol";
import {IERC721Drop} from "zora-drops-contracts/interfaces/IERC721Drop.sol";
import {Ownable2Step} from "openzeppelin-contracts/contracts/access/Ownable2Step.sol";
import {Test} from "forge-std/Test.sol";
import {SSTORE2} from "../../../src/nouns-coasters/utils/SSTORE2.sol";
import "forge-std/console2.sol";

contract ERC721OnChainDataMock {
    IERC721Drop.SaleDetails private saleDetailsInternal;
    IERC721Drop.Configuration private configInternal;
    address private admin;

    constructor(
        uint256 totalMinted,
        uint256 maxSupply,
        address _admin
    ) {
        admin = _admin;
        saleDetailsInternal = IERC721Drop.SaleDetails({
            publicSaleActive: false,
            presaleActive: false,
            publicSalePrice: 0,
            publicSaleStart: 0,
            publicSaleEnd: 0,
            presaleStart: 0,
            presaleEnd: 0,
            presaleMerkleRoot: 0x0000000000000000000000000000000000000000000000000000000000000000,
            maxSalePurchasePerAddress: 0,
            totalMinted: totalMinted,
            maxSupply: maxSupply
        });

        configInternal = IERC721Drop.Configuration({
            metadataRenderer: IMetadataRenderer(address(0x0)),
            editionSize: 12,
            royaltyBPS: 1000,
            fundsRecipient: payable(address(0x163))
        });
    }

    function name() external returns (string memory) {
        return "MOCK NAME";
    }

    function saleDetails() external returns (IERC721Drop.SaleDetails memory) {
        return saleDetailsInternal;
    }

    function config() external returns (IERC721Drop.Configuration memory) {
        return configInternal;
    }

    function isAdmin(address testAdmin) external view returns (bool) {
        return testAdmin == admin;
    }
}

contract NounsCoasterMetadataRendererTest is Test {
    address public constant mediaContract = address(0x123456);
    address public constant admin = address(0x939);
    NounsCoasterMetadataRenderer public nounsRenderer;
    ERC721OnChainDataMock public mock;

    function setUp() public {
        mock = new ERC721OnChainDataMock(10, 1000, admin);
        nounsRenderer = new NounsCoasterMetadataRenderer();
        vm.prank(address(mock));
        nounsRenderer.initializeWithData(
            abi.encode(
                INounsCoasterMetadataRendererTypes.Settings({
                    description: "Nouns Coaster",
                    contractImage: "https://image.com",
                    projectURI: "https://projectURI.com",
                    rendererBase: "https://api.zora.co/renderer/stack-images",
                    variantCount: 4
                })
            )
        );
    }

    function test_NCMetadataInits() public {
        INounsCoasterMetadataRendererTypes.Settings
            memory settings = nounsRenderer.getSettings(address(mock));
        string memory image = settings.contractImage;
        string memory desc = settings.description;
        string memory projURI = settings.projectURI;
        vm.prank(address(mock));
        string memory uri = nounsRenderer.contractURI();

        assertEq(image, "https://image.com");
        assertEq(desc, "Nouns Coaster");
        assertEq(projURI, "https://projectURI.com");
        assertEq(
            uri,
            "data:application/json;base64,eyJuYW1lIjogIk1PQ0sgTkFNRSIsImRlc2NyaXB0aW9uIjogIk5vdW5zIENvYXN0ZXIiLCJpbWFnZSI6ICJodHRwczovL2ltYWdlLmNvbSIsImV4dGVybmFsX3VybCI6ICJodHRwczovL3Byb2plY3RVUkkuY29tIn0="
        );
    }

    function test_UpdateSettings() public {
        vm.startPrank(address(this));

        INounsCoasterMetadataRendererTypes.Settings
            memory settings = nounsRenderer.getSettings(address(mock));

        settings.description = "new description";

        vm.prank(address(mock));
        nounsRenderer.updateSettings(address(mock), settings);

        INounsCoasterMetadataRendererTypes.Settings
            memory settingsResult = nounsRenderer.getSettings(address(mock));
        assertEq(settingsResult.description, "new description");
    }

    function test_UpdateSettingsNotAllowed() public {
        INounsCoasterMetadataRendererTypes.Settings memory settings;
        vm.prank(vm.addr(0x1));
        vm.expectRevert();
        nounsRenderer.updateSettings(address(mock), settings);
    }

    function test_AddItems() public {

        address target = address(mock);

        vm.startPrank(admin);
        CoasterHelper.addLayer1(nounsRenderer, target);
        CoasterHelper.addLayer5(nounsRenderer, target);
        CoasterHelper.addLayer6(nounsRenderer, target);
        CoasterHelper.addLayer7(nounsRenderer, target);
        CoasterHelper.addLayer8(nounsRenderer, target);
        CoasterHelper.addLayer9(nounsRenderer, target);
        CoasterHelper.addLayer10(nounsRenderer, target);
        CoasterHelper.addLayer11(nounsRenderer, target);
        CoasterHelper.addLayer12(nounsRenderer, target);
        CoasterHelper.addLayer13(nounsRenderer, target);
        CoasterHelper.addLayer14(nounsRenderer, target);
        CoasterHelper.addLayer15(nounsRenderer, target);
        CoasterHelper.addLayer16(nounsRenderer, target);
        CoasterHelper.addLayer17(nounsRenderer, target);
        CoasterHelper.addLayer18(nounsRenderer, target);
        CoasterHelper.addLayer19(nounsRenderer, target);
        CoasterHelper.addLayer20(nounsRenderer, target);
        CoasterHelper.addLayer21(nounsRenderer, target);
        CoasterHelper.addLayer22(nounsRenderer, target);
        CoasterHelper.addLayer23(nounsRenderer, target);
        CoasterHelper.addLayer24(nounsRenderer, target);

        (string memory _r1, string memory _r2) = nounsRenderer.getAttributes(
            target,
            10
        );
        console2.log(_r1);
        console2.log(_r2);

        (_r1, _r2) = nounsRenderer.getAttributes(target, 1);
        console2.log(_r1);
        console2.log(_r2);

        (_r1, _r2) = nounsRenderer.getAttributes(target, 2);
        console2.log(_r1);
        console2.log(_r2);

        vm.stopPrank();
        vm.startPrank(target);

        console2.log(nounsRenderer.tokenURI(1));
        console2.log(nounsRenderer.tokenURI(2));
        console2.log(nounsRenderer.tokenURI(10));
    }

    function test_sstore2() public {
        address data = SSTORE2.write(abi.encode("hello"));
        string memory result = abi.decode(SSTORE2.read(data), (string));
        console2.log(result);
    }

    function test_OpenEdition() public {
        ERC721OnChainDataMock mockOE = new ERC721OnChainDataMock({
            totalMinted: 10,
            maxSupply: type(uint64).max,
            _admin: admin
        });

        console2.log("tokenURI", nounsRenderer.tokenURI(1));

        assertEq(
            "data:application/json;base64,eyJuYW1lIjogIk1PQ0sgTkFNRSAxIiwgImRlc2NyaXB0aW9uIjogIkRlc2NyaXB0aW9uIiwgImltYWdlIjogImltYWdlIiwgImFuaW1hdGlvbl91cmwiOiAiYW5pbWF0aW9uIiwgInByb3BlcnRpZXMiOiB7Im51bWJlciI6IDEsICJuYW1lIjogIk1PQ0sgTkFNRSJ9fQ==",
            nounsRenderer.tokenURI(1)
        );
    }
}
