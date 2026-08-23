import 'package:flutter/material.dart';

class VoiceCircleIcon extends StatelessWidget {
  const VoiceCircleIcon({
    required this.icon,
    this.isRecording = false,
    this.animation,
    super.key,
  });

  final IconData icon;

  final bool isRecording;

  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    final circle = Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Icon(
        icon,
        color: Colors.white,
        size: 25,
      ),
    );

    if (!isRecording || animation == null) {
      return circle;
    }

    return AnimatedBuilder(
      animation: animation!,
      child: circle,
      builder: (
          context,
          child,
          ) {
        final value = animation!.value;

        final scale = 0.94 + (value * 0.10);

        final opacity = 0.70 + (value * 0.30);

        return Transform.scale(
          scale: scale,
          child: Opacity(
            opacity: opacity,
            child: child,
          ),
        );
      },
    );
  }
}