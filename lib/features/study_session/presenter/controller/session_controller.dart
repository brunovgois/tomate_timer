import 'package:flutter/material.dart';
import 'package:tomate_timer/core/mapper/mapper.dart';
import 'package:tomate_timer/features/study_session/domain/entities/session.dart';
import 'package:tomate_timer/features/study_session/domain/usecases/findall_sessions_usecase.dart';
import 'package:tomate_timer/features/study_session/domain/usecases/save_session_usecase.dart';
import 'package:tomate_timer/features/study_session/infra/dto/session_dto.dart';

class SessionController extends ChangeNotifier {
  final SaveSessionUseCase saveSessionUseCase;
  final FindAllSessionsUseCase findAllSessionsUseCase;
  final Mapper _mapper;

  SessionController(
      this.saveSessionUseCase, this.findAllSessionsUseCase, this._mapper);

  SessionDTO dto = new SessionDTO();
  ValueNotifier<List<SessionDTO>> sessions = ValueNotifier([]);

  Future<String> findAllSessions() async {
    var result = await findAllSessionsUseCase.findAll();

    return result.fold(
      (l) => ('Something whent wrong: ' + l.props[0]),
      (r) {
        sessions.value =
            r.map((e) => this._mapper.to(e)).toList().cast<SessionDTO>();

        sessions.notifyListeners();
        return 'Success!';
      },
    );
  }

  Future<String> saveSession() async {
    Session session = _mapper.from(this.dto);

    sessions.value.add(this.dto);
    sessions.notifyListeners();

    var result = await saveSessionUseCase.save(session);
    return result.fold(
      (l) => ('Something went wrong: ' + l.props[0]),
      (r) => ('Success!'),
    );
  }
}
