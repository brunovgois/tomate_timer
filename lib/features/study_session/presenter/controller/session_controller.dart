import 'package:mobx/mobx.dart';
import 'package:tomate_timer/core/mapper/mapper.dart';
import 'package:tomate_timer/features/study_session/domain/entities/session.dart';
import 'package:tomate_timer/features/study_session/domain/usecases/findall_sessions_usecase.dart';
import 'package:tomate_timer/features/study_session/domain/usecases/save_session_usecase.dart';
import 'package:tomate_timer/features/study_session/infra/dto/session_dto.dart';

part 'session_controller.g.dart';

class SessionController = Controller with _$SessionController;

abstract class Controller with Store {
  final SaveSessionUseCase saveSessionUseCase;
  final FindAllSessionsUseCase findAllSessionsUseCase;
  final Mapper _mapper;

  Controller(
      this.saveSessionUseCase, this.findAllSessionsUseCase, this._mapper);

  SessionDTO dto = new SessionDTO();

  @observable
  ObservableList<SessionDTO> sessions = <SessionDTO>[].asObservable();

  @action
  Future<String> findAllSessions() async {
    var result = await findAllSessionsUseCase.findAll();

    return result.fold(
      (l) => ('Something whent wrong: ' + l.props[0]),
      (r) {
        sessions = r.map((e) => this._mapper.to(e)).toList().cast<SessionDTO>();
        return 'Success!';
      },
    );
  }

  @action
  Future<String> saveSession() async {
    Session session = _mapper.from(this.dto);

    var result = await saveSessionUseCase.save(session);

    return result.fold(
      (l) => ('Something went wrong: ' + l.props[0]),
      (r) {
        sessions.add(this.dto);
        return 'Success!';
      },
    );
  }
}
