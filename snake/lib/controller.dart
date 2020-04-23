import 'package:flutter/material.dart';

class SnakeController extends StatelessWidget {
  const SnakeController({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: RaisedButton(
            onPressed: () {
              print('Go Up');
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
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  onPressed: () {
                    print('Go Left');
                  },
                  color: Colors.orangeAccent,
                  child: Icon(Icons.keyboard_arrow_left),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  onPressed: () {
                    print('Go Right');
                  },
                  color: Colors.orangeAccent,
                  child: Icon(Icons.keyboard_arrow_right),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: RaisedButton(
            onPressed: () {
              print('Go Down');
            },
            color: Colors.orangeAccent,
            child: Icon(Icons.keyboard_arrow_down),
          ),
        ),
      ],
    );
  }
}
