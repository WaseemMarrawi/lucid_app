import 'package:flutter/material.dart';

abstract class LayoutConstrains {
  LayoutConstrains._();

  static const s1 = 2.0;
  static const s2 = 4.0;
  static const s3 = 8.0;
  static const m1 = 12.0;
  static const m2 = 16.0;
  static const m3 = 20.0;
  static const m4 = 24.0;
  static const l1 = 32.0;
  static const l2 = 40.0;
  static const l3 = 48.0;
  static const xl1 = 64.0;
  static const xl2 = 72.0;
  static const xl3 = 80.0;
  static const xxl1 = 96.0;
  static const xxl2 = 128;
  static const xxl3 = 160;
}

abstract class Space {
  Space._();

  static const vS1 = RSizedBox.vertical(LayoutConstrains.s1);
  static const  vS2 = RSizedBox.vertical(LayoutConstrains.s2);
  static const vS3 = RSizedBox.vertical(LayoutConstrains.s3);
  static const vM1 = RSizedBox.vertical(LayoutConstrains.m1);
  static const vM2 = RSizedBox.vertical(LayoutConstrains.m2);
  static const vM3 = RSizedBox.vertical(LayoutConstrains.m3);
  static const vM4 = RSizedBox.vertical(LayoutConstrains.m4);
  static const vL1 = RSizedBox.vertical(LayoutConstrains.l1);
  static const vL2 = RSizedBox.vertical(LayoutConstrains.l2);
  static const vL3 = RSizedBox.vertical(LayoutConstrains.l3);
  static const vXL1 = RSizedBox.vertical(LayoutConstrains.xl1);
  static const vXL2 = RSizedBox.vertical(LayoutConstrains.xl2);
  static const vXL3 = RSizedBox.vertical(LayoutConstrains.xl3);

  ///////////////////////////////////////////////////////////
  static const hS1 = RSizedBox.horizontal(LayoutConstrains.s1);
  static const hS2 = RSizedBox.horizontal(LayoutConstrains.s2);
  static const hS3 = RSizedBox.horizontal(LayoutConstrains.s3);
  static const hM1 = RSizedBox.horizontal(LayoutConstrains.m1);
  static const hM2 = RSizedBox.horizontal(LayoutConstrains.m2);
  static const hM3 = RSizedBox.horizontal(LayoutConstrains.m3);
  static const hM4 = RSizedBox.horizontal(LayoutConstrains.m4);
  static const hL1 = RSizedBox.horizontal(LayoutConstrains.l1);
  static const hL2 = RSizedBox.horizontal(LayoutConstrains.l2);
  static const hL3 = RSizedBox.horizontal(LayoutConstrains.l3);
  static const hXL1 = RSizedBox.horizontal(LayoutConstrains.xl1);
  static const hXL2 = RSizedBox.horizontal(LayoutConstrains.xl2);
  static const hXL3 = RSizedBox.horizontal(LayoutConstrains.xl3);
}

class RSizedBox extends StatelessWidget {
  const RSizedBox(
    this.width,
    this.heigth, {
    super.key,
  });
  final double width;
  final double heigth;
  const RSizedBox.vertical(this.heigth, {super.key}) : width = 0;
  const RSizedBox.horizontal(this.width, {super.key}) : heigth = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: heigth,
      width: width,
    );
  }
}

abstract class PRadius {
  PRadius._();

  static const button = 28.0;
  static const container = 16.0;
  static const texFiled = 12.0;
  static const chip = 12.0;
  static const checkBox = 6.0;
  static const card = 8.0;
}

abstract class PEdgeInsets {
  PEdgeInsets._();

  static const all = EdgeInsets.all(LayoutConstrains.m3);
  static const horizontal =
      EdgeInsets.symmetric(horizontal: LayoutConstrains.m3);

  static const vertical =
      EdgeInsets.symmetric(vertical: LayoutConstrains.m3);
  static const dHorizontal =
      EdgeInsets.symmetric(horizontal: LayoutConstrains.l2);
}

class PPadding {
  static const mainPadding = 12.0;
}
