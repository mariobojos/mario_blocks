// Grid dimensions
import 'package:flutter/material.dart';

int rowLength = 10;
int colLength = 15;

enum Direction{
  left,
  right,
  down,
}

// Using enhanced enum
enum Tetronimo {
  L(Colors.orange),
  J(Colors.blue),
  I(Colors.pink),
  O(Colors.yellow),
  S(Colors.green),
  Z(Colors.red),
  T(Colors.purple);

  const Tetronimo(this.color);
  final Color color;
}
  /*

  o
  o
  o o,

    0
    0
  0 0,

  o
  o
  o,

  o o
  o o,

    o o
  o o,

  o o
    o o,

  o
  o o
  o,


   */


// const Map<Tetronimo, Colors> tetronimoColors = {
//   Tetronimo.L: Colors.amber,
//
// };