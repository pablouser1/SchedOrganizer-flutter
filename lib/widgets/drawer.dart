import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:schedorganizer/helpers/nav.dart';
import 'package:schedorganizer/pages/schedules.dart';
import 'package:schedorganizer/pages/settings.dart';

class DrawerWidget extends StatelessWidget {
  DrawerWidget({super.key});

  final days =
      DateFormat.EEEE(Platform.localeName).dateSymbols.STANDALONEWEEKDAYS;

  final now = DateTime.now();

  List<Widget> _buildExpandable(BuildContext context) {
    return days
        .asMap()
        .entries
        .map((entry) => ListTile(
              title: Text(
                toBeginningOfSentenceCase(entry.value)!,
                style: TextStyle(
                    fontWeight: now.weekday == entry.key
                        ? FontWeight.bold
                        : FontWeight.normal),
              ),
              onTap: () => Nav.push(context, SchedulesPage(weekday: entry.key)),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              "SchedOrganizer",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              textAlign: TextAlign.end,
            ),
          ),
          ExpansionTile(
            title: const Text("Schedules"),
            children: _buildExpandable(context),
          ),
          ListTile(
            title: const Text("Settings"),
            leading: const Icon(Icons.settings),
            onTap: () {
              Nav.push(context, const SettingsPage());
            },
          ),
        ],
      ),
    );
  }
}
