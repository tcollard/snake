import 'package:flutter/material.dart';
import 'package:snake/tools/infoGame.dart';
import 'package:snake/screen.dart';
import 'package:swipedetector/swipedetector.dart';

class Controller extends StatefulWidget {
  Controller({Key key}) : super(key: key);

  @override
  _ControllerState createState() => _ControllerState();
}

class _ControllerState extends State<Controller> {
  @override
  Widget build(BuildContext context) {
    final InfoGameState gameInfo = InfoGame.of(context);

    return SwipeDetector(
      onSwipeUp: () {
        if (gameInfo.info.move != 'Down') {
          setState(() {
            gameInfo.changeDirection('Up');
          });
        }
      },
      onSwipeDown: () {
        if (gameInfo.info.move != 'Up') {
          setState(() {
            gameInfo.changeDirection('Down');
          });
        }
      },
      onSwipeLeft: () {
        if (gameInfo.info.move != 'Right') {
          setState(() {
            gameInfo.changeDirection('Left');
          });
        }
      },
      onSwipeRight: () {
        if (gameInfo.info.move != 'Left') {
          setState(() {
            gameInfo.changeDirection('Right');
          });
        }
      },
      swipeConfiguration: SwipeConfiguration(
        verticalSwipeMinDisplacement: 20.0,
        verticalSwipeMinVelocity: 50,
        horizontalSwipeMinDisplacement: 20.0,
        horizontalSwipeMinVelocity: 50,
      ),
      child: GestureDetector(
        onLongPressStart: (toto) {
          gameInfo.updateAcceleration();
        },
        onLongPressEnd: (toto) {
          gameInfo.updateAcceleration();
        },
        child: SnakeScreen()),
    );
  }
}
