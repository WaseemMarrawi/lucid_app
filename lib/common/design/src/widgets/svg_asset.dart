
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgAsset extends StatelessWidget {
  const SvgAsset(
    this.assetName, {
    super.key,
    this.color,
    this.width = 25,
    this.height = 25,

  });
  final Color? color;
  final double width;
  final double height;

  final String assetName;
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetName,
      color: color,
      width: width,
      height: height,
      fit: BoxFit.contain,


    );
  }
}

