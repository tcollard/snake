import 'package:flutter/material.dart';
import 'package:snake/controller.dart';
import 'package:snake/snake.dart';

class MyWidget extends InheritedWidget {
  MyWidget({Key key, @required this.child, @required this.move}) : super(key: key, child: child);

  final Widget child;
  final MoveWidgetState move;

  static MyWidget of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(MyWidget)as MyWidget);
  }

  @override
  bool updateShouldNotify( MyWidget oldWidget) {
    return true;
  }
}

class MoveWidget extends StatefulWidget {
  MoveWidget({Key key, this.child}) : super(key: key);

  final Widget child;
  @override
  MoveWidgetState createState() => MoveWidgetState();

  static MoveWidgetState of(BuildContext context){
    return (context.inheritFromWidgetOfExactType(MyWidget) as MyWidget).move;
  }
}

class MoveWidgetState extends State<MoveWidget> {
  
  String move;
  bool start = false;
  
  void changeDirection(String direction) {
    setState(() {
      move = direction;
    });
  }

  void startGame() {
    setState(() {
      start = !start;
    });
  }
  String get getDirection => move;
  bool get statusGame => start;
  
  @override
  Widget build(BuildContext context) {
    return MyWidget(
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
    return new MoveWidget(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 50.0),
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
      ),
    );
  }
}
