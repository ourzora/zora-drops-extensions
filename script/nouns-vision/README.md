
# RunNounsVision

An integration test for nouns vision that goes through all the steps for testing.
Meant to be run in simulation mode only.

```
creatorProxy=0xb9583D05Ba9ba8f7F14CCEe3Da10D2bc0A72f519 deployer=0x9444390c01Dd5b7249E53FAc31290F7dFF53450D forge script ./script/nouns-vision/RunNounsVisionMultistep.sol --rpc-url $ETH_RPC_GOERLI
```

# DeployNounsVision

Deploy:
```
creator_proxy=0xb9583D05Ba9ba8f7F14CCEe3Da10D2bc0A72f519 deployer=0x9444390c01Dd5b7249E53FAc31290F7dFF53450D nouns_token=0x40c8C83853C1F62eb24310333fe114484F69aA79 new_admin_address=0x9444390c01Dd5b7249E53FAc31290F7dFF53450D  forge script ./script/nouns-vision/DeployNounsVisionMultistep.sol --rpc-url $ETH_RPC_GOERLI --broadcast --interactives 1 --verify --etherscan-api-key $ETHERSCAN_API_KEY
```

Variables:
```
creator_proxy= from https://github.com/ourzora/zora-drops-contracts/blob/main/addresses/1.json ZORA_NFT_CREATOR_PROXY change 1 to the network id
deployer= user deploying contracts
nouns_token= address to use as the nouns token
new_admin_address= address to set as the admin for the new drop contract. if the same as deployer, the address is not reset but if it's different permissions are removed from the deployer and set to this address

$ETH_RPC - RPC URI (per network)
$ETHERSCAN_API_KEY - get from etherscan.io for verification
