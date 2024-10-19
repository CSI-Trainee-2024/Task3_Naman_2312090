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

  @override
  void initState() {
    super.initState();
    game.generateMap();
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
                text: "10",
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
                text: "10:34",
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
                      : AppColor.lightPrimaryColor;
                  return GestureDetector(
                    onTap: game.gameOver
                        ? null
                        : () {
                            setState(() {
                              game.onClickedCell(game.gameMap[index]);
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
                game.gameOver = true;
              });
            },
            fillColor: AppColor.lightPrimaryColor,
            child: Text(
              "Repeat",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold),
            ),
            shape: StadiumBorder(),
            padding: EdgeInsets.symmetric(horizontal: 64.0, vertical: 18.0),
          ),
          SizedBox(
            height: 10.0,
          )
        ],
      ),
    );
  }
}
