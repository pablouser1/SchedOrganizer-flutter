import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:schedorganizer/common.dart';
import 'package:schedorganizer/models/apires.dart';
import 'package:schedorganizer/models/schedule.dart';
import 'package:schedorganizer/widgets/drawer.dart';
import 'package:schedorganizer/widgets/loading.dart';
import 'package:schedorganizer/widgets/schedules.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<ApiRes<List<Schedule>>> futureSchedules;

  @override
  void initState() {
    super.initState();
    futureSchedules = api.getClosestSchedules();
  }

  Future<void> _pullRefresh() async {
    ApiRes<List<Schedule>> freshSchedules = await api.getClosestSchedules();
    setState(() {
      futureSchedules = Future.value(freshSchedules);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("SchedOrganizer"),
      ),
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          physics: const BouncingScrollPhysics(),
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
            PointerDeviceKind.trackpad,
          },
        ),
        child: FutureBuilder<ApiRes<List<Schedule>>>(
          future: futureSchedules,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data!.data;

              return RefreshIndicator(
                onRefresh: _pullRefresh,
                child: SchedulesWidget(
                  schedules: data,
                  isTimer: true,
                ),
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            return const LoadingWidget();
          },
        ),
      ),
      drawer: DrawerWidget(),
    );
  }
}
