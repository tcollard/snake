import 'package:flutter/material.dart';
import 'package:snake/tools/controller.dart';
import 'package:snake/tools/infoGame.dart';

class ParentWidget extends InheritedWidget {
  ParentWidget({Key key, @required this.child, @required this.info})
      : super(key: key, child: child);

  final Widget child;
  final InfoGameState info;

  static ParentWidget of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(ParentWidget) as ParentWidget);
  }

  @override
  bool updateShouldNotify(ParentWidget oldWidget) {
    return true;
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
    return InfoGame(
      child: Controller(),
    );
  }
}