import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:snake/tools/infoGame.dart';
import 'package:snake/helpers/snakeTools.dart';

class Snake extends StatefulWidget {
  final double width;
  final double height;
  Snake({Key key, this.width, this.height}) : super(key: key);

  _SnakeState createState() => _SnakeState();
}

class _SnakeState extends State<Snake> {
  bool _start = false;
  bool _add = false;
  bool _isEaten = true;
  bool collision = false;
  int oldScore = 0;
  int score = 0;
  Timer timer;
  int duration = 400;
  List<Positioned> snakePosition = List();
  Positioned cubePosition;
  Point cubePoint;
  var snakeBody = [];

  @override
  Widget build(BuildContext context) {
    if (_start == true && collision == false) {
      if (_isEaten == true) {
        _isEaten = false;
        cubePoint = generateCubePoint(this.widget.width, this.widget.height);
        cubePosition = generateCubePosition(cubePoint);
      }
      if (oldScore != score) {
        oldScore = score;
        timer.cancel();
        duration -= 10;
        if (duration <= 40) duration = 40;
        timer =
            Timer.periodic(Duration(milliseconds: duration), getSnakePosition);
      }
      return screenDrawing(cubePosition, cubePoint);
    } else {
      return startPlayer();
    }
  }

  Widget startPlayer() {
    return IconButton(
      icon: Icon(Icons.play_arrow),
      iconSize: 80.0,
      onPressed: () {
        _start = true;
        _add = false;
        _isEaten = true;
        duration = 400;
        timer =
            Timer.periodic(Duration(milliseconds: duration), getSnakePosition);
        final initPoint = this.widget.width ~/ 2 ~/ 10;
        final InfoGameState gameInfo = InfoGame.of(context);
        gameInfo.reinitInfo();
        snakeBody = [
          Point(initPoint, initPoint - 1),
          Point(initPoint, initPoint),
          Point(initPoint, initPoint + 1),
        ];
        collision = false;
      },
    );
  }

  Widget screenDrawing(Positioned cubePosition, Point cubePoint) {
    int index = 0;
    snakePosition = [cubePosition];
    snakeBody.forEach((elem) {
      snakePosition.add(
        Positioned(
          child: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: (index == (snakeBody.length - 1) && _add == true)
                  ? Colors.green
                  : Colors.red,
              shape: BoxShape.rectangle,
              border: Border.all(width: 0, color: Colors.green),
            ),
          ),
          left: (elem.x * 10).toDouble(),
          top: (elem.y * 10).toDouble(),
        ),
      );
      index += 1;
    });
    if (snakeBody[0].x == cubePoint.x && snakeBody[0].y == cubePoint.y) {
      _isEaten = true;

      final InfoGameState gameInfo = InfoGame.of(context);
      gameInfo.updateScore();
      score += 1;
    } else if (index == snakeBody.length && index > 1 && _add == true) {
      snakeBody.removeLast();
    }
    _add = false;
    return Stack(children: snakePosition);
  }

  void getSnakePosition(Timer timer) {
    final InfoGameState gameInfo = InfoGame.of(context);

    setState(() {
      Point headSnake = snakeBody[0];
      switch (gameInfo.info.move) {
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
      collision = checkCollision();
    });
  }

  bool checkCollision() {
    bool _isCollised = false;
    if ((snakeBody[0].x >= this.widget.width / 10 - 1 || snakeBody[0].x < 0) ||
        (snakeBody[0].y >= (this.widget.height - 80) / 10 - 1 ||
            snakeBody[0].y < 0)) {
      timer.cancel();
      _isCollised = true;
    }
    int i = 0;
    snakeBody.forEach((element) async {
      if (i != 0 &&
          snakeBody[0].x == element.x &&
          snakeBody[0].y == element.y) {
        timer.cancel();
        _isCollised = true;
      }
      i += 1;
    });
    return _isCollised;
  }
}
