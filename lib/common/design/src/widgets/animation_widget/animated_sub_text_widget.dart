
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimatedSubTextWidget extends StatelessWidget {
  final Widget child;

  const AnimatedSubTextWidget({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return child
        .animate()
        .fadeIn(
      duration: 600.ms,
      delay: 150.ms, // ⏱️ يتأخر شوي عن العنوان
    )
        .move(
      begin: const Offset(0, 8), // ⬇️ حركة خفيفة من تحت
      end: Offset.zero,
      duration: 500.ms,
      curve: Curves.easeOutCubic,
    );
  }
}