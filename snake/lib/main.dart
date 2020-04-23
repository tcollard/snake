import 'package:flutter/material.dart';
import 'package:snake/game.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SNAKE GAME',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SnakePage(),
    );
  }
}

class SnakePage extends StatelessWidget {
  const SnakePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Game(),
    );
    // return Container(
    //   child: Text('Snake'),
    // );
  }
}