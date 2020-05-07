import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class Refresh {
  Timer timer;

  Refresh() {
    //
  }

  void initTimer(int duration, callback) {
    this.timer = Timer.periodic(Duration(milliseconds: duration), callback);
  }

  void stopTimer() {
    this.timer.cancel();
  }

  void reInitTimer(int duration, callback) {
    this.stopTimer();
    initTimer(duration, callback);
  }

}

class TimerDuration {
  int _duration;
  int _acceleration;

  TimerDuration() {
    this._duration = 400;
    this._acceleration = 100;
  }

  void reduceDuration() {
    if (this._duration > 40) this._duration -= 10;
  }

  int getDuration() {
    return this._duration;
  }

  int getAccelearation() {
    return this._acceleration;
  }
}

class Checker {
  bool _start;
  bool _add;
  bool _isEaten;
  bool _isAccelerate;
  bool _collision;

  Checker() {
    _start = false;
    _add = false;
    _isEaten = true;
    _isAccelerate = false;
    _collision = false;
  }

  void setStart(bool value) {
    this._start = value;
  }

  void setAdd(bool value) {
    this._add = value;
  }

  void setAddToFalse(bool value) {
    this._add = value;
  }

  void setIsEaten(bool value) {
    this._isEaten = value;
  }

  void setIsAccelerate(bool value) {
    this._isAccelerate = value;
  }

  void setCollision(bool value) {
    this._collision = value;
  }

  bool getStart() {
    return this._start;
  }

  bool getAdd() {
    return this._add;
  }

  bool getIsEaten() {
    return this._isEaten;
  }

  bool getIsAccelerate() {
    return this._isAccelerate;
  }

  bool getCollision() {
    return this._collision;
  }
}

class Score {
  int _oldScore;
  int _score;

  Score() {
    this._oldScore = 0;
    this._score = 0;
  }

  void setScore() {
    this._score += 1;
  }

  void setOldScore() {
    this._oldScore = this._score;
  }
  bool isScoreDifferent() {
    return !(this._score == this._oldScore);
  }

  int getScore() {
    return this._score;
  }
}

class BackGroundColor {
  static final BackGroundColor _singleton = BackGroundColor._internal();
  HSVColor _hsv;
  Color _color;

  BackGroundColor._internal();

  factory BackGroundColor() => _singleton;

  Color getColor() {
    if (_color == null) {
      changeColor();
    }
    return _color;
  }

  changeColor() {
      Random random = new Random();
      _hsv = HSVColor.fromAHSV(0.8, random.nextInt(360).toDouble(), random.nextDouble(), 0.5);
      _color = _hsv.toColor();
  }

}