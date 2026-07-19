import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../design/design.dart';
import '../../design/src/theme/theme/theme_extensions.dart';
import '../../design/src/theme/theme/theme_notifier.dart';

extension NavigationContextExtensions on BuildContext {
  void pop<T extends Object?>([T? result]) => Navigator.of(this).pop<T>(result);

  Future<T?> pushNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) => Navigator.of(this).pushNamed<T>(routeName, arguments: arguments);

  Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    TO? result,
    Object? arguments,
  }) => Navigator.of(
    this,
  ).pushReplacementNamed(routeName, result: result, arguments: arguments);

  void popUntilFirst() =>
      Navigator.of(this).popUntil(
            (route) => route.isFirst,
      );
  void popUntilPage({required String routeName}) =>
      Navigator.of(this).popUntil(
            (route) => route.settings.name == routeName,
      );


  Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
    String newRouteName,
    bool Function(Route<dynamic>) predicate, {
    Object? arguments,
  }) => Navigator.of(
    this,
  ).pushNamedAndRemoveUntil(newRouteName, predicate, arguments: arguments);

  Future<T?> popAndPushNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    TO? result,
    Object? arguments,
  }) => Navigator.of(
    this,
  ).popAndPushNamed(routeName, result: result, arguments: arguments);


}

// امتدادات الوسائط والشاشة
extension MediaContextExtensions on BuildContext {
  Size size() => MediaQuery.of(this).size;

  double get width => MediaQuery.of(this).size.width;

  double get height => MediaQuery.of(this).size.height;

  double get pixelRatio => MediaQuery.of(this).devicePixelRatio;

  Brightness get platformBrightness => MediaQuery.of(this).platformBrightness;

  double get statusBarHeight => MediaQuery.of(this).padding.top;

  double get navigationBarHeight => MediaQuery.of(this).padding.bottom;

  Orientation get orientation => MediaQuery.of(this).orientation;

  bool get isLandscape => orientation == Orientation.landscape;

  bool get isPortrait => orientation == Orientation.portrait;
}

// امتدادات الثيم
extension ThemeContextExtensions on BuildContext {
  AppThemeExtensions get themeExt =>
      Theme.of(this).extension<AppThemeExtensions>()!;

  // اختصارات الألوان الرئيسية
  Color get notificationOrderCompleted => themeExt.palette.notificationOrderCompleted;
  Color get notificationAttention => themeExt.palette.notificationAttention;
  Color get notificationAdd => themeExt.palette.notificationAdd;
  Color get notificationDelete => themeExt.palette.notificationDelete;
  Color get notificationSchuled => themeExt.palette.notificationSchuled;
  Color get notificationRequest => themeExt.palette.notificationRequest;
  Color get primarySwatch => themeExt.palette.primarySwatch;
  Color get borderGradientStartColor => themeExt.palette.borderGradientStartColor;
  Color get borderGradientEndColor => themeExt.palette.borderGradientEndColor;
  Color get carProfileColor => themeExt.palette.carProfileColor;

  Color get primarySwatchOpacity => themeExt.palette.primarySwatch;

  Color get secondaryColor => themeExt.palette.secondarySwatch;

  Color get onPrimaryColor => themeExt.palette.onPrimary;

  Color get primaryContainerColor => themeExt.palette.primaryContainer;

  Color get onPrimaryContainerColor => themeExt.palette.onPrimaryContainer;

  Color get onSecondaryColor => themeExt.palette.onSecondary;

  Color get secondaryContainerColor => themeExt.palette.secondaryContainer;

  Color get onSecondaryContainerColor => themeExt.palette.onSecondaryContainer;

  Color get tertiaryColor => themeExt.palette.tertiary;

  Color get onTertiaryColor => themeExt.palette.onTertiary;

  Color get tertiaryContainerColor => themeExt.palette.tertiaryContainer;

  Color get onTertiaryContainerColor => themeExt.palette.onTertiaryContainer;

  Color get errorColor => themeExt.palette.error;

  Color get onErrorColor => themeExt.palette.onError;

  Color get errorContainerColor => themeExt.palette.errorContainer;

  Color get onErrorContainerColor => themeExt.palette.onErrorContainer;

  Color get backgroundColor => themeExt.palette.background;

  Color get onBackgroundColor => themeExt.palette.onBackground;

  Color get surfaceColor => themeExt.palette.surface;

  Color get onSurfaceColor => themeExt.palette.onSurface;

  Color get surfaceVariantColor => themeExt.palette.surfaceVariant;

  Color get onSurfaceVariantColor => themeExt.palette.onSurfaceVariant;

  Color get outlineColor => themeExt.palette.outline;

  Color get shadowColor => themeExt.palette.shadow;

  Color get inverseSurfaceColor => themeExt.palette.inverseSurface;

  Color get onInverseSurfaceColor => themeExt.palette.onInverseSurface;

