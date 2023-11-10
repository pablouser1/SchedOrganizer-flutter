import 'package:flutter/material.dart';
import 'package:schedorganizer/common.dart';
import 'package:schedorganizer/models/apires.dart';
import 'package:schedorganizer/models/schedule.dart';
import 'package:schedorganizer/widgets/loading.dart';
import 'package:schedorganizer/widgets/schedules.dart';

class SchedulesPage extends StatefulWidget {
  const SchedulesPage({super.key, required this.weekday});

  final int weekday;

  @override
  State<SchedulesPage> createState() => _SchedulesPageState();
}

class _SchedulesPageState extends State<SchedulesPage> {
  late Future<ApiRes<List<Schedule>>> futureSchedules;

  @override
  void initState() {
    super.initState();
    futureSchedules = api.getSchedulesByWeekday(widget.weekday);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Schedules"),
      ),
      body: FutureBuilder<ApiRes<List<Schedule>>>(
        future: futureSchedules,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!.data;

            return SchedulesWidget(
              schedules: data,
              isTimer: false,
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          return const LoadingWidget();
        },
      ),
    );
  }
}
