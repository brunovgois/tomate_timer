import 'package:tomate_timer/core/mapper/mapper.dart';
import 'package:tomate_timer/study_session/domain/entities/session.dart';
import 'package:tomate_timer/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tomate_timer/study_session/domain/repositories/session_repository.dart';
import 'package:tomate_timer/study_session/infra/datasources/session_datasource.dart';
import 'package:tomate_timer/study_session/infra/dto/session_dto.dart';
import 'package:tomate_timer/study_session/infra/errors/repository_exception.dart';

class SessionRepositoryImp implements SessionRepository {
  final SessionDatasource _datasource;
  final Mapper _mapper;

  SessionRepositoryImp(this._datasource, this._mapper);

  @override
  Future<Either<Failure, List<Session>>> findAll() async {
    try {
      var result = await _datasource.findAll();
      return Right(
          result.map((e) => this._mapper.from(e)).toList().cast<Session>());
    } catch (e) {
      return Left(RepositoryException('Error on repository findAll.'));
    }
  }

  @override
  Future<Either<Failure, Session>> save(Session session) async {
    try {
      SessionDTO sessionDTO = this._mapper.to(session);
      await _datasource.save(sessionDTO);
      return Right(session);
    } catch (e) {
      return Left(RepositoryException('Error on repository save.'));
    }
  }
}
