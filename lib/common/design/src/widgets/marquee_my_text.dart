
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class MarqueeMyText extends StatelessWidget {
  final String text;

  const MarqueeMyText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // Ensures it takes full available width
      child: Marquee(
        text: text,
        scrollAxis: Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.start,
        blankSpace: 70,
        pauseAfterRound: Duration(seconds: 4),
        startPadding: 10.0,
        accelerationDuration: Duration(seconds: 2),
        accelerationCurve: Curves.linear,
        decelerationDuration: Duration(milliseconds: 500),
        decelerationCurve: Curves.easeOut,
      ),
    );
  }
}

