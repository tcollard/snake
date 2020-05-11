import 'package:flutter/material.dart';
import 'package:snake/game.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InfoGame extends StatefulWidget {
  InfoGame({Key key, this.child}) : super(key: key);

  final Widget child;
  @override
  InfoGameState createState() => InfoGameState();

  static InfoGameState of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(ParentWidget) as ParentWidget)
        .info;
  }
}

class InfoGameState extends State<InfoGame> {
  Info info = Info();

  @override
  void initState() {
    getHighScore();
    info.move = 'Up';
    info.score = 0;
    info.accelerate = false;
    info.endDirection = true;
    info.isStart = false;
    info.newHighScore = false;
    super.initState();
  }

  Future<void> getHighScore() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      info.highScore = prefs.getInt('highScore') ?? 0;
    });
  }

  Future<void> saveScore() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setInt('highScore', info.score);
    });
  }

  void changeDirection(String direction) {
    if (info.endDirection) {
      info.move = direction;
      info.endDirection = false;
    }
  }

  void reinitInfo() async {
    await saveScore();
    setState(() {
      info.move = 'Up';
      info.isStart = true;
      info.accelerate = false;
      info.newHighScore = false;
      if (info.score > info.highScore) {
        info.highScore = info.score;
      }
      info.score = 0;
    });
  }

  void updateAcceleration() {
    info.accelerate = !info.accelerate;
  }

  bool getAcceleration() => info.accelerate;

  void updateScore() {
    Future.delayed(Duration(milliseconds: 1), () {
      setState(() {
        info.score += 1;
        if (info.score > info.highScore && info.score - 1 == info.highScore) {
          info.newHighScore = true;
        } else {
          info.newHighScore = false;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ParentWidget(
      info: this,
      child: widget.child,
    );
  }
}

class Info {
  int score;
  int highScore;
  String move;
  bool endDirection;
  bool accelerate;
  bool isStart;
  bool newHighScore;

  Info() {
    //
  }
}
