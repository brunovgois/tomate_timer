import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tomate_timer/features/study_session/presenter/UI/widgets/session.dart';
import 'package:tomate_timer/features/study_session/presenter/controller/session_controller.dart';

class TrackerList extends StatefulWidget {
  TrackerList({Key key}) : super(key: key);

  @override
  _TrackerListState createState() => _TrackerListState();
}

class _TrackerListState extends ModularState<TrackerList, SessionController> {
  @override
  void initState() {
    super.initState();
    controller.findAllSessions();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600,
      child: ValueListenableBuilder(
        valueListenable: controller.sessions,
        builder: (context, value, child) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.separated(
                scrollDirection: Axis.vertical,
                reverse: false, //temp, bug
                shrinkWrap: true,
                itemCount: value.length ?? 0,
                itemBuilder: (context, index) {
                  var tracker = value[index];
                  return Session(
                      title: tracker.title,
                      date: tracker.date,
                      elapsedTime: tracker.duration);
                },
                separatorBuilder: (context, index) {
                  return Divider();
                }),
          );
        },
      ),
    );
  }
}
