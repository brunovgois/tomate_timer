import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart' as mockito;
import 'package:mobx/mobx.dart';
import 'package:tomate_timer/core/mapper/mapper.dart';
import 'package:tomate_timer/features/study_session/domain/entities/session.dart';
import 'package:tomate_timer/features/study_session/infra/dto/session_dto.dart';
import 'package:tomate_timer/features/study_session/infra/mapper/session_mapper.dart';
import 'package:tomate_timer/features/study_session/presenter/UI/widgets/tracker_list.dart';
import 'package:tomate_timer/features/study_session/presenter/controller/session_controller.dart';
import 'package:tomate_timer/features/study_session/study_session_module.dart';

class SessionControllerMock extends mockito.Mock implements SessionController {}

void main() {
  TrackerList _trackerList;
  List<Session> _sessionsListMock;
  SessionController _controller;
  Mapper _mapper;

  setUp(() {
    _mapper = SessionMapper();
    initModule(StudySessionModule(), changeBinds: [
      Bind<SessionController>((i) => SessionControllerMock()),
    ]);
    _sessionsListMock = [
      Session(title: 'first session'),
      Session(title: 'second session')
    ];
    _controller = Modular.get<SessionController>();
    _trackerList = new TrackerList();
    mockito.when(_controller.sessions).thenReturn(_sessionsListMock
        .map((e) => _mapper.to(e))
        .toList()
        .cast<SessionDTO>()
        .asObservable());
    _controller.findAllSessions();
  });

  testWidgets('tracker list should display the list from the controller',
      (tester) async {
    await tester.pumpWidget(
      buildTestableWidget(
        MaterialApp(
          home: Scaffold(
            body: _trackerList,
          ),
        ),
      ),
    );
    final firstSessionFinder = find.text('first session');
    final secondeSessionFinder = find.text('second session');

    expect(firstSessionFinder, findsOneWidget);
    expect(secondeSessionFinder, findsOneWidget);
  });
}
