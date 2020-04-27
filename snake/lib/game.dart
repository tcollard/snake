import 'package:flutter/material.dart';
import 'package:snake/controller.dart';
import 'package:snake/snake.dart';

class ParentWidget extends InheritedWidget {
  ParentWidget({Key key, @required this.child, @required this.move})
      : super(key: key, child: child);

  final Widget child;
  final DisplayGameState move;

  static ParentWidget of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(ParentWidget) as ParentWidget);
  }

  @override
  bool updateShouldNotify(ParentWidget oldWidget) {
    return true;
  }
}

class DisplayGame extends StatefulWidget {
  DisplayGame({Key key, this.child}) : super(key: key);

  final Widget child;
  @override
  DisplayGameState createState() => DisplayGameState();

  static DisplayGameState of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(ParentWidget) as ParentWidget)
        .move;
  }
}

class DisplayGameState extends State<DisplayGame> {
  String move;
  bool start;
  int bestScore;
  int score;

  @override
  void initState() {
    start = false;
    move = 'Up';
    score = 0;
    bestScore = 100;
    super.initState();
  }

  void changeDirection(String direction) {
    setState(() {
      move = direction;
    });
  }

  void startGame() {
    setState(() {
      start = !start;
      move = 'Up';
    });
  }

  @override
  Widget build(BuildContext context) {
    return ParentWidget(
      move: this,
      child: widget.child,
    );
  }
}

class Game extends StatefulWidget {
  const Game({Key key}) : super(key: key);

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  @override
  Widget build(BuildContext context) {
    return DisplayGame(
      child: Controller(),
    );
  }
}
