import 'package:dartz/dartz.dart';
import 'package:tomate_timer/core/errors/failure.dart';
import 'package:tomate_timer/study_session/domain/entities/session.dart';
import 'package:tomate_timer/study_session/domain/errors/UseCaseException.dart';
import 'package:tomate_timer/study_session/domain/repositories/session_repository.dart';
import 'package:tomate_timer/study_session/domain/usecases/findall_sessions_usecase.dart';

class FindAllSessionsUseCaseImp implements FindAllSessionsUseCase {
  final SessionRepository _repository;

  FindAllSessionsUseCaseImp(this._repository);

  @override
  Future<Either<Failure, List<Session>>> findAll() async {
    var result = await _repository.findAll();
    return result.fold(
      (l) => Left(UseCaseException('Error retrieving all sessions')),
      (r) => Right(r),
    );
  }
}
