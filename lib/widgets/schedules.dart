import 'package:flutter/material.dart';
import 'package:schedorganizer/helpers/ui.dart';
import 'package:schedorganizer/models/schedule.dart';
import 'package:schedorganizer/widgets/timer.dart';

class SchedulesWidget extends StatelessWidget {
  const SchedulesWidget(
      {super.key, required this.schedules, this.isTimer = false});

  final List<Schedule> schedules;
  final bool isTimer;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: schedules.length,
      itemBuilder: (context, i) {
        final schedule = schedules[i];

        return UI.card(
          Text(schedule.subject.name),
          Text(schedule.timezone.toString()),
          const Icon(Icons.timer),
          trailing: i == 0 && isTimer
              ? TimerWidget(timezone: schedule.timezone)
              : null,
        );
      },
    );
  }
}
