import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:marboj_flutter_tetris/piece.dart';
import 'package:marboj_flutter_tetris/pixel.dart';
import 'package:marboj_flutter_tetris/values.dart';

/*
  GAME BOARD

  This is a 2x2 grid with 'null' representing an empty space.
  A non-empty space will have the color to represent the landed pieces.
 */
List<List<Tetronimo?>> gameBoard = List.generate(
  colLength,
  (i) => List.generate(
      rowLength,
      (j) => null
  ),
);

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  Piece currentPiece = Piece(type: Tetronimo.T); // Current Tetris piece
  int currentScore = 0;
  bool gameIsOver = false;

  // DateTime? startGameTime;
  // final Map<int, int> durations = {
  //   0: 800,
  //   1: 700,
  //   2: 600
  // };
  int currentDuration = 0;

  @override
  void initState() {
    super.initState();

    startGame();
  }

  void startGame() {
    // startGameTime = DateTime.now();

    // Start game with determined piece
    // currentPiece = Piece(type: Tetronimo.T);
    // currentPiece.initializePiece();

    // OR start game with random piece
    createNewPiece();

    // Frame refresh rate
    // Duration frameRate = Duration(milliseconds: durations[currentDuration!]!);
    Duration frameRate = Duration(milliseconds: 600);
    gameLoop(frameRate);
  }

  void gameLoop(Duration frameRate) {
    Timer.periodic(
        frameRate,
        (timer) {
            setState(() {
              // Clear the lines
              clearLines();

              // Check for piece landing
              checkLanding();

              if (gameIsOver) {
                timer.cancel();
                showGameOverDialog();
              }

              // var currentTime = DateTime.now();
              // var lapse = (startGameTime!.minute - currentTime.minute).abs();
              // if (lapse == 3) {
              //
              // }

              // Move current piece down
              currentPiece.movePiece(Direction.down);
            });
        }
    );
  }

  void showGameOverDialog() {
    showDialog(
        context:  context,
        builder: (context) => AlertDialog(
          title: Text('Game Over'),
          content: Text("Your score is: $currentScore"),
          actions: [
            TextButton(
                onPressed: () {
                  // Reset the game
                  resetGame();

                  Navigator.pop(context); // remove dialog
                },
                child: Text('Play Again'))
          ],
        ));
  }

  void resetGame() {
    gameBoard = List.generate(
      colLength,
          (i) => List.generate(
          rowLength,
              (j) => null
      ),
    );

    currentScore = 0;
    gameIsOver = false;

    createNewPiece();

    startGame();
  }

  // Returns true if there is collision
  bool checkCollision(Direction direction) {
    // Loop through all position of the current piece
    for (int i = 0; i < currentPiece.position.length; i++) {
      int row = (currentPiece.position[i] / rowLength).floor();
      int col = currentPiece.position[i] % rowLength;

      // Adjust the row,col based on direction
      if (direction == Direction.left) {
        col -= 1;
      } else if (direction == Direction.right) {
        col += 1;
      } else if (direction == Direction.down) {
        row += 1;
      }

      // Check if the piece is out-of-bounds
      // a) Too low = row >= colLength
      // b) Too far to the left = col < 0
      // c) Too far to the right = col >= rowLength
      if (row >= colLength || col < 0 || col >= rowLength) {
        return true;
      }

      // Check if the current position has an existing piece
      if (row >= 0 && gameBoard[row][col] != null) {
        return true;
      }
    }

    // No collision detected
    return false;
  }

  void checkLanding() {
    // If going down encounters some piece
    if (checkCollision(Direction.down)) {
      // Mark the position as occupied in the game board
      for (int i = 0; i < currentPiece.position.length; i++) {
        int row = (currentPiece.position[i] / rowLength).floor();
        int col = currentPiece.position[i] % rowLength;

        if (row >= 0 && col >= 0) {
          gameBoard[row][col] = currentPiece.type;
        }
      }

      // After piece has landed, create the next piece
      createNewPiece();
    }
  }

  void createNewPiece() {
    // Generate a random piece
    Random random = Random();

    Tetronimo randomType = Tetronimo.values[random.nextInt(Tetronimo.values.length)];
    currentPiece = Piece(type: randomType);
    currentPiece.initializePiece();

    // Check if the newly created piece is at the top row
    if (isGameOver()) {
      gameIsOver = true;
    }
  }

  void moveLeft() {
    // Make sure the move is valid before moving piece
    if (!checkCollision(Direction.left)) {
      setState(() {
        currentPiece.movePiece(Direction.left);
      });
    }
  }

  void moveRight() {
// Make sure the move is valid before moving piece
    if (!checkCollision(Direction.right)) {
      setState(() {
        currentPiece.movePiece(Direction.right);
      });
    }
  }

  void rotatePiece() {
    setState(() {
      currentPiece.rotatePiece();
    });
  }

  // Clear completed lines (row)
  void clearLines() {
    // Step 1. Loop thru each row of the game board from bottom to top
    for (int row = colLength - 1; row >= 0; row--) {
      // Step 2. Initialize a variable to keep track whether row is full
      bool rowIsFull = true;

      // Step 3. Check of row is full
      for (int col = 0; col < rowLength; col++) {
        if (gameBoard[row][col] == null) {
          rowIsFull = false;
          break;
        }
      }

      // Step 4. If row full, clear row and shift rows down
      if (rowIsFull) {
        // Move all rows above the clear row down by 1 position
        for (int currentRow = row; currentRow > 0; currentRow--) {
          // Replace currentRow with the row above it
          gameBoard[currentRow] = List.from(gameBoard[currentRow - 1]);
        }

        // Set the top row to empty
        gameBoard[0] = List.generate(row, (index) => null);

        // Increase score
        currentScore++;
      }
    }
  }

  bool isGameOver() {
    // Check top row has any piece or part of a piece then it's game over
    for (int col = 0; col < rowLength; col++) {
      if (gameBoard[0][col] != null) {
        return true;
      }
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: rowLength),
                itemCount: rowLength * colLength,
                itemBuilder: (context, index) {

                  // Get the row and col of each index
                  int row = (index / rowLength).floor();
                  int col = index % rowLength;

                  // Current piece
                  if (currentPiece.position.contains(index)) {
                    return Pixel(
                      color: currentPiece.type.color,
                    );
                  } else if (gameBoard[row][col] != null) {
                    // Landed piece
                    return Pixel(
                      color: (gameBoard[row][col])?.color ?? Colors.white,
                    );
                  }  else {
                    // Blank pixel
                    return Pixel(
                      color: Colors.grey[850],
                    );
                  }
                },
                physics: const NeverScrollableScrollPhysics(),
              ),
            ),

            // Score
            Text('Score: $currentScore',
            style: const TextStyle(color: Colors.white, fontSize: 20),
            ),

            // GAME Controls
            Padding(
              padding: const EdgeInsets.only(bottom: 25.0, top: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Left
                  IconButton(
                      color: Colors.white,
                      onPressed: moveLeft,
                      icon: const Icon(Icons.arrow_back_ios_new)
                  ),

                  // Rotate
                  IconButton(
                      color: Colors.white,
                      onPressed: rotatePiece,
                      icon: const Icon(Icons.rotate_right)
                  ),

                  // Right
                  IconButton(
                      color: Colors.white,
                      onPressed: moveRight,
                      icon: const Icon(Icons.arrow_forward_ios)
                  ),
              ],),
            )
          ],
        ),
      ),
    );
  }
}
