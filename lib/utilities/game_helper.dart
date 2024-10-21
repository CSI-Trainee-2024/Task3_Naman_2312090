import 'package:flutter/material.dart';
import 'dart:math';

import 'package:minesweeper/screens/Home_screen.dart';

class MineSweeperGame {
  //game variables
  static int row = 6;
  static int col = 6;
  static int cell = row * col;
  bool gameOver = false;
  int flagCount = 5;
  List<Cell> gameMap = [];
  static List<List<dynamic>> map = List.generate(
      row, (x) => List.generate(col, (y) => Cell(x, y, "", false)));

//function to generate a Map
  void generateMap() {
    placeMines(10);
    for (int i = 0; i < row; i++) {
      for (int j = 0; j < col; j++) {
        gameMap.add(map[i][j]);
      }
    }
  }

  void resetGame() {
    map = List.generate(
        row, (x) => List.generate(col, (y) => Cell(x, y, "", false)));
    gameMap.clear();
    generateMap();
    gameOver = false;
  }

//function to place mines randomly
  static void placeMines(int minesNumber) {
    Random random = Random();
    for (int i = 0; i < minesNumber; i++) {
      int mineRow = random.nextInt(row);
      int mineCol = random.nextInt(col);
      map[mineRow][mineCol] = Cell(mineRow, mineCol, "X", false);
    }
  }

//function to show all hidden mines when loose
  void showMines() {
    for (int i = 0; i < row; i++) {
      for (int j = 0; j < col; j++) {
        if (map[i][j].content == "X") {
          map[i][j].reveal = true;
        }
      }
    }
  }

//function to reveal when clicked on cell
  void onClickedCell(Cell cell) {
    //checking if we clicked on mine
    if (cell.content == "X") {
      showMines();
      gameOver = true;
      //to stop the timer
     // (cell.row as _HomeScreenState).timer?.cancel(); 
    } else {
      //calculate the scoring steps
      int mineCount = 0;
      int cellRow = cell.row;
      int cellCol = cell.col;

      for (int i = max(cellRow - 1, 0); i < min(cellRow + 1, row - 1); i++) {
        for (int j = max(cellCol - 1, 0); j < min(cellCol + 1, row - 1); j++) {
          if (map[i][j].content == "X") {
            mineCount++;
          }
        }
      }

      cell.content = mineCount;
      cell.reveal = true;
      if (mineCount == 0) {
        //reveal all the adjacent cell until we get a number
        for (int i = max(cellRow - 1, 0); i < min(cellRow + 1, row - 1); i++) {
          for (int j = max(cellCol - 1, 0);
              j <= min(cellCol + 1, row - 1);
              j++) {
            if (map[i][j].content == "") {
              onClickedCell(map[i][j]); //get a recursive function
            }
          }
        }
      }
    }
  }

  void onDoubleClickedCell(Cell cell) {
    if (cell.reveal) {
      return; //if the cell is revelead do nothing
    }
    if (cell.flaged) {
      cell.flaged = false;
      flagCount++; //increment flag if it is removed
    } else if (flagCount > 0) {
      cell.flaged = true;
      flagCount--; //decrease if it is used
    }
  }
}

class Cell {
  int row;
  int col;
  dynamic content;
  bool reveal = false;
  bool flaged = false;
  Cell(this.col, this.row, this.content, this.reveal);
}
