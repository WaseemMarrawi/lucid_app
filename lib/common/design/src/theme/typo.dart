import 'package:flutter/material.dart';

import 'theme/theme_extensions.dart';

final TextTheme _baseTextTheme = const TextTheme(
  headlineLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
  headlineMedium: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
  headlineSmall: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
  ////////////////////////
  ////////////////////////
  bodyLarge: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
  bodyMedium: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
  bodySmall: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
  ////////////////////////
  ////////////////////////
  labelLarge: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w300),
  labelMedium: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w200),
  labelSmall: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w100),

  ////////////////////////
  ////////////////////////

  ////////////////////////
  ////////////////////////

  ////////////////////////

  ////////////////////////
  displayLarge: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
  displayMedium: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
  displaySmall: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w300),
  /////////////////////////////////
  titleLarge: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600),
  titleMedium: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500),
  titleSmall: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w300),
);



TextTheme getTextTheme(AppThemeExtensions themeExt) {
  return _baseTextTheme.copyWith(
    displayLarge: _baseTextTheme.displayLarge?.copyWith(
      color: themeExt.palette.textColor,
    ),
    displayMedium: _baseTextTheme.displayMedium?.copyWith(
      color: themeExt.palette.textColor,
    ),
    displaySmall: _baseTextTheme.displaySmall?.copyWith(
      color: themeExt.palette.textColor,
    ),
    headlineLarge: _baseTextTheme.headlineLarge?.copyWith(
      color: themeExt.palette.textColor,
    ),
    headlineMedium: _baseTextTheme.headlineMedium?.copyWith(
      color: themeExt.palette.textColor,
    ),
    headlineSmall: _baseTextTheme.headlineSmall?.copyWith(
      color: themeExt.palette.textColor,
    ),
    labelLarge: _baseTextTheme.labelLarge?.copyWith(
      color: themeExt.palette.textColor,
    ),
    labelMedium: _baseTextTheme.labelMedium?.copyWith(
      color: themeExt.palette.textColor,
    ),
    labelSmall: _baseTextTheme.labelSmall?.copyWith(
      color: themeExt.palette.textColor,
    ),

    titleLarge: _baseTextTheme.titleLarge?.copyWith(
      color: themeExt.palette.textColor,
    ),
    titleMedium: _baseTextTheme.titleMedium?.copyWith(
      color: themeExt.palette.textColor,
    ),
    titleSmall: _baseTextTheme.titleSmall?.copyWith(
      color: themeExt.palette.textColor,
    ),
    bodyLarge: _baseTextTheme.bodyLarge?.copyWith(
      color: themeExt.palette.textColor,
    ),
    bodyMedium: _baseTextTheme.bodyMedium?.copyWith(
      color: themeExt.palette.textColor,
    ),
    bodySmall: _baseTextTheme.bodySmall?.copyWith(
      color: themeExt.palette.textColor,
    ),
  );
}
