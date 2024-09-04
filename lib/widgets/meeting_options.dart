import 'package:flutter/material.dart';
import 'package:zoom_clone/resources/colors.dart';

class MeetingOptions extends StatelessWidget {
  final String text;
  final bool isMuted;
  final Function(bool) onChanged;
  const MeetingOptions({super.key, required this.text, required this.isMuted, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: secondaryBackgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Switch.adaptive(value: isMuted, onChanged: onChanged)
        ],
      ),
    );
  }
}
