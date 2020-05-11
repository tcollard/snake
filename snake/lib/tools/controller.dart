import 'package:flutter/material.dart';
import 'package:snake/tools/infoGame.dart';
import 'package:snake/screen.dart';

class Controller extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final InfoGameState gameInfo = InfoGame.of(context);
    var startPosition;
    var updatePosition;

    return GestureDetector(
        onPanDown: (details) {
          startPosition = details.globalPosition;
        },
        onPanUpdate: (details) {
          updatePosition = details.globalPosition;
        },
        onPanEnd: (details) {
          var direction = updatePosition - startPosition;
          String setDirection = 'Up';
          if (direction.dx != 0 && direction.dy != 0) {
            if (direction.dx.abs() > direction.dy.abs()) {
              if (direction.dx < 0 && gameInfo.info.move != 'Right') {
                setDirection = 'Left';
              } else if (gameInfo.info.move != 'Left'){
                setDirection = 'Right';
              }
            } else {
              if (direction.dy < 0  && gameInfo.info.move != 'Down') {
                setDirection = 'Up';
              } else if (gameInfo.info.move != 'Up'){
                setDirection = 'Down';
              }
            }
            print('SetDirection: $setDirection');
            gameInfo.changeDirection(setDirection);
          }
        },
        child: GestureDetector(
            onLongPressStart: (nothing) {
              gameInfo.updateAcceleration();
            },
            onLongPressEnd: (nothing) {
              gameInfo.updateAcceleration();
            },
        child: SnakeScreen()),
        );
  }
}
