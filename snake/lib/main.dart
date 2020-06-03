import 'package:flutter/material.dart';
import 'package:snake/game.dart';
import 'package:flare_splash_screen/flare_splash_screen.dart';

void main() {
  // runApp(MyApp());
  runApp(MySplashScreen());
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
      home: SnakeGame(),
    );
  }
}

class SnakeGame extends StatelessWidget {
  const SnakeGame({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Game(),
    );
  }
}

class MySplashScreen extends StatelessWidget {
  const MySplashScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Snake Jazz',
      home: SplashScreen.navigate(
        name: './assets/animation/splashScreenAnimation.flr',
        next: (_) => MyApp(),
        until: () => Future.delayed(Duration(seconds: 0)),
        startAnimation: 'splashScreen',
        backgroundColor: Colors.white,
      ),
    );
  }
}