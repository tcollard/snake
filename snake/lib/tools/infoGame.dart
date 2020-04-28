import 'package:flutter/material.dart';
import 'package:snake/game.dart';

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
    info.move = 'Up';
    info.score = 0;
    info.bestScore = 100;
    super.initState();
  }

  void changeDirection(String direction) {
    setState(() {
      info.move = direction;
    });
  }

  void reinitInfo() {
    setState(() {
      info.move = 'Up';
      info.score = 0;
    });
  }

  void updateScore() {
    Future.delayed(Duration(milliseconds: 1), () {
      setState(() {
        print('update Score');
        info.score += 1;
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
  int bestScore;
  String move;

  Info() {
   // 
  }
}