  Color get inversePrimaryColor => themeExt.palette.inversePrimary;

  Color get cardColor => themeExt.palette.card;

  Color get cardHighlightedColor => themeExt.palette.cardHighlighted;

  Color get disabledColor => themeExt.palette.disabled;

  Color get dividerColor => themeExt.palette.divider;
  Color get navBarColor => themeExt.palette.navBarColor;
  Color get navBarSelectedColor => themeExt.palette.navBarSelectedColor;

  Color get textFieldBorderColor => themeExt.palette.textFieldBorder;

  Color get textFieldBackgroundColor => themeExt.palette.textFieldBackground;

  Color get textFieldHintColor => themeExt.palette.textFieldHintColor;

  Color get textColor => themeExt.palette.textColor;

  Color get blackColor => themeExt.palette.black;

  Color get grey => themeExt.palette.grey;

  Color get successColor => themeExt.palette.success;
  Color get successBackGround => themeExt.palette.successBackGround;
  Color get pickedUp => themeExt.palette.pickedUp;
  Color get inTransit => themeExt.palette.inTransitColor;

  Color get warningColor => themeExt.palette.warning;

  Color get infoColor => themeExt.palette.info;

  Color get textFieldBorder => themeExt.palette.textFieldBorder;


  Color get langColor => themeExt.palette.langColor;

  Color get numberColor => themeExt.palette.numberColor;

  Color get shareColor => themeExt.palette.shareColor;

  Color get versionColor => themeExt.palette.versionColor;

  Color get starsRateColor => themeExt.palette.starsRateColor;
  Color get anotherTextColor => themeExt.palette.anotherTextColor;
  Color get textSubColor => themeExt.palette.textSubColor;
  Color get hintColor => themeExt.palette.hintColor;
  Color get appBarColor => themeExt.palette.appBarColor;
  Color get iconBackGround => themeExt.palette.iconBackGround;
  Color get onWay => themeExt.palette.onWay;
  Color get onWayBackground => themeExt.palette.onWayBackground;



  void setTheme(AppThemeType theme) => read<AppThemeNotifier>().setTheme(theme);

  bool get isDarkMode => theme.brightness == Brightness.dark;
}


// امتدادات الواجهة
extension ScaffoldContextExtensions on BuildContext {
  ScaffoldState get scaffoldState => Scaffold.of(this);

  void openDrawer() => Scaffold.of(this).openDrawer();

  void openEndDrawer() => Scaffold.of(this).openEndDrawer();
}

// امتدادات أخرى
extension OtherContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => Theme.of(this).textTheme;

  bool get isArabic => Localizations.localeOf(this).languageCode == 'ar';
  bool get isEnglish=> Localizations.localeOf(this).languageCode == 'en';
  bool get isKurdish=> Localizations.localeOf(this).languageCode == 'ku';


  DefaultTextStyle get defaultTextStyle => DefaultTextStyle.of(this);

  FormState? get formState => Form.of(this);

  OverlayState? get overlayState => Overlay.of(this);

  Color get accentColor => theme.colorScheme.secondary;

  Color get scaffoldBackgroundColor => theme.scaffoldBackgroundColor;

  TargetPlatform get platform => Theme.of(this).platform;

  bool get isAndroid => platform == TargetPlatform.android;

  bool get isIOS => platform == TargetPlatform.iOS;

  bool get isMobile => ResponsiveBreakpoints.of(this).isMobile;

  bool get isDesktop => ResponsiveBreakpoints.of(this).isDesktop;

  bool get isTablet => (ResponsiveBreakpoints.of(this).isTablet);

  void requestFocus(FocusNode focus) {
    FocusScope.of(this).requestFocus(focus);
  }

  void unFocus(FocusNode focus) {
    focus.unfocus();
  }
}



class AppFontFamily {
  final TextStyle Function({TextStyle? textStyle}) font;

  const AppFontFamily(this.font);

  /// الخط الافتراضي
  static const cairo = AppFontFamily(GoogleFonts.cairo);

  /// خطوط إضافية
  static const alexandria = AppFontFamily(GoogleFonts.alexandria);
  static const tajawal = AppFontFamily(GoogleFonts.tajawal);
  static const inter = AppFontFamily(GoogleFonts.inter);
  static const poppins = AppFontFamily(GoogleFonts.poppins);
  static const roboto = AppFontFamily(GoogleFonts.roboto);
  static const montserrat = AppFontFamily(GoogleFonts.montserrat);
  static const openSans = AppFontFamily(GoogleFonts.openSans);
  static const lato = AppFontFamily(GoogleFonts.lato);
  static const nunito = AppFontFamily(GoogleFonts.nunito);
  static const raleway = AppFontFamily(GoogleFonts.raleway);
  static const ubuntu = AppFontFamily(GoogleFonts.ubuntu);
  static const oswald = AppFontFamily(GoogleFonts.oswald);
  static const playfairDisplay = AppFontFamily(GoogleFonts.playfairDisplay);
  static const merriweather = AppFontFamily(GoogleFonts.merriweather);
  static const rubik = AppFontFamily(GoogleFonts.rubik);
  static const dmSans = AppFontFamily(GoogleFonts.dmSans);
  static const outfit = AppFontFamily(GoogleFonts.outfit);
  static const quicksand = AppFontFamily(GoogleFonts.quicksand);
  static const workSans = AppFontFamily(GoogleFonts.workSans);
  static const manrope = AppFontFamily(GoogleFonts.manrope);
  static const comfortaa = AppFontFamily(GoogleFonts.comfortaa);
}

