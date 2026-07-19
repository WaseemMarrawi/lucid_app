import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';


class FlippableImage extends StatelessWidget {
  final Widget child;


  const FlippableImage({
    super.key,
    required this.child,

  });

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()
        ..rotateY(context.locale.languageCode != 'ar' ? 3.1415926535897932 : 0),
      child: child,
    );
  }
}
