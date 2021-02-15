import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tomate_timer/core/errors/failure.dart';
import 'package:tomate_timer/features/study_session/domain/entities/session.dart';
import 'package:tomate_timer/features/study_session/domain/errors/UseCaseException.dart';
import 'package:tomate_timer/features/study_session/domain/repositories/session_repository.dart';
import 'package:tomate_timer/features/study_session/domain/usecases/findall_sessions_usecase.dart';
import 'package:tomate_timer/features/study_session/domain/usecases/findall_sessions_usecase_imp.dart';
import 'package:tomate_timer/features/study_session/infra/errors/repository_exception.dart';

class SessionRepositoryMock extends Mock implements SessionRepository {}

void main() {
  SessionRepository _repository;
  FindAllSessionsUseCase _useCase;

  List<Session> _mockedList = [
    Session(title: 'first item'),
    Session(title: 'second item')
  ];

  setUp(() async {
    _repository = SessionRepositoryMock();
    _useCase = FindAllSessionsUseCaseImp(_repository);
  });

  test("Should return a reversed list on FindAll", () async {
    when(_repository.findAll())
        .thenAnswer((_) async => Right<Failure, List<Session>>(_mockedList));
    var result = await _useCase.findAll();

    result.fold((l) => null, (r) {
      expect(r.elementAt(0).title, 'second item');
    });
  });

  test("Should return an Exception when findAll retrieval fails", () async {
    when(_repository.findAll()).thenAnswer((_) async =>
        Left<Failure, List<Session>>(RepositoryException('error')));
    var result = await _useCase.findAll();

    result.fold((l) => expect(l, isA<UseCaseException>()), (r) => null);
  });
}

    // expect(result, Right<Failure, List<Session>>(_mockedList));
// expect(l, isA<UseCaseException>())