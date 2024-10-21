// ignore_for_file: prefer_const_constructors, sort_child_properties_last, library_private_types_in_public_api

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:minesweeper/theme/colors.dart';
import 'package:minesweeper/theme/titleData.dart';
import 'package:minesweeper/utilities/game_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MineSweeperGame game = MineSweeperGame();
  Timer? timer;
  int elapsedTime = 0;

  @override
  void initState() {
    super.initState();
    game.generateMap();
    startTimer();
  }

  //to set the timer
  void startTimer() {
    game.gameOver = false;
    elapsedTime = 0;
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      if (!game.gameOver) {
        setState(() {
          elapsedTime++;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        centerTitle: true,
        title: Text(
          "MineSweeper",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Titledata(
                icon: Icon(
                  Icons.flag,
                  color: AppColor.accentColor,
                  size: 34.0,
                ),
                color: AppColor.lightPrimaryColor,
                text: "${game.flagCount}",
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(8.0),
              ),
              Titledata(
                icon: Icon(
                  Icons.timer,
                  color: AppColor.accentColor,
                  size: 34.0,
                ),
                color: AppColor.lightPrimaryColor,
                text: "${elapsedTime}",
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            height: 500.0,
            padding: EdgeInsets.all(20.0),
            //color: AppColor.lightPrimaryColor,
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: MineSweeperGame.row,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0),
                itemCount: MineSweeperGame.cell,
                itemBuilder: (BuildContext ctx, index) {
                  Color cellColor = game.gameMap[index].reveal
                      ? AppColor.clickedCard
                      : (game.gameMap[index].flaged
                          ? Colors.yellow
                          : AppColor.lightPrimaryColor);
                  return GestureDetector(
                    onTap: game.gameOver
                        ? null
                        : () {
                            setState(() {
                              game.onClickedCell(game.gameMap[index]);
                            });
                          },
                    onDoubleTap: game.gameOver
                        ? null
                        : () {
                            setState(() {
                              /*game.gameMap[index].reveal
                                  ? "${game.gameMap[index].content}"
                                  : (game.gameMap[index].flaged ? "🚩" : "");

                              if (!game.gameMap[index].reveal) {
                                // Only flag if the cell is not revealed
                                game.gameMap[index].flaged =
                                    !game.gameMap[index].flaged;
                                game.flagCount += game.gameMap[index].flaged
                                    ? -1
                                    : 1;
                              }*/

                              game.onDoubleClickedCell(game.gameMap[index]);
                            });
                          },
                    child: Container(
                      decoration: BoxDecoration(
                          color: cellColor,
                          borderRadius: BorderRadius.circular(6.0)),
                      child: Center(
                        child: Text(
                          game.gameMap[index].reveal
                              ? "${game.gameMap[index].content}"
                              : "",
                          /* : (game.gameMap[index].flaged
                                   ? "🚩"
                                   : ""), */ //Icon(Icons.flag).toString()
                          style: TextStyle(
                              color: game.gameMap[index].reveal
                                  ? game.gameMap[index].content == "X"
                                      ? Colors.red
                                      : AppColor.letterColor[
                                          game.gameMap[index].content]
                                  : Colors.transparent,
                              fontSize: 40.0),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          Text(
            game.gameOver ? "You Loose" : "",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 32.0),
          ),
          SizedBox(
            height: 20.0,
          ),
          RawMaterialButton(
            onPressed: () {
              setState(() {
                game.resetGame();
                print("Game map length: ${game.gameMap.length}");
                game.flagCount = 5;


                timer?.cancel();
               // game.gameOver = true;
              });
            },
            fillColor: AppColor.lightPrimaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.restart_alt,
                  size: 40,
                  color: AppColor.accentColor,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Reset",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            shape: StadiumBorder(),
            padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
          ),
          SizedBox(
            height: 10.0,
          )
        ],
      ),
    );
  }
}
