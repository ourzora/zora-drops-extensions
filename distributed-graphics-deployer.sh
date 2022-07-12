
function create() {
  SHARED_NFT_LOGIC=0xbd677ce2635bab1041931e742d0984fadae44c41
  TARGET=src/distributed-graphics-editions/DistributedGraphicsEdition.sol:DistributedGraphicsEdition
  forge create $TARGET -i --rpc-url https://rinkeby.infura.io/v3/406a91f7df014ede94214f012cca2317 --constructor-args $SHARED_NFT_LOGIC
}

function verify() {
  TARGET_ADDR=0xb29680ce3e9f8daaa6c87c37b1501c59eec781c3
  SHARED_NFT_LOGIC=0xbd677ce2635bab1041931e742d0984fadae44c41
  TARGET_CONTRACT=src/distributed-graphics-editions/DistributedGraphicsEdition.sol:DistributedGraphicsEdition
  ARGS=$(cast abi-encode "constructor(address)" 0xbd677ce2635bab1041931e742d0984fadae44c41)
  echo $ARGS
  forge verify-contract --constructor-args $ARGS --chain rinkeby $TARGET_ADDR $TARGET_CONTRACT F3CECMYDCKR5SNEF1NSH46BF8VQWN3HAGXt
}


function create_mainnet() {
  SHARED_NFT_LOGIC=0x7eB947242dbF042e6388C329A614165d73548670
  TARGET=src/distributed-graphics-editions/DistributedGraphicsEdition.sol:DistributedGraphicsEdition
  forge create $TARGET -i --rpc-url https://mainnet.infura.io/v3/406a91f7df014ede94214f012cca2317 --constructor-args $SHARED_NFT_LOGIC
}

function verify_mainnet() {
  TARGET_ADDR=0xf5a459903cdb2044690cdfe59b6cd18f8252fa82
  SHARED_NFT_LOGIC=0x7eB947242dbF042e6388C329A614165d73548670
  TARGET_CONTRACT=src/distributed-graphics-editions/DistributedGraphicsEdition.sol:DistributedGraphicsEdition
  ARGS=$(cast abi-encode "a(address)" $SHARED_NFT_LOGIC)
  forge verify-contract --constructor-args $ARGS --chain mainnet $TARGET_ADDR $TARGET_CONTRACT F3CECMYDCKR5SNEF1NSH46BF8VQWN3HAGXt
}