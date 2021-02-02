import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:tomate_timer/features/study_session/presenter/controller/session_controller.dart';

class SessionTimer extends StatefulWidget {
  SessionTimer({
    Key key,
    @required this.textController,
  }) : super(key: key);

  final TextEditingController textController;
  String elapsedTime = '00:00:00';
  Stopwatch watch = Stopwatch();
  Timer timer;
  bool timerIsOff = true;

  @override
  SessionTimerState createState() => SessionTimerState();
}

class SessionTimerState extends ModularState<SessionTimer, SessionController> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.elapsedTime);
  }

  bool getTimerIsOff() {
    return widget.timerIsOff;
  }

  startOrStop() {
    if (widget.timerIsOff) {
      startWatch();
    } else {
      stopWatch();
    }
  }

  updateTime(Timer timer) {
    if (widget.watch.isRunning) {
      setState(() {
        widget.elapsedTime =
            transformMilliSeconds(widget.watch.elapsedMilliseconds);
      });
    }
  }

  startWatch() {
    setState(() {
      widget.timerIsOff = false;
      widget.watch.start();
      widget.timer = Timer.periodic(Duration(milliseconds: 100), updateTime);
    });
  }

  stopWatch() {
    setState(() {
      widget.timerIsOff = true;
      widget.watch.stop();
      setTime();
      widget.watch.reset();
    });

    saveSession();
  }

  void saveSession() {
    var text = widget.textController.text;
    String formattedDate = getDate();

    controller.dto = controller.dto.copyWith(
        date: formattedDate, duration: widget.elapsedTime, title: text);
    controller.saveSession().then((value) => debugPrint(value));

    _resetFields();
  }

  String getDate() {
    var now = new DateTime.now();
    var formatter = new DateFormat('dd-MM-yyyy');
    String formattedDate = formatter.format(now);
    return formattedDate;
  }

  void _resetFields() {
    widget.elapsedTime = '00:00:00';
    widget.textController.text = '';
  }

  setTime() {
    var timeSoFar = widget.watch.elapsedMilliseconds;
    setState(() {
      widget.elapsedTime = transformMilliSeconds(timeSoFar);
    });
  }

  transformMilliSeconds(int milliseconds) {
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
