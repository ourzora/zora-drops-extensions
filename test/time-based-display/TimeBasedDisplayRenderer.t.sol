// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import {Test} from "forge-std/Test.sol";

import {TimeBasedDisplayRenderer} from "../../src/time-based-display/TimeBasedDisplayRenderer.sol";

import {ERC721Drop} from "zora-drops-contracts/ERC721Drop.sol";
import {IERC721Drop} from "zora-drops-contracts/interfaces/IERC721Drop.sol";
import {ERC721DropProxy} from "zora-drops-contracts/ERC721DropProxy.sol";
import {IZoraFeeManager} from "zora-drops-contracts/interfaces/IZoraFeeManager.sol";
import {FactoryUpgradeGate} from "zora-drops-contracts/FactoryUpgradeGate.sol";
import {IERC721AUpgradeable} from "erc721a-upgradeable/IERC721AUpgradeable.sol";
import {MockRenderer} from "../utils/MockRenderer.sol";

contract ERC721DropMinterModuleTest is Test {
    address constant OWNER_ADDRESS = address(0x123);
    address constant RECIPIENT_ADDRESS = address(0x333);
    ERC721Drop impl;
    ERC721Drop drop;
    TimeBasedDisplayRenderer renderer;

    function setUp() public {
        impl = new ERC721Drop(
            IZoraFeeManager(address(0x0)),
            address(0x0),
            FactoryUpgradeGate(address(0x0))
        );
        renderer = new TimeBasedDisplayRenderer();
    }

    function setupDrop(uint256 limit, bytes memory init) internal {
        drop = ERC721Drop(
            payable(
                address(
                    new ERC721DropProxy(
                        address(impl),
                        abi.encodeWithSelector(
                            ERC721Drop.initialize.selector,
                            "Source NFT",
                            "SRC",
                            OWNER_ADDRESS,
                            address(0x0),
                            limit,
                            limit,
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
    }

    function testHourlyInterval() public {
        TimeBasedDisplayRenderer.TimedTokenInfo[]
            memory infos = new TimeBasedDisplayRenderer.TimedTokenInfo[](4);
        infos[0] = TimeBasedDisplayRenderer.TimedTokenInfo({
            description: "From midnight - 8am",
            imageURI: "",
            animationURI: "",
            period: TimeBasedDisplayRenderer.Period.HOUR_OF_DAY,
            start: 0,
            end: 8
        });
        infos[1] = TimeBasedDisplayRenderer.TimedTokenInfo({
            description: "From 8am - 4pm",
            imageURI: "",
            animationURI: "",
            period: TimeBasedDisplayRenderer.Period.HOUR_OF_DAY,
            start: 8,
            end: 16
        });
        infos[2] = TimeBasedDisplayRenderer.TimedTokenInfo({
            description: "From 4pm - midnight",
            imageURI: "",
            animationURI: "",
            period: TimeBasedDisplayRenderer.Period.HOUR_OF_DAY,
            start: 16,
            end: 24
        });
        infos[3] = TimeBasedDisplayRenderer.TimedTokenInfo({
            description: "From 4pm - midnight",
            imageURI: "",
            animationURI: "",
            period: TimeBasedDisplayRenderer.Period.DEFAULT_FALLBACK,
            start: 0,
            end: 0
        });
        setupDrop(20, abi.encode(infos));
        vm.startPrank(OWNER_ADDRESS);
        drop.adminMint(RECIPIENT_ADDRESS, 10);

        // get midnight
        assertEq(renderer.getDataAt(address(drop), 10).description, "From midnight - 8am");
        // get 10 am
        assertEq(renderer.getDataAt(address(drop), 10 hours).description, "From 8am - 4pm");
        // get 5pm
        assertEq(renderer.getDataAt(address(drop), 5 hours + 12 hours).description, "From 4pm - midnight");

        // get 5pm in 345 days
        assertEq(renderer.getDataAt(address(drop), 5 hours + 12 hours + 345 days) .description, "From 4pm - midnight");
    }

    function testDayOfYearInterval() public {
        TimeBasedDisplayRenderer.TimedTokenInfo[]
            memory infos = new TimeBasedDisplayRenderer.TimedTokenInfo[](4);
        infos[0] = TimeBasedDisplayRenderer.TimedTokenInfo({
            description: "Days 0 - 21",
            imageURI: "",
            animationURI: "",
            period: TimeBasedDisplayRenderer.Period.DAY_OF_YEAR,
            start: 0,
            end: 21 
        });
        infos[1] = TimeBasedDisplayRenderer.TimedTokenInfo({
            description: "Days 80 - 120",
            imageURI: "",
            animationURI: "",
            period: TimeBasedDisplayRenderer.Period.DAY_OF_YEAR,
            start: 80,
            end: 120 
        });
        infos[2] = TimeBasedDisplayRenderer.TimedTokenInfo({
            description: "Days 200 - 300",
            imageURI: "",
            animationURI: "",
            period: TimeBasedDisplayRenderer.Period.DAY_OF_YEAR,
            start: 200,
            end: 300
        });
        infos[3] = TimeBasedDisplayRenderer.TimedTokenInfo({
            description: "FALLBACK",
            imageURI: "",
            animationURI: "",
            period: TimeBasedDisplayRenderer.Period.DEFAULT_FALLBACK,
            start: 0,
            end: 0
        });
        setupDrop(20, abi.encode(infos));
        vm.startPrank(OWNER_ADDRESS);
        drop.adminMint(RECIPIENT_ADDRESS, 10);

        assertEq(renderer.getDataAt(address(drop), 20 days).description, "Days 0 - 21");
        assertEq(renderer.getDataAt(address(drop), 90 days).description, "Days 80 - 120");
        assertEq(renderer.getDataAt(address(drop), 200 days).description, "Days 200 - 300");
    }

    function testMonthOfYearInterval() public {
        TimeBasedDisplayRenderer.TimedTokenInfo[]
            memory infos = new TimeBasedDisplayRenderer.TimedTokenInfo[](4);
        infos[0] = TimeBasedDisplayRenderer.TimedTokenInfo({
            description: "From Jan - Mar",
            imageURI: "",
            animationURI: "",
            period: TimeBasedDisplayRenderer.Period.MONTH_OF_YEAR,
            start: 0,
            end: 3
        });
        infos[1] = TimeBasedDisplayRenderer.TimedTokenInfo({
            description: "From Mar - Nov",
            imageURI: "",
            animationURI: "",
            period: TimeBasedDisplayRenderer.Period.MONTH_OF_YEAR,
            start: 3,
            end: 10 
        });
        infos[2] = TimeBasedDisplayRenderer.TimedTokenInfo({
            description: "From Dec - Dec",
            imageURI: "",
            animationURI: "",
            period: TimeBasedDisplayRenderer.Period.MONTH_OF_YEAR,
            start: 12,
            end: 13
        });
        infos[3] = TimeBasedDisplayRenderer.TimedTokenInfo({
            description: "From Never",
            imageURI: "",
            animationURI: "",
            period: TimeBasedDisplayRenderer.Period.DEFAULT_FALLBACK,
            start: 0,
            end: 0
        });
        setupDrop(20, abi.encode(infos));
        vm.startPrank(OWNER_ADDRESS);
        drop.adminMint(RECIPIENT_ADDRESS, 10);

        assertEq(renderer.getDataAt(address(drop), 32 days).description, "From Jan - Mar");
        assertEq(renderer.getDataAt(address(drop), 32 * 3 days).description, "From Mar - Nov");
        assertEq(renderer.getDataAt(address(drop), 354 days).description, "From Dec - Dec");
    }
}
