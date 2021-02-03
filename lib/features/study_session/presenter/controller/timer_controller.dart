import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:tomate_timer/features/study_session/presenter/controller/session_controller.dart';

part 'timer_controller.g.dart';

class TimerController = Controller with _$TimerController;

abstract class Controller with Store {
  @observable
  String elapsedTime = '00:00:00';
  @observable
  bool isTimerOff = true;

  String textController;

  void setTextController(String text) => textController = text;

  Stopwatch watch = Stopwatch();
  Timer timer;

  @action
  startOrStop() {
    if (isTimerOff) {
      _startWatch();
    } else {
      _stopWatch();
    }
  }

  _startWatch() {
    isTimerOff = false;
    watch.start();
    timer = Timer.periodic(Duration(milliseconds: 100), _updateTime);
  }

  _updateTime(Timer timer) {
    if (watch.isRunning) {
      elapsedTime = _transformMilliSeconds(watch.elapsedMilliseconds);
    }
  }

  _stopWatch() {
    isTimerOff = true;
    watch.stop();
    _setTime();
    watch.reset();
    _saveSession();
  }

  _saveSession() {
    var text = textController;
    String formattedDate = _getDate();
    SessionController controller = Modular.get<SessionController>();

    controller.dto = controller.dto
        .copyWith(date: formattedDate, duration: elapsedTime, title: text);
    controller.saveSession().then((value) => debugPrint(value));

    _resetFields();
  }

  String _getDate() {
    var now = new DateTime.now();
    var formatter = new DateFormat('dd-MM-yyyy');
    String formattedDate = formatter.format(now);
    return formattedDate;
  }

  void _resetFields() {
    elapsedTime = '00:00:00';
    textController = '';
  }

  _setTime() {
    var timeSoFar = watch.elapsedMilliseconds;
    elapsedTime = _transformMilliSeconds(timeSoFar);
  }

  _transformMilliSeconds(int milliseconds) {
    int hundreds = (milliseconds / 10).truncate();
    int seconds = (hundreds / 100).truncate();
    int minutes = (seconds / 60).truncate();
    int hours = (minutes / 60).truncate();

    String hoursStr = (hours % 60).toString().padLeft(2, '0');
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    return "$hoursStr:$minutesStr:$secondsStr";
  }
}
