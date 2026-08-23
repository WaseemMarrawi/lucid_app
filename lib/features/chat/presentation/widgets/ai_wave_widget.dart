
import 'dart:math' as math;

import 'package:flutter/material.dart';

class AiWaveWidget extends StatefulWidget {
  const AiWaveWidget({super.key});

  @override
  State<AiWaveWidget> createState() => _AiWaveWidgetState();
}

class _AiWaveWidgetState extends State<AiWaveWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 850),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(14, (index) {
            final progress = (_controller.value + (index * 0.09)) % 1.0;

            final wave = (math.sin(progress * math.pi * 2) + 1) / 2;

            final height = 7 + (wave * 28);

            return Container(
              width: 4,
              height: height,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
            );
          }),
        );
      },
    );
  }
}
