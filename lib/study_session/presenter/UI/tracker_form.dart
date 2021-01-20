import 'package:flutter/material.dart';
import 'dart:async';

class TrackerForm extends StatefulWidget {
  @override
  _TrackerFormState createState() => _TrackerFormState();
}

class _TrackerFormState extends State<TrackerForm> {
  final TextEditingController _currentWorkController = TextEditingController();
  Stopwatch watch = Stopwatch();
  Timer timer;
  bool timerIsOff = true;
  String elapsedTime = '00:00:00';

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
    print('$text ---> $elapsedTime');

    _resetFields();
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
