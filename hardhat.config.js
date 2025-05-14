require("dotenv").config();
require("@nomicfoundation/hardhat-toolbox");
require("@nomiclabs/hardhat-ethers");

module.exports = {
    solidity: "0.8.28",
    networks: {
        fuji: {
            url: "https://api.avax-test.network/ext/bc/C/rpc",  // Correct Fuji RPC
            accounts: process.env.PRIVATE_KEY ? [process.env.PRIVATE_KEY] : [],
        },
    },
};
