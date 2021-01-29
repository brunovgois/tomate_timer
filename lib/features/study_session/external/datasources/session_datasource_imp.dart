import 'package:sqflite/sqflite.dart';
import 'package:tomate_timer/features/study_session/infra/datasources/session_datasource.dart';
import 'package:tomate_timer/features/study_session/infra/dto/session_dto.dart';
import 'package:tomate_timer/features/study_session/external/app_database.dart';

class SessionDatasourceImp implements SessionDatasource {
  static const String _tableName = 'sessions';
  static const String _duration = 'duration';
  static const String _title = 'title';
  static const String _date = 'date';

  static const String tableSql = 'CREATE TABLE $_tableName('
      '$_duration TEXT,'
      '$_title Text,'
      '$_date Text)';

  @override
  Future<List<SessionDTO>> findAll() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableName);
    List<SessionDTO> sessions = _toList(result);
    return sessions;
  }

  @override
  Future<void> save(SessionDTO sessionDTO) async {
    final Database db = await getDatabase();
    Map<String, dynamic> sessionMap = _toMap(sessionDTO);

    return db.insert(_tableName, sessionMap);
  }

  Map<String, dynamic> _toMap(SessionDTO sessionDTO) {
    final Map<String, dynamic> sessionMap = Map();
    sessionMap[_duration] = sessionDTO.duration;
    sessionMap[_title] = sessionDTO.title;
    sessionMap[_date] = sessionDTO.date;

    return sessionMap;
  }

  List<SessionDTO> _toList(List<Map<String, dynamic>> result) {
    final List<SessionDTO> sessionsDTO = [];
    for (Map<String, dynamic> row in result) {
      final SessionDTO sessionDTO = SessionDTO(
        date: row[_date],
        duration: row[_duration],
        title: row[_title],
      );
      sessionsDTO.add(sessionDTO);
    }
    return sessionsDTO;
  }
}
