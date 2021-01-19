import 'package:dartz/dartz.dart';
import 'package:tomate_timer/core/errors/failure.dart';
import 'package:tomate_timer/study_session/domain/entities/session.dart';

abstract class SessionRepository {
  Future<Either<Failure, Session>> save(Session session);
  Future<Either<Failure, List<Session>>> findAll();
}
