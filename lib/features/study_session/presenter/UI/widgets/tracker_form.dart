import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'dart:async';
import 'package:intl/intl.dart';

import 'package:tomate_timer/features/study_session/presenter/controller/session_controller.dart';

class TrackerForm extends StatefulWidget {
  TrackerForm({Key key}) : super(key: key);

  @override
  _TrackerFormState createState() => _TrackerFormState();
}

class _TrackerFormState extends ModularState<TrackerForm, SessionController> {
  final TextEditingController _currentWorkController = TextEditingController();
  String elapsedTime = '00:00:00';
  Stopwatch watch = Stopwatch();
  Timer timer;
  bool timerIsOff = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: 200,
          child: TextField(
            controller: _currentWorkController,
            decoration: InputDecoration(
              labelText: 'What are you working on?',
            ),
          ),
        ),
        Text(elapsedTime),
        RaisedButton(
            child: timerIsOff ? Text('START') : Text('STOP'),
            onPressed: () => startOrStop()),
      ],
    );
  }

  startOrStop() {
    if (timerIsOff) {
      startWatch();
    } else {
      stopWatch();
    }
  }

  updateTime(Timer timer) {
    if (watch.isRunning) {
      setState(() {
        elapsedTime = transformMilliSeconds(watch.elapsedMilliseconds);
      });
    }
  }

  startWatch() {
    setState(() {
      timerIsOff = false;
      watch.start();
      timer = Timer.periodic(Duration(milliseconds: 100), updateTime);
    });
  }

  stopWatch() {
    setState(() {
      timerIsOff = true;
      watch.stop();
      setTime();
      watch.reset();
    });

    var text = _currentWorkController.text;
    String formattedDate = getDate();

    controller.dto = controller.dto
        .copyWith(date: formattedDate, duration: elapsedTime, title: text);
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
    elapsedTime = '00:00:00';
    _currentWorkController.text = '';
  }

  setTime() {
    var timeSoFar = watch.elapsedMilliseconds;
    setState(() {
      elapsedTime = transformMilliSeconds(timeSoFar);
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