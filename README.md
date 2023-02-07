# Extensions for ZORA NFT Drops

1. Distributed Graphics Editions - on-chain shuffled graphics.
2. Nouns Vision - Bucketed project redeem flow.
3. Signature Minter - Minter for editions based off of a user's signature.
4. Nouns vision exchange and burn contracts – example minter and burn contracts for exchanging nouns vision glasses.
4. Zorb minter - Minter for editions based off of Zorb ownership (or any other ERC721).


These contracts connect with ZORA drops contracts in order to allow additional features and extensions through:
1. Minting extensions
2. Metadata extensions

Both of these extensions can be the same thing.

Be aware that setting up these contracts you need to be aware that the caller is the NFT contract itself and other NFT contracts can point to your contract. Ensure to setup access controls accordingly.

This code is unaudited, requires review before use in production, and has no warranty associated.
