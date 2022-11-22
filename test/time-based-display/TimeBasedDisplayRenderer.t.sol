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

    function testForDropThree() public {
        TimeBasedDisplayRenderer.TimedTokenInfo[]
            memory infos = new TimeBasedDisplayRenderer.TimedTokenInfo[](3);
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
}
