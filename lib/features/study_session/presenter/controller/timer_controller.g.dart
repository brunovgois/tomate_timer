// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timer_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TimerController on Controller, Store {
  final _$elapsedTimeAtom = Atom(name: 'Controller.elapsedTime');

  @override
  String get elapsedTime {
    _$elapsedTimeAtom.reportRead();
    return super.elapsedTime;
  }

  @override
  set elapsedTime(String value) {
    _$elapsedTimeAtom.reportWrite(value, super.elapsedTime, () {
      super.elapsedTime = value;
    });
  }

  final _$isTimerOffAtom = Atom(name: 'Controller.isTimerOff');

  @override
  bool get isTimerOff {
    _$isTimerOffAtom.reportRead();
    return super.isTimerOff;
  }

  @override
  set isTimerOff(bool value) {
    _$isTimerOffAtom.reportWrite(value, super.isTimerOff, () {
      super.isTimerOff = value;
    });
  }

  final _$ControllerActionController = ActionController(name: 'Controller');

  @override
  dynamic startOrStop() {
    final _$actionInfo = _$ControllerActionController.startAction(
        name: 'Controller.startOrStop');
    try {
      return super.startOrStop();
    } finally {
      _$ControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
elapsedTime: ${elapsedTime},
isTimerOff: ${isTimerOff}
    ''';
  }
}
