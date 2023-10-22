import 'package:mario_blocks/board.dart';

import 'values.dart';

class Piece {
  // Tetris piece type
  Tetronimo type;

  Piece({required this.type});

  // List of integers representing a Tetranimo piece  (i.e. L, J, etc.)
  List<int> position = [];

  void  initializePiece() {
    switch (type) {
      case Tetronimo.L:
        position = [-26, -16, -6, -5];
        break;
      case Tetronimo.J:
        position = [-25, -15, -5, -6];
        break;
      case Tetronimo.I:
        position = [-4, -5, -6, -7];
        break;
      case Tetronimo.O:
        position = [-15, -16, -5, -6];
        break;
      case Tetronimo.S:
        position = [-15, -14, -6, -5];
        break;
      case Tetronimo.Z:
        position = [-17, -16, -6, -5];
        break;
      case Tetronimo.T:
        position = [-26, -16, -6, -15];
        break;
      default:
    }
  }

  void movePiece(Direction direction) {
    switch (direction) {
      case Direction.down:
        for (int i = 0; i < position.length; i++) {
          position[i] += rowLength;
        }
        break;
      case Direction.left:
        for (int i = 0; i < position.length; i++) {
          position[i] -= 1;
        }
        break;
      case Direction.right:
        for (int i = 0; i < position.length; i++) {
          position[i] += 1;
        }
        break;
      default:
    }
  }

  // Rotate piece clockwise
  // Note: 4 rotation state
  int rotationState = 1;
  void rotatePiece() {
    List<int> newPosition = [];

    switch (type) {
      case Tetronimo.L:
        switch (rotationState) {
          case 0:
            newPosition = [
                      position[1] - rowLength,
                      position[1],
                      position[1] + rowLength,
                      position[1] + rowLength + 1,
                    ];

            // Check position is valid before rotating piece
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;

              // Maintain the divisible by 4 when adding rotationState
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 1:
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowLength - 1,
            ];

            // Check position is valid before rotating piece
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;

              // Maintain the divisible by 4 when adding rotationState
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 2:
            newPosition = [
              position[1] + rowLength,
              position[1],
              position[1] - rowLength,
              position[1] - rowLength - 1,
            ];

            // Check position is valid before rotating piece
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;

              // Maintain the divisible by 4 when adding rotationState
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 3:
            newPosition = [
              position[1] - rowLength + 1,
              position[1],
              position[1] + 1,
              position[1] - 1,
            ];

            // Check position is valid before rotating piece
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;

              // Reset rotation state to 0
              rotationState = 0;
            }
            break;
        }
        break;

