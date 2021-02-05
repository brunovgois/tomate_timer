import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tomate_timer/core/errors/failure.dart';
import 'package:tomate_timer/features/study_session/domain/entities/session.dart';
import 'package:tomate_timer/features/study_session/domain/repositories/session_repository.dart';
import 'package:tomate_timer/features/study_session/domain/usecases/findall_sessions_usecase.dart';
import 'package:tomate_timer/features/study_session/domain/usecases/findall_sessions_usecase_imp.dart';

import 'session_repository_mock.dart';

void main() {
  SessionRepository _repository;
  FindAllSessionsUseCase _useCase;

  List<Session> _mockedList = [
    Session(title: 'first Item'),
    Session(title: 'second Item')
  ];

  setUp(() async {
    _repository = SessionRepositoryMock();
    _useCase = FindAllSessionsUseCaseImp(_repository);
  });

  test("Should return a reversed list on FindAll", () async {
    when(_repository.findAll())
        .thenAnswer((_) async => Right<Failure, List<Session>>(_mockedList));
    var result = await _useCase.findAll();

    expect(result, Right<Failure, List<Session>>(_mockedList));
  });
}
