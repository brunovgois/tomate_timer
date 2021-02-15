import 'package:dartz/dartz.dart' hide Bind;
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tomate_timer/features/study_session/domain/entities/session.dart';
import 'package:tomate_timer/features/study_session/domain/usecases/findall_sessions_usecase.dart';
import 'package:tomate_timer/features/study_session/domain/usecases/save_session_usecase.dart';
import 'package:tomate_timer/features/study_session/presenter/controller/session_controller.dart';
import 'package:tomate_timer/features/study_session/study_session_module.dart';

class SaveUseCaseMock extends Mock implements SaveSessionUseCase {}

class FindAllUseCaseMock extends Mock implements FindAllSessionsUseCase {}

void main() {
  FindAllSessionsUseCase _findAllUseCase = FindAllUseCaseMock();
  SaveSessionUseCase _saveSessionUseCase = SaveUseCaseMock();
  SessionController _controller;
  Session _sessionmock;
  List<Session> _sessionsListMock;

  initModule(StudySessionModule(), changeBinds: [
    Bind<SaveSessionUseCase>((i) => _saveSessionUseCase),
    Bind<FindAllSessionsUseCase>((i) => _findAllUseCase)
  ]);

  setUp(() {
    _controller = Modular.get();
    _sessionmock = new Session(title: "new session");
    _sessionsListMock = [_sessionmock];
  });

  test("controller is instace of SessionController", () {
    expect(_controller, isInstanceOf<SessionController>());
  });

  group("Save Session", () {
    Session saveSessionMock() {
      _sessionsListMock.add(_sessionmock);
      return _sessionmock;
    }

    test("on save session, should return Succes! string", () async {
      when(_saveSessionUseCase.save(argThat(isA<Session>())))
          .thenAnswer((_) async => Right(saveSessionMock()));

      when(_findAllUseCase.findAll())
          .thenAnswer((_) async => Right(_sessionsListMock));

      String result = await _controller.saveSession();

      expect(result, "Success!");
      _controller.sessions.clear();
    });

    test("on save session, should add session to sessions list", () async {
      when(_saveSessionUseCase.save(argThat(isA<Session>())))
          .thenAnswer((_) async => Right(saveSessionMock()));

      when(_findAllUseCase.findAll())
          .thenAnswer((_) async => Right(_sessionsListMock));

      await _controller.saveSession();

      assert(_sessionsListMock.contains(_sessionmock));
      _controller.sessions.clear();
    });
  });
  group("Find All Sessions", () {
    test("on find all sessions, should return a Success! string", () async {
      when(_findAllUseCase.findAll())
          .thenAnswer((_) async => Right(_sessionsListMock));
      String result = await _controller.findAllSessions();
      expect(result, "Success!");

      _controller.sessions.clear();
    });

    test("on find all sessions, should show the list with updated value",
        () async {
      when(_findAllUseCase.findAll())
          .thenAnswer((_) async => Right(_sessionsListMock));

      await _controller.findAllSessions();

      expect(_controller.sessions.length, 1);
      expect(_controller.sessions[0].title, _sessionmock.title);
    });
  });
}
