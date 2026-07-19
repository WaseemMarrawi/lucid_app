import 'package:flutter/material.dart';

FontWeight get thin => FontWeight.w100;

FontWeight get extraLight => FontWeight.w200;

FontWeight get light => FontWeight.w300;

FontWeight get regular => FontWeight.normal;

FontWeight get medium => FontWeight.w500;

FontWeight get semiBold => FontWeight.w600;

FontWeight get bold => FontWeight.bold;

FontWeight get extraBold => FontWeight.w800;

FontWeight get black => FontWeight.w900;


abstract class FontFamily {
  static const String family = 'Sora';
}

abstract class FontSize {
  static double get displayLarge => _displayLargeFontSize;
  static const double _displayLargeFontSize = 57;

  static double get displayMedium => _displayMediumFontSize;
  static const double _displayMediumFontSize = 45;

  static double get displaySmall => _displaySmallFontSize;
  static const double _displaySmallFontSize = 36;

  static double get headlineLarge => _headlineLargeSize;
  static const double _headlineLargeSize = 32;

  static double get headlineMedium => _headlineMediumFontSize;
  static const double _headlineMediumFontSize = 28;

  static double get headlineSmall => _headlineSmallFontSize;
  static const double _headlineSmallFontSize = 24;

  static double get titleLarge => _titleLargeFontSize;
  static const double _titleLargeFontSize = 22;

  static double get titleMedium => _titleMediumFontSize;
  static const double _titleMediumFontSize = 16;

  static double get titleSmall => _titleSmallFontSize;
  static const double _titleSmallFontSize = 14;

  static double get bodyLarge => _bodyLargeSize;
  static const double _bodyLargeSize = 16;

  static double get bodyMedium => _bodyMediumFontSize;
  static const double _bodyMediumFontSize = 14;

  static double get bodySmall => _bodySmallFontSize;
  static const double _bodySmallFontSize = 12;

  static double get labelLarge => _labelLargeFontSize;
  static const double _labelLargeFontSize = 14;

  static double get labelMedium => _labelMediumFontSize;
  static const double _labelMediumFontSize = 12;

  static double get labelSmall => _labelSmallFontSize;
  static const double _labelSmallFontSize = 11;

  static double get font19Size => _font19Size;
  static const double _font19Size = 19;

  static double get font17Size => _font17Size;
  static const double _font17Size = 17;

  static double get font15Size => _font15Size;
  static const double _font15Size = 15;

  static double get font13Size => _font13Size;
  static const double _font13Size = 13;

  static double get font10Size => _font10Size;
  static const double _font10Size = 10;
}

extension FontExt on TextStyle? {
  TextStyle? get bf => this?.copyWith(fontFamily: FontFamily.family, fontWeight: black);

  TextStyle? get xb => this?.copyWith(fontFamily: FontFamily.family, fontWeight: extraBold);

  TextStyle? get b => this?.copyWith(fontFamily: FontFamily.family, fontWeight: bold);

  TextStyle? get sb => this?.copyWith(fontFamily: FontFamily.family, fontWeight: semiBold);

  TextStyle? get m => this?.copyWith(fontFamily: FontFamily.family, fontWeight: medium);

  TextStyle? get r => this?.copyWith(fontFamily: FontFamily.family, fontWeight: regular);

  TextStyle? get l => this?.copyWith(fontFamily: FontFamily.family, fontWeight: light);

  TextStyle? get xl => this?.copyWith(fontFamily: FontFamily.family, fontWeight: extraLight);

  TextStyle? get th => this?.copyWith(fontFamily: FontFamily.family, fontWeight: thin);

  TextStyle? get s19 => this?.copyWith(fontSize: FontSize.font19Size);

  TextStyle? get s17 => this?.copyWith(fontSize: FontSize.font17Size);

  TextStyle? get s15 => this?.copyWith(fontSize: FontSize.font15Size);

  TextStyle? get s13 => this?.copyWith(fontSize: FontSize.font13Size);

  TextStyle? get s10 => this?.copyWith(fontSize: FontSize.font10Size);

  TextStyle? withColor(Color? color) => this?.copyWith(color: color);
}
