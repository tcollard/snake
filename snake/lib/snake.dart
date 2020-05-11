import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:snake/helpers/cubeGenerator.dart';
import 'package:snake/helpers/snakeHelpers.dart';
import 'package:snake/tools/infoGame.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:vibration/vibration.dart';

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
  List<Point> snakeBody = List();
  List<Point> snakeTrail = List();
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

  Widget startButton() {
    return IconButton(
      icon: Icon(Icons.play_arrow),
      iconSize: 80.0,
      onPressed: () {
        final InfoGameState gameInfo = InfoGame.of(context);
        gameInfo.reinitInfo();
        check = Checker();
        check.setStart(true);
        duration = TimerDuration();
        score = Score();
        playSound();
        snakeTrail = List();
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

  Widget startPlayer() {
    if (check.getCollision()) {
      playFail();
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'GAME OVER',
            style: TextStyle(fontFamily: 'PressStart2P'),
          ),
          startButton(),
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          startButton(),
        ],
      );
    }
  }

  Widget screenDrawing(Positioned cubePosition, Point cubePoint) {
    BackGroundColor _color = BackGroundColor();
    final InfoGameState gameInfo = InfoGame.of(context);
    int index = 0;
    snakePosition = [cubePosition];
    snakeBody.forEach((elem) {
      snakePosition.add(generateCubePosition(
          elem,
          (index == (snakeBody.length - 1) && check.getAdd())
              ? _color.trailColor()
              : Colors.black));
      index += 1;
    });
    if (snakeTrail.length > 0) {
      snakeTrail.forEach((element) {
        snakePosition.add(generateCubePosition(element, _color.trailColor()));
      });
    }
    if (snakeBody[0].x == cubePoint.x && snakeBody[0].y == cubePoint.y) {
      eatCube();
    } else if (index == snakeBody.length && index > 1 && check.getAdd()) {
      snakeTrail.add(snakeBody.removeLast());
    }
    check.setAdd(false);
    if (!gameInfo.info.endDirection) {
      gameInfo.info.endDirection = true;
    }
    return Stack(children: snakePosition);
  }

  void eatCube() async {
    final InfoGameState gameInfo = InfoGame.of(context);
    BackGroundColor _color = BackGroundColor();

    check.setIsEaten(true);
    if (await Vibration.hasVibrator()) {
      cache.play('crash.mp3');
      Vibration.vibrate(duration: 50, amplitude: 128);
    }
    gameInfo.updateScore();
    score.setScore();
    _color.changeColor();
    snakeTrail = List();
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
      check.setCollision(true);
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
        check.setCollision(true);
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

  void playFail() async {
    player = await cache.play('oh-jeez.mp3');
  }
}
