import 'package:dartz/dartz.dart';
import 'package:tomate_timer/core/errors/failure.dart';
import 'package:tomate_timer/features/study_session/domain/entities/session.dart';

abstract class SaveSessionUseCase {
  Future<Either<Failure, Session>> save([Session session]);
}
