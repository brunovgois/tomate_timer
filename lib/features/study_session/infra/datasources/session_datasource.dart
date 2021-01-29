import 'package:tomate_timer/features/study_session/infra/dto/session_dto.dart';

abstract class SessionDatasource {
  Future<void> save(SessionDTO sessionDTO);
  Future<List<SessionDTO>> findAll();
}
