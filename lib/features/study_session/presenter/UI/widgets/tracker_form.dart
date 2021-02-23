import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tomate_timer/features/study_session/presenter/controller/session_controller.dart';
import 'package:tomate_timer/features/study_session/presenter/controller/timer_controller.dart';

class TrackerForm extends StatefulWidget {
  TrackerForm({Key key}) : super(key: key);

  @override
  _TrackerFormState createState() => _TrackerFormState();
}

class _TrackerFormState extends ModularState<TrackerForm, SessionController> {
  TimerController timerController = Modular.get<TimerController>();

  @override
  void dispose() {
    timerController.timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: 200,
          child: TextField(
            onChanged: timerController.setTextController,
            decoration: InputDecoration(
              labelText: 'What are you working on?',
            ),
          ),
        ),
        Observer(builder: (_) {
          return Text(timerController.elapsedTime);
        }),
        ElevatedButton(
            onPressed: () => timerController.startOrStop(),
            child: Observer(
              builder: (_) {
                return Text(timerController.isTimerOff ? 'Start' : 'Stop');
              },
            )),
      ],
    );
  }
}
