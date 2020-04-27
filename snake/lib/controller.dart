import 'package:flutter/material.dart';
import 'package:snake/game.dart';

class SnakeController extends StatefulWidget {
  const SnakeController();

  @override
  _SnakeControllerState createState() => _SnakeControllerState();
}

class _SnakeControllerState extends State<SnakeController> {
  @override
  Widget build(BuildContext context) {
    final DisplayGameState gameInfo = DisplayGame.of(context);
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: RaisedButton(
            onPressed: () {
              if (gameInfo.move != 'Down') {
                setState(() {
                  gameInfo.changeDirection('Up');
                });
              }
            },
            color: Colors.orangeAccent,
            child: Icon(Icons.keyboard_arrow_up),
          ),
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: RaisedButton(
                  onPressed: () {
                    if (gameInfo.move != 'Right') {
                      setState(() {
                        gameInfo.changeDirection('Left');
                      });
                    }
                  },
                  color: Colors.orangeAccent,
                  child: Icon(Icons.keyboard_arrow_left),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: RaisedButton(
                  onPressed: () {
                    if (gameInfo.move != 'Left') {
                      setState(() {
                        gameInfo.changeDirection('Right');
                      });
                    }
                  },
                  color: Colors.orangeAccent,
                  child: Icon(Icons.keyboard_arrow_right),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: RaisedButton(
            onPressed: () {
              if (gameInfo.move != 'Up') {
                setState(() {
                  gameInfo.changeDirection('Down');
                });
              }
            },
            color: Colors.orangeAccent,
            child: Icon(Icons.keyboard_arrow_down),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: RaisedButton(
              onPressed: () {
                print('Start game');
                setState(() {
                  gameInfo.startGame();
                });
              },
              color: Colors.blueAccent,
              child: Icon(Icons.play_arrow)),
        ),
      ],
    );
  }
}
