import 'package:flutter_modular/flutter_modular.dart';
import 'package:tomate_timer/features/study_session/domain/usecases/findall_sessions_usecase.dart';
import 'package:tomate_timer/features/study_session/domain/usecases/findall_sessions_usecase_imp.dart';
import 'package:tomate_timer/features/study_session/domain/usecases/save_session_usecase.dart';
import 'package:tomate_timer/features/study_session/domain/usecases/save_session_usecase_imp.dart';
import 'package:tomate_timer/features/study_session/external/datasources/session_datasource_imp.dart';
import 'package:tomate_timer/features/study_session/infra/datasources/session_datasource.dart';
import 'package:tomate_timer/features/study_session/infra/mapper/session_mapper.dart';
import 'package:tomate_timer/features/study_session/infra/repositories/session_repository_imp.dart';
import 'package:tomate_timer/features/study_session/presenter/UI/sessions_page..dart';
import 'package:tomate_timer/features/study_session/presenter/controller/session_controller.dart';
import 'package:tomate_timer/features/study_session/presenter/controller/timer_controller.dart';

class StudySessionModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => SessionMapper()),
        Bind<SessionDatasource>((i) => SessionDatasourceImp()),
        Bind((i) => SessionRepositoryImp(i.get(), i.get())),
        Bind<SaveSessionUseCase>((i) => SaveSessionUseCaseImp(i.get())),
        Bind<FindAllSessionsUseCase>((i) => FindAllSessionsUseCaseImp(i.get())),
        Bind<SessionController>(
            (i) => SessionController(i.get(), i.get(), i.get())),
        Bind((i) => TimerController())
      ];

  @override
  List<ModularRouter> get routers =>
      [ModularRouter("/", child: (_, __) => SessionsPage())];
}
