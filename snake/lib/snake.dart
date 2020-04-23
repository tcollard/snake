import 'dart:math';
import 'package:flutter/material.dart';

class Snake extends StatefulWidget {
  Snake({Key key}) : super(key: key);

  @override
  _SnakeState createState() => _SnakeState();
}

class _SnakeState extends State<Snake> {
  var snakeBody;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: printSnake(),
    );
  }

  void startSnake() {
    setState(() {
      print('Start Snake');
      final initPoint = (360 / 2 / 50);
      snakeBody = [
        Point(initPoint, initPoint + 1),
        Point(initPoint, initPoint),
        Point(initPoint, initPoint - 1),
      ];
    });
  }

  Widget printSnake() {
    startSnake();
    List<Positioned> snakePosition = List();
    snakeBody.forEach((elem) {
      snakePosition.add(Positioned(
        child: Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: Colors.red,
            shape: BoxShape.rectangle,
          ),
        ),
        left: elem.x * 10,
        right: elem.y * 10,
      ));
    });
    print('Return Snack: $snakePosition');
    return Stack(children: snakePosition);
    //   return Text(
    //           'Snake Test',
    //           style: TextStyle(color: Colors.white),
    //         );
  }
}

/*
To Do:
  - Create a snake line of N length
  - Move it :
    - Remove last position of snake
    - Add new one on the top of direction
*/
