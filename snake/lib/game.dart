import 'package:flutter/material.dart';
import 'package:snake/snake.dart';
import 'package:snake/controller.dart';

class Game extends StatelessWidget {
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: Container(
              width: 360,
              height: 360,
              color: Colors.green,
              child: Snake(),
            ),
          ),
          SnakeController(),
        ],
      ),
    );
  }
}
