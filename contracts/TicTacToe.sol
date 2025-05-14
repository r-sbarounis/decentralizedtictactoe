// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TicTacToe {
    address public player1;
    address public player2;
    address public winner;
    uint8[3][3] public board;
    bool public gameActive;
    address public currentPlayer;

    event GameStarted(address indexed player1, address indexed player2);
    event MoveMade(address indexed player, uint8 row, uint8 col);
    event GameWon(address indexed winner);
    event GameDraw();

    constructor() {
        gameActive = false;
    }

    function startGame(address _player2) external {
        require(!gameActive, "Game already active");
        player1 = msg.sender;
        player2 = _player2;
        currentPlayer = player1;
        gameActive = true;
        emit GameStarted(player1, player2);
    }

    function makeMove(uint8 row, uint8 col) external {
        require(gameActive, "No active game");
        require(msg.sender == currentPlayer, "Not your turn");
        require(row < 3 && col < 3, "Invalid move");
        require(board[row][col] == 0, "Cell already taken");

        board[row][col] = (currentPlayer == player1) ? 1 : 2;
        emit MoveMade(currentPlayer, row, col);

        if (checkWinner()) {
            winner = currentPlayer;
            gameActive = false;
            emit GameWon(winner);
        } else if (isBoardFull()) {
            gameActive = false;
            emit GameDraw();
        } else {
            currentPlayer = (currentPlayer == player1) ? player2 : player1;
        }
    }

    function checkWinner() internal view returns (bool) {
        for (uint8 i = 0; i < 3; i++) {
            if (board[i][0] != 0 && board[i][0] == board[i][1] && board[i][1] == board[i][2]) return true;
            if (board[0][i] != 0 && board[0][i] == board[1][i] && board[1][i] == board[2][i]) return true;
        }
        if (board[0][0] != 0 && board[0][0] == board[1][1] && board[1][1] == board[2][2]) return true;
        if (board[0][2] != 0 && board[0][2] == board[1][1] && board[1][1] == board[2][0]) return true;
        return false;
    }

    function isBoardFull() internal view returns (bool) {
        for (uint8 i = 0; i < 3; i++) {
            for (uint8 j = 0; j < 3; j++) {
                if (board[i][j] == 0) return false;
            }
        }
        return true;
    }
}
