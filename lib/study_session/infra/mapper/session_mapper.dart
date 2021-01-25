import 'package:tomate_timer/core/mapper/mapper.dart';
import 'package:tomate_timer/study_session/domain/entities/session.dart';
import 'package:tomate_timer/study_session/infra/dto/session_dto.dart';

class SessionMapper implements Mapper<SessionDTO, Session> {
  @override
  Session from([SessionDTO object]) => Session(
        date: object?.date ?? '',
        duration: object?.duration ?? 0,
        title: object?.title ?? '',
      );

  @override
  SessionDTO to([Session object]) => SessionDTO(
        date: object?.date ?? '',
        duration: object?.duration ?? 0,
        title: object?.title ?? '',
      );
}
