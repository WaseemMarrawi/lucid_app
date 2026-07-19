

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimatedTitleTextWidget extends StatelessWidget {
  final Widget child;

  const AnimatedTitleTextWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return child.animate()
        .fadeIn(duration: 500.ms)
        .scale(
      begin: const Offset(0.95, 0.95),
      end: const Offset(1, 1),
      duration: 400.ms,
      curve: Curves.easeOutCubic,
    )
        .move(
      begin: const Offset(16, 0),
      end: Offset.zero,
      duration: 400.ms,
      curve: Curves.easeOutCubic,
    );
  }

}
