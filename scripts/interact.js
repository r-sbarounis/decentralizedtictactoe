const hre = require("hardhat");

async function main() {
    const ticTacToeAddress = "0xbF6c350c8c9327D92d2519A1994C1419bBbb89E8";  // Your deployed contract address

    // Get the contract factory and attach to deployed address
    const TicTacToe = await hre.ethers.getContractFactory("TicTacToe");
    const ticTacToe = await TicTacToe.attach(ticTacToeAddress);

    console.log("Interacting with contract at:", ticTacToeAddress);

    // Example: Making a move as player1
    const tx = await ticTacToe.makeMove(0, 0); // Player places a move at (0,0)
    await tx.wait(); // Wait for transaction confirmation
    console.log("Move made at (0,0)");

    // Fetch and log the updated board state
    const board = await ticTacToe.board(0, 0);
    console.log("Board state at (0,0):", board.toString());
}

// Run script
main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
