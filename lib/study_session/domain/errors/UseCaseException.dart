import 'package:tomate_timer/core/errors/failure.dart';

class UseCaseException extends Failure {
  final String errorMessage;
  UseCaseException(this.errorMessage);

  @override
  List<Object> get props => [this.errorMessage];
}
