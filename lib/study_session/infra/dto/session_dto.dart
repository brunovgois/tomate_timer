class SessionDTO {
  final String duration;
  final String title;
  final String date;

  SessionDTO({this.duration, this.title, this.date});

  SessionDTO copyWith({
    String duration,
    String title,
    String date,
  }) {
    return SessionDTO(
        duration: duration ?? this.duration,
        title: title ?? this.title,
        date: date ?? this.date);
  }

  @override
  String toString() {
    return 'SessionDTO(duration: $duration, title: $title, date: $date)';
  }
}
