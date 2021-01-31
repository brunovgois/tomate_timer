import 'package:flutter_modular/flutter_modular.dart';
import 'package:tomate_timer/features/study_session/domain/usecases/findall_sessions_usecase_imp.dart';
import 'package:tomate_timer/features/study_session/domain/usecases/save_session_usecase_imp.dart';
import 'package:tomate_timer/features/study_session/external/datasources/session_datasource_imp.dart';
import 'package:tomate_timer/features/study_session/infra/mapper/session_mapper.dart';
import 'package:tomate_timer/features/study_session/infra/repositories/session_repository_imp.dart';
import 'package:tomate_timer/features/study_session/presenter/UI/sessions_page..dart';
import 'package:tomate_timer/features/study_session/presenter/controller/session_controller.dart';

class StudySessionModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => SessionMapper()),
        Bind((i) => SessionDatasourceImp()),
        Bind((i) => SessionRepositoryImp(i.get(), i.get())),
        Bind((i) => SaveSessionUseCaseImp(i.get())),
        Bind((i) => FindAllSessionsUseCaseImp(i.get())),
        Bind((i) => SessionController(i.get(), i.get(), i.get()))
      ];

  @override
  List<ModularRouter> get routers =>
      [ModularRouter("/", child: (_, __) => SessionsPage())];
}
