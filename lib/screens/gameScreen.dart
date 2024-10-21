import 'package:flutter/material.dart';
import 'package:minesweeper/screens/Home_screen.dart';

class GameScreen extends StatefulWidget {
  @override
  GameScreenState createState() => GameScreenState();
}

class GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 186, 189, 189),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
          },
          child: Container(
            height: 60,
            width: 200,
            child: Center(
              child: Text(
                "Start Game",
                style: TextStyle(fontSize: 30),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
