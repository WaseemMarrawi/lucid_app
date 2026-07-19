
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimatedScaleWidget extends StatelessWidget {
  final Widget child;

  const AnimatedScaleWidget({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    return child.animate()
        .fadeIn(delay: 200.ms, duration: 600.ms)
        .scale(
      begin: const Offset(0.9, 0.9),
      end: const Offset(1, 1),
      curve: Curves.elasticOut,
    );
  }
}
