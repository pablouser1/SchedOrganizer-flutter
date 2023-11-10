import 'package:flutter/material.dart';

class Nav {
  static void push(BuildContext context, Widget page,
      {bool requiresLogin = false}) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => page,
      ),
    );
  }
}