      case Tetronimo.J:
        switch (rotationState) {
          case 0:
            newPosition = [
                      position[1] - rowLength,
                      position[1],
                      position[1] + rowLength,
                      position[1] + rowLength - 1,
                    ];

            // Check position is valid before rotating piece
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;

              // Maintain the divisible by 4 when adding rotationState
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 1:
            newPosition = [
              position[1] - rowLength - 1,
              position[1],
              position[1] - 1,
              position[1] + 1,
            ];

            // Check position is valid before rotating piece
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;

              // Maintain the divisible by 4 when adding rotationState
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 2:
            newPosition = [
              position[1] + rowLength,
              position[1],
              position[1] - rowLength,
              position[1] - rowLength + 1,
            ];

            // Check position is valid before rotating piece
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;

              // Maintain the divisible by 4 when adding rotationState
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 3:
            newPosition = [
              position[1] + 1,
              position[1],
              position[1] - 1,
              position[1] + rowLength + 1,
            ];

            // Check position is valid before rotating piece
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;

              // Reset rotation state to 0
              rotationState = 0;
            }
            break;
        }
        break;

      case Tetronimo.I:
        switch (rotationState) {
          case 0:
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + 2,
            ];

            // Check position is valid before rotating piece
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;

              // Maintain the divisible by 4 when adding rotationState
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 1:
            newPosition = [
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] + 2 * rowLength,
            ];

            // Check position is valid before rotating piece
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;

              // Maintain the divisible by 4 when adding rotationState
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 2:
            newPosition = [
              position[1] + 1,
              position[1],
              position[1] - 1,
              position[1] - 2,
            ];

            // Check position is valid before rotating piece
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;

              // Maintain the divisible by 4 when adding rotationState
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 3:
            newPosition = [
              position[1] + rowLength,
              position[1],
              position[1] - rowLength,
              position[1] - 2 * rowLength ,
            ];

            // Check position is valid before rotating piece
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;

              // Reset rotation state to 0
              rotationState = 0;
            }
            break;
        }
        break;

      case Tetronimo.O:
        // O has no rotation
        break;

      case Tetronimo.S:
        switch (rotationState) {
          case 0:
            newPosition = [
              position[1],
              position[1] + 1,
              position[1] + rowLength - 1,
              position[1] + rowLength,
            ];

            // Check position is valid before rotating piece
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;

              // Maintain the divisible by 4 when adding rotationState
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 1:
            newPosition = [
              position[0] - rowLength,
              position[0],
              position[0] + 1,
              position[0] + rowLength + 1,
            ];

            // Check position is valid before rotating piece
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;

              // Maintain the divisible by 4 when adding rotationState
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 2:
            newPosition = [
              position[1],
              position[1] + 1,
              position[1] + rowLength - 1,
              position[1] + rowLength,
            ];

            // Check position is valid before rotating piece
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;

              // Maintain the divisible by 4 when adding rotationState
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 3:
            newPosition = [
              position[0] - rowLength,
              position[0],
              position[0] + 1,
              position[0] + rowLength + 1,
            ];

            // Check position is valid before rotating piece
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;

              // Reset rotation state to 0
              rotationState = 0;
            }
            break;
        }
        break;

      case Tetronimo.Z:
        switch (rotationState) {
          case 0:
            newPosition = [
              position[0] + rowLength - 2,
              position[1],
              position[2] + rowLength - 1,
              position[3] + 1,
            ];

            // Check position is valid before rotating piece
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;

              // Maintain the divisible by 4 when adding rotationState
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 1:
            newPosition = [
              position[0] - rowLength + 2,
              position[1],
              position[2] - rowLength + 1,
              position[3] - 1,
            ];

            // Check position is valid before rotating piece
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;

              // Maintain the divisible by 4 when adding rotationState
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 2:
            newPosition = [
              position[0] + rowLength - 2,
              position[1],
              position[2] + rowLength - 1,
              position[3] + 1,
            ];

            // Check position is valid before rotating piece
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;

              // Maintain the divisible by 4 when adding rotationState
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 3:
            newPosition = [
              position[0] - rowLength + 2,
              position[1],
              position[2] - rowLength + 1,
              position[3] - 1,
            ];

            // Check position is valid before rotating piece
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;

              // Reset rotation state to 0
              rotationState = 0;
            }
            break;
        }
        break;

      case Tetronimo.T:
        switch (rotationState) {
          case 0:
            newPosition = [
              position[2] - rowLength,
              position[2],
              position[2] + 1,
              position[2] + rowLength,
            ];

            // Check position is valid before rotating piece
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;

              // Maintain the divisible by 4 when adding rotationState
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 1:
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowLength,
            ];

            // Check position is valid before rotating piece
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;

              // Maintain the divisible by 4 when adding rotationState
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 2:
            newPosition = [
              position[1] - rowLength,
              position[1] - 1,
              position[1],
              position[1] + rowLength,
            ];

            // Check position is valid before rotating piece
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;

              // Maintain the divisible by 4 when adding rotationState
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 3:
            newPosition = [
              position[2] - rowLength,
              position[2] - 1,
              position[2],
              position[2] + 1,
            ];

            // Check position is valid before rotating piece
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;

              // Reset rotation state to 0
              rotationState = 0;
            }
            break;
        }
        break;
    }
  }

  // Check position is valid to rotate piece
  bool positionIsValid(int position) {
    int row = (position / rowLength).floor();
    int col = position % rowLength;

    // If the position is taken, return false
    if (row < 0 || col < 0 || gameBoard[row][col] != null) {
      return false;
    }

    return true;
  }

  // Check that the piece does not rotate through the left/right walls
  bool piecePositionIsValid(List<int> piecePosition) {
    bool firstColumnOccupied = false;
    bool lastColumnOccupied = false;

    for (int position in piecePosition) {

      // Return false if any position is already taken
      if (!positionIsValid(position)) {
        return false;
      }

      int col = position % rowLength;

      // Check if 1st column (0)
      if (col == 0) {
        firstColumnOccupied = true;
      }

      // Check if last column is occupied (rowLength - 1)
      if (col == rowLength - 1) {
        lastColumnOccupied = true;
      }
    }

    return !(firstColumnOccupied && lastColumnOccupied);
  }
}
