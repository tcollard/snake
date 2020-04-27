import 'dart:async';
import 'package:flutter/material.dart';
import 'package:snake/game.dart';

class Snake extends StatefulWidget {
  final move;
  Snake({this.move});

  @override
  _SnakeState createState() => _SnakeState();
}

class _SnakeState extends State<Snake> {
  var snakeBody;
  Timer timer;
  List<Positioned> snakePosition = List();
  bool _add = false;

  @override
  void initState() {
    timer = Timer.periodic(Duration(milliseconds: 400), getSnakeNewPosition);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: snakeDrawing(),
    );
  }

  Widget snakeDrawing() {
    if (snakeBody.length > 0) {
      int index = 0;
      snakeBody.forEach((elem) {
        snakePosition.add(
          Positioned(
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: ((index == (snakeBody.length - 1) &&
                            index != 0 &&
                            _add == true) ||
                        DisplayGame.of(context).start == false)
                    ? Colors.green
                    : Colors.red,
                shape: BoxShape.rectangle,
                border: Border.all(width: 0, color: Colors.green),
              ),
            ),
            left: elem.x * 10,
            top: elem.y * 10,
          ),
        );
        index += 1;
      });
      if (index == snakeBody.length && index > 1 && _add == true)
        snakeBody.removeLast();
      setState(() {
        _add = false;
      });
      return Stack(children: snakePosition);
    } else {
      return null;
    }
  }

  void getSnakeNewPosition(Timer timer) {
    final DisplayGameState gameInfo = DisplayGame.of(context);
    setState(() {
      if (gameInfo.start == false) {
        final initPoint = 360 / 2 / 10;
        snakeBody = [
          Point(initPoint, initPoint - 1),
          Point(initPoint, initPoint),
          Point(initPoint, initPoint + 1),
        ];
      } else {
        Point headSnake = snakeBody[0];
        switch (gameInfo.move) {
          case 'Down':
            snakeBody.insert(0, Point(headSnake.x, headSnake.y + 1));
            break;
          case 'Left':
            snakeBody.insert(0, Point(headSnake.x - 1, headSnake.y));
            break;
          case 'Right':
            snakeBody.insert(0, Point(headSnake.x + 1, headSnake.y));
            break;
          default:
            snakeBody.insert(0, Point(headSnake.x, headSnake.y - 1));
        }
        _add = true;
      }
    });
  }
}

class Point {
  double x;
  double y;

  Point(double x, double y) {
    this.x = x;
    this.y = y;
  }
}
