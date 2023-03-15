const ethers = require('ethers')


async function createBytes(params) {
    const name = params[0];
    const bytes = ethers.encodeBytes32String(name);

    console.log("name: ", bytes);
}

createBytes(process.argv.slice(2));