const { deflateRawSync } = require('zlib');

console.log(deflateRawSync(Buffer.from(process.argv[2].replace('0x', ''), 'hex')).toString('hex'));