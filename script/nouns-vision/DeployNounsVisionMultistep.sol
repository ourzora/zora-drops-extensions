// TOD// SPDX-License-Identifier: MIT
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

contract DeployNounsVision is Script {
    ZoraNFTCreatorV1 creatorProxy;

    struct Addresses {
        address payable deployer;
        address nounsTokenAddress;
        address newAdminAddress;
        address nounsDiscoAddress;
        address nounsDiscoRedeemedAddress;
    }

    uint64 public constant MAX_DISCO_SUPPLY = 500;
    uint256 public constant PRICE_PER_DISCO = 0.19 ether;

    function run() external {
        Addresses memory adrs = Addresses({
            deployer: payable(vm.envAddress("deployer")),
            nounsTokenAddress: vm.envAddress("nouns_token"),
            newAdminAddress: vm.envAddress("new_admin_address"),
            nounsDiscoAddress: address(0),
            nounsDiscoRedeemedAddress: address(0)
        });

        vm.startBroadcast(adrs.deployer);

        adrs.nounsDiscoAddress = ZoraNFTCreatorV1(
            vm.envAddress("creator_proxy")
        ).createEdition({
                name: "Nouns Vision Disco",
                symbol: "DISCO_GLASSES",
                editionSize: MAX_DISCO_SUPPLY,
                royaltyBPS: 20,
                fundsRecipient: payable(adrs.newAdminAddress),
                defaultAdmin: adrs.newAdminAddress,
                saleConfig: IERC721Drop.SalesConfiguration({
                    publicSaleStart: 0,
                    publicSaleEnd: 0,
                    presaleStart: 0,
                    presaleEnd: 0,
                    publicSalePrice: 0,
                    maxSalePurchasePerAddress: 0,
                    presaleMerkleRoot: bytes32(0)
                }),
                description: "This is an NFT collection of a physical, luxury version of the disco glasses only available to Noun holders. Each NFT is permanently burned to redeem a physical pair of sunglasses.",
                animationURI: "",
                imageURI: ""
            });

        adrs.nounsDiscoRedeemedAddress = ZoraNFTCreatorV1(
            vm.envAddress("creator_proxy")
        ).createEdition({
                name: "Nouns Vision Disco (Redeemed)",
                symbol: "DISCO_GLASSES_REDEEMED",
                editionSize: MAX_DISCO_SUPPLY,
                royaltyBPS: 100,
                fundsRecipient: payable(adrs.newAdminAddress),
                defaultAdmin: adrs.deployer,
                saleConfig: IERC721Drop.SalesConfiguration({
                    publicSaleStart: 0,
                    publicSaleEnd: 0,
                    presaleStart: 0,
                    presaleEnd: 0,
                    publicSalePrice: 0,
                    maxSalePurchasePerAddress: 0,
                    presaleMerkleRoot: bytes32(0)
                }),
                description: "This is a commemorative NFT given to holders of the nouns disco glasses after redemption.",
                animationURI: "",
                imageURI: ""
            });

        // 3 setup the ERC721NounsExchangeSwapMinter (standalone contract that takes nouns and nouns vision contracts)
        // set minter for NOUNS_VISION_DISCO as ERC721NounsExchangeSwapMinter contract
        ERC721NounsExchangeSwapMinter swapMinter = new ERC721NounsExchangeSwapMinter({
                _nounsToken: adrs.nounsTokenAddress,
                _discoGlasses: adrs.nounsDiscoAddress,
                _maxAirdropCutoffNounId: 200,
                _costPerNoun: PRICE_PER_DISCO,
                _initialOwner: adrs.deployer,
                _claimPeriodEnd: 0
            });

        ERC721Drop nounsDiscoDrop = ERC721Drop(payable(adrs.nounsDiscoAddress));
        bytes32 minterRole = nounsDiscoDrop.MINTER_ROLE();
        nounsDiscoDrop.grantRole(minterRole, address(swapMinter));

        // 4 setup the NounsVisionExchangeMinterModule
        //  from token = NOUNS_VISION_DISCO // to token = DISCO_VISION_REDEEMED
        NounsVisionExchangeMinterModule exchangeMinterModule = new NounsVisionExchangeMinterModule({
                _source: IERC721Drop(adrs.nounsDiscoAddress),
                _description: "Nouns Vision Disco Redeemed"
            });

        // Allow exchange module to mint redeemed tokens
        ERC721Drop(payable(adrs.nounsDiscoRedeemedAddress)).grantRole(
            bytes32(0),
            address(exchangeMinterModule)
        );

        // 6 exchange disco token with NounsVisionExchangeMinterModule to DISCO_VISION_REDEEMED

        // sets redeemed metadata renderer
        ERC721Drop(payable(adrs.nounsDiscoRedeemedAddress)).setMetadataRenderer(
                exchangeMinterModule,
                "0xcafe"
            );

        // Can be hard-coded into the drop with data from @salvino, can also be done via etherscan
        NounsVisionExchangeMinterModule.ColorSetting[]
            memory colorSettings = new NounsVisionExchangeMinterModule.ColorSetting[](
                1
            );
        colorSettings[0] = NounsVisionExchangeMinterModule.ColorSetting({
            color: "disco",
            maxCount: MAX_DISCO_SUPPLY,
            animationURI: "",
            imageURI: ""
        });
        exchangeMinterModule.setColorLimits(colorSettings);

        if (adrs.newAdminAddress != adrs.deployer) {
            ERC721Drop(payable(adrs.nounsDiscoRedeemedAddress)).grantRole(
                bytes32(0),
                address(adrs.newAdminAddress)
            );

            ERC721Drop(payable(adrs.nounsDiscoRedeemedAddress)).revokeRole(
                bytes32(0),
                address(adrs.deployer)
            );
        }
        vm.stopBroadcast();
    }
}
