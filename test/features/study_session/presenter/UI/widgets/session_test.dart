import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tomate_timer/features/study_session/presenter/UI/widgets/session.dart';

void main() {
  testWidgets('session widget has title, elapsed time and date',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Session(
          title: "test Title",
          date: "10/10/2010",
          elapsedTime: "00:15:10",
        ),
      ),
    ));

    final titleFinder = find.text('test Title');
    final dateFinder = find.text("10/10/2010");
    final elapsedTimeFinder = find.text("00:15:10");
    print(titleFinder);

    expect(titleFinder, findsOneWidget);
    expect(dateFinder, findsOneWidget);
    expect(elapsedTimeFinder, findsOneWidget);
  });
}
