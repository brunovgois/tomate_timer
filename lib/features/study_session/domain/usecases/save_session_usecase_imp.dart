import 'package:dartz/dartz.dart';
import 'package:tomate_timer/core/errors/failure.dart';
import 'package:tomate_timer/features/study_session/domain/entities/session.dart';
import 'package:tomate_timer/features/study_session/domain/errors/UseCaseException.dart';
import 'package:tomate_timer/features/study_session/domain/repositories/session_repository.dart';
import 'package:tomate_timer/features/study_session/domain/usecases/save_session_usecase.dart';

class SaveSessionUseCaseImp implements SaveSessionUseCase {
  final SessionRepository _repository;
  SaveSessionUseCaseImp(this._repository);

  @override
  Future<Either<Failure, Session>> save([Session session]) async {
    var result = await _repository.save(session);
    return result.fold(
      (l) => Left(UseCaseException('Error saving current Session.')),
      (r) => Right(r),
    );
  }
}
