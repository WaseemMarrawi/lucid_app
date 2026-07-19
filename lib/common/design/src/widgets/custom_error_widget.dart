import 'package:flutter/material.dart';

import '../../../extensions/src/context_extensions.dart';
import '../../design.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({
    super.key,
    this.height,
    required this.onTap,
    required this.errorMessage,
  });

  final VoidCallback onTap;
  final String? errorMessage;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? context.height * .6,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              errorMessage ?? "Unknown error",
              style: context.bodyLarge(
                color: context.primarySwatch,
                fontSize: 20,
              ),
            ),
            Space.vM2,
            CustomButton.primary(
              textTitle: "Retry",
              width: context.width * .35,
              onPressed: onTap,
            )
          ],
        ),
      ),
    );
  }
}
