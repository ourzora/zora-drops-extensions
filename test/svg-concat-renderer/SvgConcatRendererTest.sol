// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import {Test} from "forge-std/Test.sol";

import {SvgConcatRenderer} from "../../src/svg-concat-renderer/SvgConcatRenderer.sol";

import {ERC721Drop} from "zora-drops-contracts/ERC721Drop.sol";
import {IERC721Drop} from "zora-drops-contracts/interfaces/IERC721Drop.sol";
import {ERC721DropProxy} from "zora-drops-contracts/ERC721DropProxy.sol";
import {IZoraFeeManager} from "zora-drops-contracts/interfaces/IZoraFeeManager.sol";
import {FactoryUpgradeGate} from "zora-drops-contracts/FactoryUpgradeGate.sol";
import {IERC721AUpgradeable} from "erc721a-upgradeable/IERC721AUpgradeable.sol";

contract SvgConcatRendererTest is Test {
    address constant OWNER_ADDRESS = address(0x123);
    address constant RECIPIENT_ADDRESS = address(0x333);
    ERC721Drop impl;
    ERC721Drop drop;
    SvgConcatRenderer renderer;

    function setUp() public {
        impl = new ERC721Drop(
            IZoraFeeManager(address(0x0)),
            address(0x0),
            FactoryUpgradeGate(address(0x0))
        );
        renderer = new SvgConcatRenderer();
    }

    modifier withDrop(uint256 limit, bytes memory init) {
        drop = ERC721Drop(
            payable(
                address(
                    new ERC721DropProxy(
                        address(impl),
                        abi.encodeWithSelector(
                            ERC721Drop.initialize.selector,
                            "SVG NFT",
                            "SRC",
                            OWNER_ADDRESS,
                            address(0x0),
                            200,
                            200,
                            IERC721Drop.SalesConfiguration({
                                publicSaleStart: 0,
                                publicSaleEnd: 0,
                                presaleStart: 0,
                                presaleEnd: 0,
                                publicSalePrice: 0,
                                maxSalePurchasePerAddress: 0,
                                presaleMerkleRoot: 0x0
                            }),
                            renderer,
                            init
                        )
                    )
                )
            )
        );
        _;
    }

    function testForDropThree()
        public
        withDrop(
            201,
            abi.encode(
                "Testing Description",
                "data:image/svg+xml,%3csvg font-family='monospace' xmlns='http://www.w3.org/2000/svg'%3e%3ctext x='0' y='15'%3eTest SVG ",
                "%3c/text%3e%3c/svg%3e"
            )
        )
    {
        vm.startPrank(OWNER_ADDRESS);
        drop.adminMint(RECIPIENT_ADDRESS, 200);
        assertEq(
            drop.tokenURI(1),
            "data:application/json;base64,eyJuYW1lIjogIlNWRyBORlQgMS8yMDAiLCAiZGVzY3JpcHRpb24iOiAiVGVzdGluZyBEZXNjcmlwdGlvbiIsICJpbWFnZSI6ICJkYXRhOmltYWdlL3N2Zyt4bWwsJTNjc3ZnIGZvbnQtZmFtaWx5PSdtb25vc3BhY2UnIHhtbG5zPSdodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyclM2UlM2N0ZXh0IHg9JzAnIHk9JzE1JyUzZVRlc3QgU1ZHIDB4MDAwMSUzYy90ZXh0JTNlJTNjL3N2ZyUzZSIsICJwcm9wZXJ0aWVzIjogeyJudW1iZXIiOiAxLCAibmFtZSI6ICJTVkcgTkZUIn19"
        );
        assertEq(
            drop.tokenURI(2),
            "data:application/json;base64,eyJuYW1lIjogIlNWRyBORlQgMi8yMDAiLCAiZGVzY3JpcHRpb24iOiAiVGVzdGluZyBEZXNjcmlwdGlvbiIsICJpbWFnZSI6ICJkYXRhOmltYWdlL3N2Zyt4bWwsJTNjc3ZnIGZvbnQtZmFtaWx5PSdtb25vc3BhY2UnIHhtbG5zPSdodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyclM2UlM2N0ZXh0IHg9JzAnIHk9JzE1JyUzZVRlc3QgU1ZHIDB4MDAwMiUzYy90ZXh0JTNlJTNjL3N2ZyUzZSIsICJwcm9wZXJ0aWVzIjogeyJudW1iZXIiOiAyLCAibmFtZSI6ICJTVkcgTkZUIn19"
        );
        assertEq(
            drop.tokenURI(199),
            "data:application/json;base64,eyJuYW1lIjogIlNWRyBORlQgMTk5LzIwMCIsICJkZXNjcmlwdGlvbiI6ICJUZXN0aW5nIERlc2NyaXB0aW9uIiwgImltYWdlIjogImRhdGE6aW1hZ2Uvc3ZnK3htbCwlM2NzdmcgZm9udC1mYW1pbHk9J21vbm9zcGFjZScgeG1sbnM9J2h0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnJyUzZSUzY3RleHQgeD0nMCcgeT0nMTUnJTNlVGVzdCBTVkcgMHgwMGM3JTNjL3RleHQlM2UlM2Mvc3ZnJTNlIiwgInByb3BlcnRpZXMiOiB7Im51bWJlciI6IDE5OSwgIm5hbWUiOiAiU1ZHIE5GVCJ9fQ=="
        );
    }
}
