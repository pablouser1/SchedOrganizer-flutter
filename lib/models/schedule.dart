import 'package:schedorganizer/models/subject.dart';
import 'package:schedorganizer/models/timezone.dart';

class Schedule {
  final int id;
  final Subject subject;
  final int weekday;
  final Timezone timezone;

  Schedule({
    required this.id,
    required this.subject,
    required this.weekday,
    required this.timezone,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      id: json['id'],
      subject: Subject.fromJson(json['subject']),
      weekday: json['weekday'],
      timezone: Timezone.fromJson(json['timezone']),
    );
  }
}
