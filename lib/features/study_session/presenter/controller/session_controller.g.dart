// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SessionController on Controller, Store {
  final _$sessionsAtom = Atom(name: 'Controller.sessions');

  @override
  ObservableList<SessionDTO> get sessions {
    _$sessionsAtom.reportRead();
    return super.sessions;
  }

  @override
  set sessions(ObservableList<SessionDTO> value) {
    _$sessionsAtom.reportWrite(value, super.sessions, () {
      super.sessions = value;
    });
  }

  final _$findAllSessionsAsyncAction =
      AsyncAction('Controller.findAllSessions');

  @override
  Future<String> findAllSessions() {
    return _$findAllSessionsAsyncAction.run(() => super.findAllSessions());
  }

  final _$saveSessionAsyncAction = AsyncAction('Controller.saveSession');

  @override
  Future<String> saveSession() {
    return _$saveSessionAsyncAction.run(() => super.saveSession());
  }

  @override
  String toString() {
    return '''
sessions: ${sessions}
    ''';
  }
}
