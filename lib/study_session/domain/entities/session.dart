import 'package:equatable/equatable.dart';

class Session extends Equatable {
  final int duration;
  final String title;
  final String description;

  Session({this.duration, this.description, this.title});

  @override
  List<Object> get props => [this.duration, this.title, this.description];

  @override
  String toString() {
    return 'Session(duration: $duration, title: $title, description: $description)';
  }
}
