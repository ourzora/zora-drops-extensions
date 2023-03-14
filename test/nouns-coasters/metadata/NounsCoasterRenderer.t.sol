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
        // todo remove
        return true;
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
        nounsRenderer = new NounsCoasterMetadataRenderer({
            _description: "Nouns Coaster",
            _contractImage: "https://image.com",
            _projectURI: "https://projectURI.com",
            _rendererBase: "ipfs://QmZ9UT92uG3oxKHhm7s7Xts9p8HTxZ99KdevVhQbD3vuUj/",
            _token: address(mock),
            _owner: admin
        });
    }

    function test_NCMetadataInits() public {
        address token = nounsRenderer.token();
        string memory image = nounsRenderer.contractImage();
        string memory uri = nounsRenderer.contractURI();
        string memory desc = nounsRenderer.description();
        string memory projURI = nounsRenderer.projectURI();

        assertEq(token, address(mock));
        assertEq(image, "https://image.com");
        assertEq(desc, "Nouns Coaster");
        assertEq(projURI, "https://projectURI.com");
        assertEq(
            uri,
            "data:application/json;base64,eyJuYW1lIjogIk1PQ0sgTkFNRSIsImRlc2NyaXB0aW9uIjogIk5vdW5zIENvYXN0ZXIiLCJpbWFnZSI6ICJodHRwczovL2ltYWdlLmNvbSIsImV4dGVybmFsX3VybCI6ICJodHRwczovL3Byb2plY3RVUkkuY29tIn0="
        );
    }

    function test_UpdateDescriptionAllowed() public {
        vm.startPrank(address(this));
        nounsRenderer.updateDescription("new description");

        string memory description = nounsRenderer.description();
        assertEq(description, "new description");
    }

    function test_UpdateDescriptionNotAllowed() public {
        vm.prank(vm.addr(0x1));
        vm.expectRevert();
        nounsRenderer.updateDescription("new description");
    }

    function test_AddItems() public {
        vm.startPrank(admin);

        CoasterHelper.addLayer1(nounsRenderer);
        CoasterHelper.addLayer5(nounsRenderer);
        CoasterHelper.addLayer6(nounsRenderer);
        CoasterHelper.addLayer7(nounsRenderer);
        CoasterHelper.addLayer8(nounsRenderer);
        CoasterHelper.addLayer9(nounsRenderer);
        CoasterHelper.addLayer10(nounsRenderer);
        CoasterHelper.addLayer11(nounsRenderer);
        CoasterHelper.addLayer12(nounsRenderer);
        CoasterHelper.addLayer13(nounsRenderer);
        CoasterHelper.addLayer14(nounsRenderer);
        CoasterHelper.addLayer15(nounsRenderer);
        CoasterHelper.addLayer16(nounsRenderer);
        CoasterHelper.addLayer17(nounsRenderer);
        CoasterHelper.addLayer18(nounsRenderer);
        CoasterHelper.addLayer19(nounsRenderer);
        CoasterHelper.addLayer20(nounsRenderer);
        CoasterHelper.addLayer21(nounsRenderer);
        CoasterHelper.addLayer22(nounsRenderer);
        CoasterHelper.addLayer23(nounsRenderer);
        CoasterHelper.addLayer24(nounsRenderer);

        (string memory _r1, string memory _r2) = nounsRenderer.getAttributes(
            10
        );
        console2.log(_r1);
        console2.log(_r2);
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
