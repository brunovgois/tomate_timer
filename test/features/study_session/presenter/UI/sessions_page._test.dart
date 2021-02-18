import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tomate_timer/features/study_session/presenter/UI/sessions_page..dart';
import 'package:tomate_timer/features/study_session/presenter/UI/widgets/tracker_form.dart';
import 'package:tomate_timer/features/study_session/presenter/UI/widgets/tracker_list.dart';
import 'package:tomate_timer/features/study_session/study_session_module.dart';

void main() {
  SessionsPage sessionsPage;
  setUp(() {
    sessionsPage = new SessionsPage();
  });

  initModule(StudySessionModule());

  testWidgets('Session page has TrackerForm and TrackerList as children',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: sessionsPage,
      ),
    );
    final formFinder = find.byType(TrackerForm);
    final listFinder = find.byType(TrackerList);

    expect(formFinder, findsOneWidget);
    expect(listFinder, findsOneWidget);
  });

  testWidgets("Session page has the correct appBar title", (teste) async {
    await teste.pumpWidget(
      MaterialApp(
        home: sessionsPage,
      ),
    );
    final textFinder = find.text('Tomate Timer');

    expect(textFinder, findsOneWidget);
  });
}
