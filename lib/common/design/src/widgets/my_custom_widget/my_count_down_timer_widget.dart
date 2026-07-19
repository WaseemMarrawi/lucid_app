import 'dart:async';
import 'package:flutter/material.dart';

import '../../../../extensions/src/context_extensions.dart';

class MyCountDownTimerWidget extends StatefulWidget {
  final ValueNotifier<bool> isTimeEnd;

  const MyCountDownTimerWidget({super.key, required this.isTimeEnd});

  @override
  State<MyCountDownTimerWidget> createState() => _MyCountDownTimerWidgetState();
}

class _MyCountDownTimerWidgetState extends State<MyCountDownTimerWidget> {
  static const int _initialTimeInSeconds = 90; // 5 دقائق
  late int _remainingSeconds;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer(); // يبدأ فورًا
  }

  void _startTimer() {
    _remainingSeconds = _initialTimeInSeconds;
    widget.isTimeEnd.value = false; // العداد بدأ، لم ينتهِ بعد

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        timer.cancel();
        widget.isTimeEnd.value = true; // العداد انتهى
      }
    });
  }

  String _formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$secs';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _formatTime(_remainingSeconds),
      style: context.bodySmall(fontWeight: FontWeight.w600, fontSize: 16),
    );
  }
}
