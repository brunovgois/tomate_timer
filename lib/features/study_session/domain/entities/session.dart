import 'package:equatable/equatable.dart';

class Session extends Equatable {
  final String duration;
  final String title;
  final String date;

  Session({this.duration, this.date, this.title});

  @override
  List<Object> get props => [this.duration, this.title, this.date];

  @override
  String toString() {
    return 'Session(duration: $duration, title: $title, date: $date)';
  }
}
