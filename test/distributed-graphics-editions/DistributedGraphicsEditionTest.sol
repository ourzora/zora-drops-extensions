// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import {Test} from "forge-std/Test.sol";

import {NounsVisionExchangeMinterModule} from "../../src/nouns-vision/NounsVisionExchangeMinterModule.sol";
import {DistributedGraphicsEdition} from "../../src/distributed-graphics-editions/DistributedGraphicsEdition.sol";

import {ERC721Drop} from "zora-drops-contracts/ERC721Drop.sol";
import {IERC721Drop} from "zora-drops-contracts/interfaces/IERC721Drop.sol";
import {ERC721DropProxy} from "zora-drops-contracts/ERC721DropProxy.sol";
import {FactoryUpgradeGate} from "zora-drops-contracts/FactoryUpgradeGate.sol";
import {IERC721AUpgradeable} from "erc721a-upgradeable/IERC721AUpgradeable.sol";
import {MockRenderer} from "../utils/MockRenderer.sol";

contract ERC721DropMinterModuleTest is Test {
    address constant OWNER_ADDRESS = address(0x123);
    address constant RECIPIENT_ADDRESS = address(0x333);
    ERC721Drop impl;
    ERC721Drop drop;
    DistributedGraphicsEdition renderer;

    function setUp() public {
        impl = new ERC721Drop(
            address(0),
            FactoryUpgradeGate(address(0)),
            address(0),
            0,
            payable(address(0)),
            address(0)
        );
        renderer = new DistributedGraphicsEdition();
    }

    modifier withDrop(uint256 limit, bytes memory init) {
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
                            10,
                            10,
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
            20,
            abi.encode(
                "Testing Description",
                "https://videos.example/",
                "https://images.example/",
                3,
                false
            )
        )
    {
        vm.startPrank(OWNER_ADDRESS);
        drop.adminMint(RECIPIENT_ADDRESS, 10);
        assertEq(
            drop.tokenURI(1),
            "data:application/json;base64,eyJuYW1lIjogIlNvdXJjZSBORlQgMS8xMCIsICJkZXNjcmlwdGlvbiI6ICJUZXN0aW5nIERlc2NyaXB0aW9uIiwgImltYWdlIjogImh0dHBzOi8vdmlkZW9zLmV4YW1wbGUvMSIsICJhbmltYXRpb25fdXJsIjogImh0dHBzOi8vaW1hZ2VzLmV4YW1wbGUvMSIsICJwcm9wZXJ0aWVzIjogeyJudW1iZXIiOiAxLCAibmFtZSI6ICJTb3VyY2UgTkZUIn19"
        );
        assertEq(
            drop.tokenURI(2),
            "data:application/json;base64,eyJuYW1lIjogIlNvdXJjZSBORlQgMi8xMCIsICJkZXNjcmlwdGlvbiI6ICJUZXN0aW5nIERlc2NyaXB0aW9uIiwgImltYWdlIjogImh0dHBzOi8vdmlkZW9zLmV4YW1wbGUvMiIsICJhbmltYXRpb25fdXJsIjogImh0dHBzOi8vaW1hZ2VzLmV4YW1wbGUvMiIsICJwcm9wZXJ0aWVzIjogeyJudW1iZXIiOiAyLCAibmFtZSI6ICJTb3VyY2UgTkZUIn19"
        );
        assertEq(
            drop.tokenURI(3),
            "data:application/json;base64,eyJuYW1lIjogIlNvdXJjZSBORlQgMy8xMCIsICJkZXNjcmlwdGlvbiI6ICJUZXN0aW5nIERlc2NyaXB0aW9uIiwgImltYWdlIjogImh0dHBzOi8vdmlkZW9zLmV4YW1wbGUvMyIsICJhbmltYXRpb25fdXJsIjogImh0dHBzOi8vaW1hZ2VzLmV4YW1wbGUvMyIsICJwcm9wZXJ0aWVzIjogeyJudW1iZXIiOiAzLCAibmFtZSI6ICJTb3VyY2UgTkZUIn19"
        );
        assertEq(
            drop.tokenURI(4),
            "data:application/json;base64,eyJuYW1lIjogIlNvdXJjZSBORlQgNC8xMCIsICJkZXNjcmlwdGlvbiI6ICJUZXN0aW5nIERlc2NyaXB0aW9uIiwgImltYWdlIjogImh0dHBzOi8vdmlkZW9zLmV4YW1wbGUvNCIsICJhbmltYXRpb25fdXJsIjogImh0dHBzOi8vaW1hZ2VzLmV4YW1wbGUvNCIsICJwcm9wZXJ0aWVzIjogeyJudW1iZXIiOiA0LCAibmFtZSI6ICJTb3VyY2UgTkZUIn19"
        );
    }

    function testForDropRandomThree()
        public
        withDrop(
            20,
            abi.encode(
                "Testing Description",
                "https://videos.example/",
                "https://images.example/",
                3,
                true
            )
        )
    {
        vm.startPrank(OWNER_ADDRESS);
        drop.adminMint(RECIPIENT_ADDRESS, 10);
        drop.tokenURI(1);
        drop.tokenURI(2);
        drop.tokenURI(3);
        drop.tokenURI(4);
        drop.tokenURI(5);
        assertEq(
            drop.tokenURI(4),
            "data:application/json;base64,eyJuYW1lIjogIlNvdXJjZSBORlQgNC8xMCIsICJkZXNjcmlwdGlvbiI6ICJUZXN0aW5nIERlc2NyaXB0aW9uIiwgImltYWdlIjogImh0dHBzOi8vdmlkZW9zLmV4YW1wbGUvMSIsICJhbmltYXRpb25fdXJsIjogImh0dHBzOi8vaW1hZ2VzLmV4YW1wbGUvMSIsICJwcm9wZXJ0aWVzIjogeyJudW1iZXIiOiA0LCAibmFtZSI6ICJTb3VyY2UgTkZUIn19"
        );
    }
}
