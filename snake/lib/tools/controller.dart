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
      onSwipeUp: () async {
        if (gameInfo.info.move != 'Down') {
          setState(() {
            gameInfo.changeDirection('Up');
          });
        }
      },
      onSwipeDown: () async {
        if (gameInfo.info.move != 'Up') {
          setState(() {
            gameInfo.changeDirection('Down');
          });
        }
      },
      onSwipeLeft: () async {
        if (gameInfo.info.move != 'Right') {
          setState(() {
            gameInfo.changeDirection('Left');
          });
        }
      },
      onSwipeRight: () async {
        if (gameInfo.info.move != 'Left') {
          setState(() {
            gameInfo.changeDirection('Right');
          });
        }
      },
      swipeConfiguration: SwipeConfiguration(
        verticalSwipeMinDisplacement: 10.0,
        verticalSwipeMinVelocity: 20,
        horizontalSwipeMinDisplacement: 10.0,
        horizontalSwipeMinVelocity: 20,
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