extension TextStyleExtensions on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;

  TextStyle? displayLarge({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    AppFontFamily? fontFamily,
  }) =>
      _applyStyle(
        textTheme.displayLarge,
        color,
        fontSize,
        fontWeight,
        fontFamily,
      );

  TextStyle? displayMedium({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    AppFontFamily? fontFamily,
  }) =>
      _applyStyle(
        textTheme.displayMedium,
        color,
        fontSize,
        fontWeight,
        fontFamily,
      );

  TextStyle? displaySmall({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    AppFontFamily? fontFamily,
  }) =>
      _applyStyle(
        textTheme.displaySmall,
        color,
        fontSize,
        fontWeight,
        fontFamily,
      );

  TextStyle? headlineLarge({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    AppFontFamily? fontFamily,
  }) =>
      _applyStyle(
        textTheme.headlineLarge,
        color,
        fontSize,
        fontWeight,
        fontFamily,
      );

  TextStyle? headlineMedium({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    AppFontFamily? fontFamily,
  }) =>
      _applyStyle(
        textTheme.headlineMedium,
        color,
        fontSize,
        fontWeight,
        fontFamily,
      );

  TextStyle? headlineSmall({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    AppFontFamily? fontFamily,
  }) =>
      _applyStyle(
        textTheme.headlineSmall,
        color,
        fontSize,
        fontWeight,
        fontFamily,
      );

  TextStyle? titleLarge({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    AppFontFamily? fontFamily,
  }) =>
      _applyStyle(
        textTheme.titleLarge,
        color,
        fontSize,
        fontWeight,
        fontFamily,
      );

  TextStyle? titleMedium({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    AppFontFamily? fontFamily,
  }) =>
      _applyStyle(
        textTheme.titleMedium,
        color,
        fontSize,
        fontWeight,
        fontFamily,
      );

  TextStyle? titleSmall({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    AppFontFamily? fontFamily,
  }) =>
      _applyStyle(
        textTheme.titleSmall,
        color,
        fontSize,
        fontWeight,
        fontFamily,
      );

  TextStyle? labelLarge({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    AppFontFamily? fontFamily,
  }) =>
      _applyStyle(
        textTheme.labelLarge,
        color,
        fontSize,
        fontWeight,
        fontFamily,
      );

  TextStyle? labelMedium({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    AppFontFamily? fontFamily,
  }) =>
      _applyStyle(
        textTheme.labelMedium,
        color,
        fontSize,
        fontWeight,
        fontFamily,
      );

  TextStyle? labelSmall({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    AppFontFamily? fontFamily,
  }) =>
      _applyStyle(
        textTheme.labelSmall,
        color,
        fontSize,
        fontWeight,
        fontFamily,
      );

  TextStyle? bodyLarge({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    AppFontFamily? fontFamily,
  }) =>
      _applyStyle(
        textTheme.bodyLarge,
        color,
        fontSize,
        fontWeight,
        fontFamily,
      );

  TextStyle? bodyMedium({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    AppFontFamily? fontFamily,
  }) =>
      _applyStyle(
        textTheme.bodyMedium,
        color,
        fontSize,
        fontWeight,
        fontFamily,
      );

  TextStyle? bodySmall({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    AppFontFamily? fontFamily,
  }) =>
      _applyStyle(
        textTheme.bodySmall,
        color,
        fontSize,
        fontWeight,
        fontFamily,
      );

  TextStyle? _applyStyle(
      TextStyle? base,
      Color? color,
      double? size,
      FontWeight? weight,
      AppFontFamily? fontFamily,
      ) {
    final selectedFont = fontFamily ?? AppFontFamily.cairo;

    return selectedFont.font(
      textStyle: base,
    ).copyWith(
      color: color ?? base?.color,
      fontSize: size ?? base?.fontSize,
      fontWeight: weight ?? base?.fontWeight,
    );
  }
}


extension HexColor on String {
  Color toColor() {
    final hex = replaceAll('#', '');
    return Color(
      int.parse(
        hex.length == 6 ? 'FF$hex' : hex,
        radix: 16,
      ),
    );
  }
}

extension ColorToHex on Color {
  String toHex() {
    return '#${value.toRadixString(16).substring(2).toUpperCase()}';
  }
}