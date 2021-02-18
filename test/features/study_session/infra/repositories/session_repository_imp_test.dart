import 'package:dartz/dartz.dart' hide Bind;
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tomate_timer/features/study_session/domain/entities/session.dart';
import 'package:tomate_timer/features/study_session/domain/repositories/session_repository.dart';
import 'package:tomate_timer/features/study_session/infra/datasources/session_datasource.dart';
import 'package:tomate_timer/features/study_session/infra/dto/session_dto.dart';
import 'package:tomate_timer/features/study_session/infra/errors/repository_exception.dart';
import 'package:tomate_timer/features/study_session/study_session_module.dart';

class SessionDataSourceMock extends Mock implements SessionDatasource {}

void main() {
  SessionDatasource _datasourceMock;
  SessionRepository _repository;
  Session _sessionMock;
  List<SessionDTO> _sessionsListDTOMock;
  List<Session> _sessionsListMock;

  setUp(() {
    _datasourceMock = SessionDataSourceMock();
    _repository = Modular.get();
  });

  initModule(StudySessionModule(), changeBinds: [
    Bind<SessionDatasource>((i) => _datasourceMock),
  ]);

  TestWidgetsFlutterBinding.ensureInitialized();

  test("repository is an instance of SessionRepository", () {
    expect(_repository, isA<SessionRepository>());
  });

  group("On Save", () {
    test("repository should return a Session", () async {
      _sessionMock = new Session(title: "new session");

      when(_datasourceMock.save(argThat(isA<SessionDTO>())))
          .thenAnswer((_) async => Right(_sessionMock));

      var result = await _repository.save(_sessionMock);

      expect(result, Right(_sessionMock));
    });

    test("on failed attempt, repository should return an Exception", () async {
      _sessionMock = new Session(title: "new session");

      when(_datasourceMock.save(argThat(isA<SessionDTO>())))
          .thenThrow(Exception);

      var result = await _repository.save(_sessionMock);

      expect(result, Left(RepositoryException('Error on repository save.')));
    });
  });

  group("On Find All", () {
    test("repository should return a List of Sessions", () async {
      _sessionsListDTOMock = [];
      _sessionsListMock = [];

      when(_datasourceMock.findAll())
          .thenAnswer((_) async => _sessionsListDTOMock);

      var result = await _repository.findAll();

      result.fold((l) => null, (r) => {expect(r, _sessionsListMock)});
    });

    test("on failed atempt, repository should return an Exception", () async {
      when(_datasourceMock.findAll()).thenThrow(Exception());

      var result = await _repository.findAll();

      result.fold((l) => expect(l, isA<RepositoryException>()), (r) => null);
    });
  });
}
