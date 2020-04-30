import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:snake/helpers/cubeGenerator.dart';
import 'package:snake/helpers/snakeHelpers.dart';
import 'package:snake/tools/infoGame.dart';
import 'package:audioplayers/audio_cache.dart';

class Snake extends StatefulWidget {
  final double width;
  final double height;

  Snake({Key key, this.width, this.height}) : super(key: key);

  @override
  _SnakeState createState() => _SnakeState();
}

class _SnakeState extends State<Snake> {
  TimerDuration duration = TimerDuration();
  Checker check = Checker();
  Score score = Score();
  Refresh refresh = Refresh();
  Positioned cubePosition;
  Point cubePoint;
  var snakeBody = [];
  List<Positioned> snakePosition = List();
  AudioCache cache = AudioCache(prefix: 'audio/');
  AudioPlayer player;

  @override
  Widget build(BuildContext context) {
    if (check.getStart() && !check.getCollision()) {
      setDrawing();
      return screenDrawing(cubePosition, cubePoint);
    } else {
      if (player != null) {
        player.stop();
      }
      return startPlayer();
    }
  }

  Widget startPlayer() {
    return IconButton(
      icon: Icon(Icons.play_arrow),
      iconSize: 80.0,
      onPressed: () {
        check = Checker();
        check.setStart(true);
        duration = TimerDuration();
        score = Score();
        playSound();
        refresh.initTimer(duration.getDuration(), getSnakePosition);
        final initPoint = this.widget.width ~/ 2 ~/ 10;
        snakeBody = [
          Point(initPoint, initPoint - 1),
          Point(initPoint, initPoint),
          Point(initPoint, initPoint + 1),
        ];
      },
    );
  }

  Widget screenDrawing(Positioned cubePosition, Point cubePoint) {
    int index = 0;
    snakePosition = [cubePosition];
    snakeBody.forEach((elem) {
      snakePosition.add(generateCubePosition(
          elem,
          (index == (snakeBody.length - 1) && check.getAdd())
              ? Colors.green
              : Colors.black));
      index += 1;
    });
    if (snakeBody[0].x == cubePoint.x && snakeBody[0].y == cubePoint.y) {
      check.setIsEaten(true);
      cache.play('crash.mp3');
      final InfoGameState gameInfo = InfoGame.of(context);
      gameInfo.updateScore();
      score.setScore();
    } else if (index == snakeBody.length && index > 1 && check.getAdd()) {
      snakeBody.removeLast();
    }
    check.setAdd(false);
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
      check.setAdd(true);
      checkCollision();
      if (!check.getIsAccelerate() &&
          gameInfo.getAcceleration() &&
          duration.getDuration() > 100 &&
          !check.getCollision()) {
        check.setIsAccelerate(true);
        refresh.reInitTimer(duration.getAccelearation(), getSnakePosition);
      } else if (check.getIsAccelerate() &&
          !gameInfo.getAcceleration() &&
          duration.getDuration() > 100 &&
          !check.getCollision()) {
        check.setIsAccelerate(false);
        refresh.reInitTimer(duration.getDuration(), getSnakePosition);
      }
    });
  }

  void checkCollision() {
    final InfoGameState gameInfo = InfoGame.of(context);
    
    if ((snakeBody[0].x >= this.widget.width / 10 - 1 || snakeBody[0].x < 0) ||
        (snakeBody[0].y >= (this.widget.height - 80) / 10 - 1 ||
            snakeBody[0].y < 0)) {
      refresh.stopTimer();
      check.setStart(false);
      check.setCollision(false);
      gameInfo.reinitInfo();
      return;
    }
    int i = 0;
    snakeBody.forEach((element) async {
      if (i != 0 &&
          snakeBody[0].x == element.x &&
          snakeBody[0].y == element.y) {
        refresh.stopTimer();
        check.setStart(false);
        check.setCollision(false);
        gameInfo.reinitInfo();
        return;
      }
      i += 1;
    });
  }

  void setDrawing() {
    if (check.getIsEaten()) {
      check.setIsEaten(false);
      cubePoint = generateCubePoint(this.widget.width, this.widget.height);
      cubePosition = generateCubePosition(cubePoint, Colors.black);
    }
    if (score.isScoreDifferent()) {
      score.setOldScore();
      duration.reduceDuration();
      int newDuration = check.getIsAccelerate()
          ? duration.getAccelearation()
          : duration.getDuration();
      refresh.reInitTimer(newDuration, getSnakePosition);
    }
  }

  void playSound() async {
    player = await cache.loop('snake-jazz.mp3');
  }
}
