import 'package:flutter/material.dart';
import 'package:tomate_timer/core/mapper/mapper.dart';
import 'package:tomate_timer/features/study_session/domain/repositories/session_repository.dart';
import 'package:tomate_timer/features/study_session/domain/usecases/findall_sessions_usecase.dart';
import 'package:tomate_timer/features/study_session/domain/usecases/findall_sessions_usecase_imp.dart';
import 'package:tomate_timer/features/study_session/domain/usecases/save_session_usecase.dart';
import 'package:tomate_timer/features/study_session/domain/usecases/save_session_usecase_imp.dart';
import 'package:tomate_timer/features/study_session/external/datasources/session_datasource_imp.dart';
import 'package:tomate_timer/features/study_session/infra/datasources/session_datasource.dart';
import 'package:tomate_timer/features/study_session/infra/mapper/session_mapper.dart';
import 'package:tomate_timer/features/study_session/infra/repositories/session_repository_imp.dart';
import 'package:tomate_timer/features/study_session/presenter/UI/widgets/tracker_form.dart';
import 'package:tomate_timer/features/study_session/presenter/UI/widgets/tracker_list.dart';
import 'package:tomate_timer/features/study_session/presenter/controller/session_controller.dart';

class SessionsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SessionsPageState();
}

class _SessionsPageState extends State<SessionsPage> {
  SessionController controller;

  _SessionsPageState() {
    Mapper _mapper = SessionMapper();
    SessionDatasource _datasource = SessionDatasourceImp();
    SessionRepository _repository = SessionRepositoryImp(_datasource, _mapper);
    SaveSessionUseCase _saveSessionUseCase = SaveSessionUseCaseImp(_repository);
    FindAllSessionsUseCase _findAllSessionsUseCase =
        FindAllSessionsUseCaseImp(_repository);
    controller = SessionController(
        _saveSessionUseCase, _findAllSessionsUseCase, _mapper);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tomate Timer'),
      ),
      body: SafeArea(
        bottom: true,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TrackerForm(controller: controller),
              TrackerList(controller: controller),
            ],
          ),
        ),
      ),
    );
  }
}
