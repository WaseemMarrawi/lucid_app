import 'package:flutter/material.dart';

import 'color_palettes/app_colors.dart';

@immutable
class AppThemeExtensions extends ThemeExtension<AppThemeExtensions> {
  final AppColorPalette palette;

  const AppThemeExtensions({required this.palette});

  @override
  AppThemeExtensions copyWith({AppColorPalette? palette}) {
    return AppThemeExtensions(palette: palette ?? this.palette);
  }

  @override
  AppThemeExtensions lerp(ThemeExtension<AppThemeExtensions>? other, double t) {
    if (other is! AppThemeExtensions) return this;
    return AppThemeExtensions(palette: palette); // ثابت لأن palette ثابتة عندك
  }
}
