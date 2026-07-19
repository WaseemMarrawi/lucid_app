import 'package:flutter/material.dart';

import '../../../extensions/src/context_extensions.dart';
import '../../design.dart';

class CustomButton extends StatelessWidget {


  final Widget? icon;
  final String? textTitle;
  final VoidCallback? onPressed;

  final Color? backgroundColor;
  final BorderSide? borderSide;
  final Color? textColor;
  final double? width;
  final double? height;




  const CustomButton({
    super.key,
    this.textTitle,
    this.onPressed,
    required this.borderSide,
    required this.backgroundColor,
    required this.textColor,
    this.height,
    this.width,
    this.icon,
  });
  const CustomButton.primary({
    super.key,
    this.height,
    this.width,
    this.textTitle,
    this.onPressed,
    this.icon,
    this.backgroundColor = null,
  })  : textColor = Colors.white,
        borderSide = BorderSide.none;

  CustomButton.withBorder({
    super.key,
    this.height,
    this.width,
    this.textTitle,
    this.onPressed,
    this.icon,
    Color? color = null,
  })  : backgroundColor = null,
        borderSide =null,
        textColor = color;


  @override
  Widget build(BuildContext context) {
    final Color effectiveBackgroundColor = backgroundColor ?? context.theme.primaryColor;
    final BorderSide effectiveBorderSide = borderSide ?? BorderSide.none;
    final Color effectiveTextColor = textColor ?? context.theme.colorScheme.onPrimary;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: effectiveBackgroundColor,
        disabledBackgroundColor: effectiveBackgroundColor.withOpacity(0.5),
        minimumSize: Size(width ?? context.width * .9, height ?? 56),
        maximumSize: Size(width ?? context.width * .9, height ?? 56),
        shape: RoundedRectangleBorder(
          side: effectiveBorderSide,
          borderRadius: BorderRadius.circular(PRadius.container),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) icon!,
          if (icon != null && textTitle != null) Space.hM1,
          if (textTitle != null)
            FittedBox(
              child: Text(
                textTitle!,
                style: context.labelSmall(
                  color: effectiveTextColor,
                  fontSize: 16,
                ),
              ),
            ),
        ],
      ),
    );
  }

}
