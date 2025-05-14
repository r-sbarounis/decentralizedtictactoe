const hre = require("hardhat");

async function main() {
    const [deployer] = await hre.ethers.getSigners();
    console.log("Deploying contract with account:", 'ce925a61bd5fabe2adaab3f9592bdcb542e50390473ebf1c8d3b6d569afcc499');

    // Use deployer's address for both players (no ENS name)
    const player2 = deployer.address; // Use the same address for player2 for testing

    const TicTacToe = await hre.ethers.getContractFactory("TicTacToe");
    const ticTacToe = await TicTacToe.deploy(player2);  // Direct wallet address

    await ticTacToe.deployed();

    console.log("TicTacToe contract deployed at:", ticTacToe.address);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
