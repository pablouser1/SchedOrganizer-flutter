import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:schedorganizer/models/timezone.dart';

class TimerWidget extends StatefulWidget {
  const TimerWidget({super.key, required this.timezone});

  final Timezone timezone;

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  late final DateTime startTime;
  late final DateTime finishTime;
  late final Timer t;
  bool isHappening = false;

  String result = "";

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60).abs());
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60).abs());
    return "${twoDigits(duration.inHours.abs())}:$twoDigitMinutes:$twoDigitSeconds";
  }

  void handleTimer(Timer timer) {
    DateTime now = DateTime.now();

    final nowTimeStr = DateFormat.Hms().format(now);
    final nowTime = DateFormat.Hms().parse(nowTimeStr);

    final String res;

    if (isHappening) {
      // Event is already happening
      Duration diff = finishTime.difference(nowTime);

      if (diff.isNegative) {
        // It's over, stops program
        res = "Finished";
        timer.cancel();
      } else {
        // Still happening
        res = "${_printDuration(diff)} passed";
      }
    } else {
      // Calc time remaining to start
      Duration diff = nowTime.difference(startTime);
      res = "${_printDuration(diff)} early";
      // Check if it's already happening
      isHappening = !diff.isNegative;
    }

    setState(() {
      result = res;
    });
  }

  @override
  void initState() {
    super.initState();
    startTime = DateFormat.Hms().parse(widget.timezone.start);
    finishTime = DateFormat.Hms().parse(widget.timezone.finish);
    t = Timer.periodic(
      const Duration(seconds: 1),
      handleTimer,
    );

    handleTimer(t);
  }

  @override
  void dispose() {
    t.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(result);
  }
}
