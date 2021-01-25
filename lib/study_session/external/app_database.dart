import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tomate_timer/study_session/external/datasources/session_datasource_imp.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'sessions.db');
  return openDatabase(path, onCreate: (db, version) {
    db.execute(SessionDatasourceImp.tableSql);
  }, version: 1);
}
