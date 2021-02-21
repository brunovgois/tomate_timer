import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tomate_timer/features/study_session/presenter/UI/widgets/tracker_form.dart';
import 'package:tomate_timer/features/study_session/study_session_module.dart';

void main() {
  TrackerForm form;

  setUp(() {
    form = new TrackerForm();
  });

  initModule(StudySessionModule());

  group("Tracker Form", () {
    testWidgets('Should have a text field', (tester) async {
      await tester.pumpWidget(buildTestableWidget(MaterialApp(
        home: Scaffold(body: form),
      )));

      final textFieldFinder = find.byType(TextField);
      expect(textFieldFinder, findsOneWidget);
    });

    testWidgets('Should have the correct label text on input', (tester) async {
      await tester.pumpWidget(buildTestableWidget(MaterialApp(
        home: Scaffold(body: form),
      )));

      final textFinder = find.text('What are you working on?');
      expect(textFinder, findsOneWidget);
    });

    testWidgets("Should display the correct initial timer value",
        (tester) async {
      await tester.pumpWidget(buildTestableWidget(MaterialApp(
        home: Scaffold(body: form),
      )));
      final timerFinder = find.text('00:00:00');
      expect(timerFinder, findsOneWidget);
    });

    testWidgets("Should have a elevated button", (tester) async {
      await tester.pumpWidget(buildTestableWidget(MaterialApp(
        home: Scaffold(body: form),
      )));
      final buttonFinder = find.byType(ElevatedButton);
      expect(buttonFinder, findsOneWidget);
    });
  });
}
