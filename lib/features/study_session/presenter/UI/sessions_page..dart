import 'package:flutter/material.dart';
import 'package:tomate_timer/features/study_session/presenter/UI/widgets/tracker_form.dart';
import 'package:tomate_timer/features/study_session/presenter/UI/widgets/tracker_list.dart';

class SessionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tomate Timer'),
      ),
      body: SafeArea(
        bottom: true,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TrackerForm(),
              TrackerList(),
            ],
          ),
        ),
      ),
    );
  }
}
