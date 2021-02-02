import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tomate_timer/features/study_session/presenter/UI/widgets/session_timer.dart';
import 'package:tomate_timer/features/study_session/presenter/controller/session_controller.dart';

class TrackerForm extends StatefulWidget {
  TrackerForm({Key key}) : super(key: key);

  @override
  _TrackerFormState createState() => _TrackerFormState();
}

class _TrackerFormState extends ModularState<TrackerForm, SessionController> {
  GlobalKey<SessionTimerState> timerState = GlobalKey();
  final TextEditingController _currentWorkController = TextEditingController();

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
        SessionTimer(key: timerState, textController: _currentWorkController),
        ElevatedButton(
          onPressed: () => timerState.currentState.startOrStop(),
          child: Text('Start/Stop'), //temp
        ),
      ],
    );
  }
}
