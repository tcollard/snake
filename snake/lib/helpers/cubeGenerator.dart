import 'dart:math';
import 'package:flutter/material.dart';

class Point {
  int x;
  int y;

  Point(int x, int y) {
    this.x = x;
    this.y = y;
  }
}

Point generateCubePoint(double width, double height) {
  Random randomX = Random();
  Random randomY = Random();
  return Point(
      randomX.nextInt(width ~/ 10), randomY.nextInt((height - 80) ~/ 10));
}

Positioned generateCubePosition(Point cubePoint, Color color) {
  return Positioned(
    child: Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.rectangle,
        border: Border.all(width: 0, color: Colors.green),
      ),
    ),
    left: (cubePoint.x * 10).toDouble(),
    top: (cubePoint.y * 10).toDouble(),
  );
}
