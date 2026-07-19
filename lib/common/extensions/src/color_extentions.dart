
import 'package:flutter/material.dart';

extension ColorManipulation on Color {
  /// تشتق لوناً جديداً بناءً على فرق النسبة بين
  /// اللون الأساسي #D35400 واللون الهدف #F39C12
  Color get derivedColor {
    // الفروقات المحسوبة (Delta)
    const double dHue = 13.5;
    const double dSaturation = 0.13;
    const double dLightness = 0.14;

    HSLColor hsl = HSLColor.fromColor(this);

    return HSLColor.fromAHSL(
      hsl.alpha,
      (hsl.hue + dHue) % 360,
      (hsl.saturation + dSaturation).clamp(0.0, 1.0),
      (hsl.lightness + dLightness).clamp(0.0, 1.0),
    ).toColor();
  }
}