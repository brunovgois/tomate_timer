import 'package:tomate_timer/core/errors/failure.dart';

class RepositoryException extends Failure {
  final String errorMessage;
  RepositoryException(this.errorMessage);

  @override
  List<Object> get props => [this.errorMessage];
}
