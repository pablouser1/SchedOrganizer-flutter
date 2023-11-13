import 'package:flutter/material.dart';

class TextIconWidget extends StatelessWidget {
  const TextIconWidget({super.key, required this.text, required this.icon});

  final InlineSpan text;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          WidgetSpan(child: icon),
          text,
        ],
      ),
    );
  }
}
