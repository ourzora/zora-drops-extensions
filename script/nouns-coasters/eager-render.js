// 1. Import modules.
const { createPublicClient, http } =require('viem')
const { mainnet } =require('viem/chains')

// 2. Set up your client with desired chain & transport.
const client = createPublicClient({
  chain: mainnet,
  transport: http(process.env.ETH_RPC),
})

async function main() {

const address = '0xf3d27d5143C92b5B2618AB46dB1b7666350353B7'

// const rendererResponse = await fetch(`https://ether.actor/${address}/metadataRenderer`)
const rendererAddress = '0x6968155764dbd64b417603e314008516c42c9026'//await rendererResponse.text()

const abi = await fetch(`https://ether.actor/${rendererAddress}/abi.json`)
const abiJson = await abi.json()

for (var tokenId = 0; tokenId < 4000; tokenId++) {
  const response = await client.readContract({
    address: rendererAddress,
    abi: abiJson,
    functionName: "getAttributes",
    args: [address, tokenId]
  })
  const uri = `https://api.zora.co/renderer/stack-images${response[1]}`;
  console.log(uri)
  console.log('')
  fetch(uri)
}

}

main();

