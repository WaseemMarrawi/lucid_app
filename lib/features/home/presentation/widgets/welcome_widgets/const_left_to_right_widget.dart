
import 'package:flutter/material.dart';

class ConstLeftToRightWidget extends StatelessWidget {
  final Widget child;

  const ConstLeftToRightWidget({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: child,
    );
  }
}
