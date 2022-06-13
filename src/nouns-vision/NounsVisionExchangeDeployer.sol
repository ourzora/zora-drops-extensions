// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import {ZoraNFTCreatorV1} from "zora-drops-contracts/ZoraNFTCreatorV1.sol";
import {IERC721Drop} from "zora-drops-contracts/interfaces/IERC721Drop.sol";
import {SharedNFTLogic} from "zora-drops-contracts/utils/SharedNFTLogic.sol";
import {NounsVisionExchangeMinterModule} from "./NounsVisionExchangeMinterModule.sol";

contract NounsVisionExchangeDeployer {
    constructor(
        address payable admin,
        address creator,
        SharedNFTLogic sharedNFTLogic,
        IERC721Drop sourceContract
    ) {
        NounsVisionExchangeMinterModule exchangeModule = new NounsVisionExchangeMinterModule(
                IERC721Drop(sourceContract),
                sharedNFTLogic
            );
        ZoraNFTCreatorV1(creator).setupDropsContract(
            "Nouns Vision Exchanged",
            "NOUNSVISIONREDEEMED",
            admin,
            // edition size
            7000,
            // royalty bps
            1000,
            admin,
            IERC721Drop.SalesConfiguration({
                publicSaleStart: 0,
                publicSaleEnd: 0,
                presaleStart: 0,
                presaleEnd: 0,
                publicSalePrice: 0,
                maxSalePurchasePerAddress: 0,
                presaleMerkleRoot: 0x0
            }),
            exchangeModule,
            ""
        );
    }
}
