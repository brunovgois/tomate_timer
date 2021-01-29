import 'dart:async';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'sessions.db');
  return openDatabase(path, version: 1, onCreate: _onCreate);
}

void _onCreate(Database db, int version) async {
  String sql = await rootBundle.loadString(
      "lib/core/external/database/scripts/create_sessions_table.sql");

  if (sql.trim().isNotEmpty) {
    await db.execute(sql);
  }
}
