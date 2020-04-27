import 'package:flutter/material.dart';
import 'package:snake/snake.dart';
import 'package:snake/game.dart';

class SnakeScreen extends StatefulWidget {
  SnakeScreen({Key key}) : super(key: key);

  @override
  _SnakeScreenState createState() => _SnakeScreenState();
}

class _SnakeScreenState extends State<SnakeScreen> {
  @override
  Widget build(BuildContext context) {
    final DisplayGameState gameInfo = DisplayGame.of(context);
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 80,
            decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.rectangle,
                border: Border.all(width: 2.0, color: Colors.black)),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Best Scores: ${gameInfo.bestScore}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Score: ${gameInfo.score}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ]),
          ),
          Container(
            width: width,
            height: height - 80,
            color: Colors.green,
            child: Snake(width: width, height: height),
          ),
        ],
      ),
    );
  }
}
