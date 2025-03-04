import 'package:flutter/material.dart';
import 'package:snake/snake.dart';
import 'package:snake/tools/infoGame.dart';
import 'package:snake/helpers/snakeHelpers.dart';

class SnakeScreen extends StatefulWidget {
  SnakeScreen({Key key}) : super(key: key);

  @override
  _SnakeScreenState createState() => _SnakeScreenState();
}

class _SnakeScreenState extends State<SnakeScreen> {
  BackGroundColor _color = BackGroundColor();
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScoreBar(),
          Container(
            width: width,
            height: height - 80,
            color: _color.getColor(),
            child: Snake(width: width, height: height),
          ),
        ],
      ),
    );
  }
}

class ScoreBar extends StatefulWidget {
  ScoreBar({Key key}) : super(key: key);

  @override
  _ScoreBarState createState() => _ScoreBarState();
}

class _ScoreBarState extends State<ScoreBar> {
  BackGroundColor _color = BackGroundColor();
  bool _animationTrigger = true;

  @override
  Widget build(BuildContext context) {
    final InfoGameState gameInfo = InfoGame.of(context);

    if (gameInfo.info.isStart) _animationTrigger = !_animationTrigger;

    return Container(
      height: 80,
      decoration: BoxDecoration(
          color: _color.getColor(),
          shape: BoxShape.rectangle,
          border: Border.all(width: 2.0, color: Colors.black)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AnimatedDefaultTextStyle(
                    child: Text('Score: ${gameInfo.info.score}'),
                    style: (_animationTrigger && gameInfo.info.score != 0)
                        ? TextStyle(fontFamily: 'PressStart2P', fontSize: 20, color: Colors.black)
                        : TextStyle(fontFamily: 'PressStart2P', fontSize: 15, color: Colors.black),
                    duration: Duration(milliseconds: 200),
                    onEnd: () {
                      setState(() {
                        _animationTrigger = true;
                      });
                    },
                  ),
                  Text(
                    'High Score: ${gameInfo.info.highScore}',
                    style: TextStyle(fontFamily: 'PressStart2P'),
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}
