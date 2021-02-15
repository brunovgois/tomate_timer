import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tomate_timer/core/errors/failure.dart';
import 'package:tomate_timer/features/study_session/domain/entities/session.dart';
import 'package:tomate_timer/features/study_session/domain/errors/UseCaseException.dart';
import 'package:tomate_timer/features/study_session/domain/repositories/session_repository.dart';
import 'package:tomate_timer/features/study_session/domain/usecases/save_session_usecase.dart';
import 'package:tomate_timer/features/study_session/domain/usecases/save_session_usecase_imp.dart';
import 'package:tomate_timer/features/study_session/infra/errors/repository_exception.dart';

class SessionRepositoryMock extends Mock implements SessionRepository {}

void main() {
  SessionRepository _repository;
  SaveSessionUseCase _useCase;
  Session newSession;

  setUp(() async {
    _repository = SessionRepositoryMock();
    _useCase = SaveSessionUseCaseImp(_repository);
    newSession = new Session(title: 'new session');
  });

  test("Should return a session on Save Sesion", () async {
    when(_repository.save(newSession))
        .thenAnswer((_) async => Right(newSession));
    var result = await _useCase.save(newSession);

    expect(result, right(newSession));
  });

  test("Should retur an Exception when Save Session fails", () async {
    when(_repository.save(newSession))
        .thenAnswer((_) async => Left(RepositoryException('error')));

    var result = await _useCase.save(newSession);

    expect(result, isA<Left<Failure, Session>>());
  });
}
