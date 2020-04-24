import 'package:flutter/material.dart';
import 'package:snake/game.dart';

class SnakeController extends StatefulWidget {
  const SnakeController();

  @override
  _SnakeControllerState createState() => _SnakeControllerState();
}

class _SnakeControllerState extends State<SnakeController> {

  // @override
  // void initState() {
    // final toto = MyWidget.of(context);
    // toto.move = direction.Up;
    // print('TOTO: ${toto.move}');
    // super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    final MoveWidgetState move = MoveWidget.of(context);
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: RaisedButton(
            onPressed: () {
              print('Go Up');
              setState(() {
                move.changeDirection('Up');
              });
            },
            color: Colors.orangeAccent,
            child: Icon(Icons.keyboard_arrow_up),
          ),
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: RaisedButton(
                  onPressed: () {
                    print('Go Left');
                    setState(() {
                      move.changeDirection('Left');
                      // widget.move = direction.Left;
                    });
                  },
                  color: Colors.orangeAccent,
                  child: Icon(Icons.keyboard_arrow_left),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: RaisedButton(
                  onPressed: () {
                    print('Go Right');
                    setState(() {
                      move.changeDirection('Right');
                    });
                  },
                  color: Colors.orangeAccent,
                  child: Icon(Icons.keyboard_arrow_right),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: RaisedButton(
            onPressed: () {
              print('Go Down');
              setState(() {
                move.changeDirection('Down');
              });
            },
            color: Colors.orangeAccent,
            child: Icon(Icons.keyboard_arrow_down),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: RaisedButton(
              onPressed: () {
                print('Start game');
                  setState(() {
                    move.startGame();
                  });
              },
              color: Colors.blueAccent,
              child: Icon(Icons.play_arrow)),
        ),
      ],
    );
  }
}
