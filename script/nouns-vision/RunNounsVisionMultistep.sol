// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "forge-std/Script.sol";

import {ZoraNFTCreatorV1} from "zora-drops-contracts/ZoraNFTCreatorV1.sol";
import {ZoraNFTCreatorProxy} from "zora-drops-contracts/ZoraNFTCreatorProxy.sol";
import {ZoraFeeManager} from "zora-drops-contracts/ZoraFeeManager.sol";
import {ERC721Drop} from "zora-drops-contracts/ERC721Drop.sol";
import {IERC721Drop} from "zora-drops-contracts/interfaces/IERC721Drop.sol";
import {IMetadataRenderer} from "zora-drops-contracts/interfaces/IMetadataRenderer.sol";
import {FactoryUpgradeGate} from "zora-drops-contracts/FactoryUpgradeGate.sol";
import {EditionMetadataRenderer} from "zora-drops-contracts/metadata/EditionMetadataRenderer.sol";
import {DropMetadataRenderer} from "zora-drops-contracts/metadata/DropMetadataRenderer.sol";

import {ERC721NounsExchangeSwapMinter} from "../../src/nouns-vision/ERC721NounsExchangeSwapMinter.sol";
import {NounsVisionExchangeMinterModule} from "../../src/nouns-vision/NounsVisionExchangeMinterModule.sol";

import {Address} from "@openzeppelin/contracts/utils/Address.sol";

contract DeployerSignatureMinter is Script {
    ZoraNFTCreatorV1 creatorProxy;

    function _getOrCreateCreator() internal returns (ZoraNFTCreatorV1) {
        creatorProxy = ZoraNFTCreatorV1(vm.envAddress("creatorProxy"));
        if (address(creatorProxy) == address(0)) {
            ZoraFeeManager feeManager = new ZoraFeeManager(0, address(0));
            ERC721Drop dropImpl = new ERC721Drop(
                feeManager,
                address(0),
                FactoryUpgradeGate(address(0))
            );
            EditionMetadataRenderer editionMetadataRenderer = new EditionMetadataRenderer();
            ZoraNFTCreatorV1 impl = new ZoraNFTCreatorV1(
                address(dropImpl),
                editionMetadataRenderer,
                DropMetadataRenderer(address(0x123))
            );
            creatorProxy = ZoraNFTCreatorV1(
                address(new ZoraNFTCreatorProxy(address(impl), ""))
            );
            creatorProxy.initialize();
        }
        return creatorProxy;
    }

    function deployDrop(
        string memory name,
        string memory symbol,
        uint64 supply,
        address owner
    ) internal returns (address) {
        ZoraNFTCreatorV1 creator = _getOrCreateCreator();
        return
            creator.createEdition(
                name,
                symbol,
                supply,
                0,
                payable(owner),
                owner,
                IERC721Drop.SalesConfiguration({
                    publicSaleStart: 0,
                    publicSaleEnd: 0,
                    presaleStart: 0,
                    presaleEnd: 0,
                    publicSalePrice: 0,
                    maxSalePurchasePerAddress: 0,
                    presaleMerkleRoot: bytes32(0)
                }),
                name,
                "",
                "ipfs://"
            );
    }

    function run() external {
        address payable deployer = payable(vm.envAddress("deployer"));

        vm.startBroadcast(deployer);

        // 1 deploy drop for source NOUNS_VISION_DISCO
        address nounsDisco = deployDrop(
            "Nouns Vision Disco",
            "NOUNSDISCO",
            500,
            deployer
        );

        // 2 deploy drop as "Nouns"
        // admin mint 10 tokens to NOUNS_HOLDER_1
        address nounsMock = deployDrop(
            "Nouns Holder",
            "NOUNS_HOLDER_MOCK",
            500,
            deployer
        );

        // 3 deploy drop as "Disco Vision Redeemed Token"
        // NOUNS_VISION_DISCO_REDEEMED
        address nounsDiscoRedeemed = deployDrop(
            "Nouns Vision Disco Redeemed",
            "NOUNSDISCOREDEEMED",
            500,
            deployer
        );

        // ^^ these contracts exist on mainnet

        // 3 setup the ERC721NounsExchangeSwapMinter (standalone contract that takes nouns and nouns vision contracts)
        //
        //  - Allows for admin to claim on behalf of nouns holder
        // set minter for NOUNS_VISION_DISCO as ERC721NounsExchangeSwapMinter contract
        ERC721NounsExchangeSwapMinter swapMinter = new ERC721NounsExchangeSwapMinter({
                _nounsToken: nounsMock,
                _discoGlasses: nounsDisco,
                _freeMintMaxCount: 200,
                _costPerNoun: 0.1 ether,
                _initialOwner: deployer
            });
        ERC721Drop nounsDiscoDrop = ERC721Drop(payable(nounsDisco));
        bytes32 minterRole = nounsDiscoDrop.MINTER_ROLE();
        nounsDiscoDrop.grantRole(minterRole, address(swapMinter));

        // 4 setup the NounsVisionExchangeMinterModule
        //  from token = NOUNS_VISION_DISCO // to token = DISCO_VISION_REDEEMED
        NounsVisionExchangeMinterModule exchangeMinterModule = new NounsVisionExchangeMinterModule({
                _source: nounsDiscoDrop,
                _description: "Nouns Vision Disco Redeemed"
            });

        // Allow exchange module to mint redeemed tokens
        ERC721Drop(payable(nounsDiscoRedeemed)).grantRole(bytes32(0), address(exchangeMinterModule));

        // 6 exchange disco token with NounsVisionExchangeMinterModule to DISCO_VISION_REDEEMED

        // sets redeemed metadata renderer
        ERC721Drop(payable(nounsDiscoRedeemed)).setMetadataRenderer(
            exchangeMinterModule,
            "0xcafe"
        );


        // 5 claim disco token from NOUNS_HOLDER_ONE

        address nounsHolder1 = address(0x004029);
        uint256 nounId = ERC721Drop(payable(nounsMock)).adminMint(
            nounsHolder1,
            1
        );


        // Can be hard-coded into the drop with data from @salvino, can also be done via etherscan
        NounsVisionExchangeMinterModule.ColorSetting[]
            memory colorSettings = new NounsVisionExchangeMinterModule.ColorSetting[](
                1
            );
        colorSettings[0] = NounsVisionExchangeMinterModule.ColorSetting({
            color: "disco",
            maxCount: 100,
            animationURI: "",
            imageURI: ""
        });
        exchangeMinterModule.setColorLimits(colorSettings);

        // Part 2: User interaction flow

        vm.stopBroadcast();
        vm.startBroadcast(nounsHolder1);
        uint256[] memory nounIds = new uint256[](1);
        nounIds[0] = nounId;
        uint256 newMintedId = swapMinter.mintWithNouns(nounIds);

        ERC721Drop(payable(nounsDiscoDrop)).setApprovalForAll(
            address(exchangeMinterModule),
            true
        );

        uint256[] memory discoIds = new uint256[](1);
        discoIds[0] = newMintedId;
        exchangeMinterModule.exchange(discoIds, "disco");

        vm.stopBroadcast();
    }
}
