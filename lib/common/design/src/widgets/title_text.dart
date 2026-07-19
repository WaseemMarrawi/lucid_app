import 'package:flutter/material.dart';

import '../../../extensions/extensions.dart';
import '../../design.dart';

class TitleText extends StatelessWidget {
  const TitleText({
    super.key,
    required this.title,
    required this.child,
    this.style,
    this.spaceWidget,
    this.withDot = false,
  });
  final String title;
  final bool withDot;
  final Widget child;
  final Widget? spaceWidget;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        (withDot)
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(radius: 5),
                  Space.hS1,
                  Text(
                    title,
                    style: style ??
                        context.titleLarge(fontSize: 14),
                  )
                ],
              )
            : Text(
                title,
                style: style ?? context.titleSmall(),
              ),
        spaceWidget ?? Space.vS2,
        child,
        Space.vM1,
      ],
    );
  }
}
