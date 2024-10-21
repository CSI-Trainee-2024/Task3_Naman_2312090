import 'dart:async';

import 'package:flutter/material.dart';
import 'package:minesweeper/main.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SplashState();
}

class SplashState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 4), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MyHomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromARGB(255, 234, 208, 151),
          Color.fromARGB(255, 170, 229, 232)
        ])),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 210,
            ),
            Image.asset("assets/mineSweeper.png"),
            SizedBox(
              height: 100,
            ),
            // Image.asset("assets/text.png"),
            Image.asset("assets/game.png")
          ],
        ),
      ),
    );
  }
}
