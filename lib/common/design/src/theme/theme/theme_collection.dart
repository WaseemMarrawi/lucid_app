import 'package:flutter/material.dart';
import '../typo.dart';
import 'color_palettes/app_colors.dart';
import 'color_palettes/light_palette.dart';
import 'theme_extensions.dart';

class ThemeCollection {
  static ThemeData get lightTheme => _buildTheme(LightPalette());

  static ThemeData _buildTheme(AppColorPalette palette) {
    final themeExt = AppThemeExtensions(palette: palette);
    return ThemeData(
      scaffoldBackgroundColor: palette.scaffoldBackground,
      useMaterial3: true,
      brightness: palette.brightness,
      textTheme: getTextTheme(themeExt),
      colorScheme: ColorScheme(
        brightness: palette.brightness,
        primary: palette.primary,
        onPrimary: palette.onPrimary,
        primaryContainer: palette.primaryContainer,
        onPrimaryContainer: palette.onPrimaryContainer,
        secondary: palette.secondary,
        onSecondary: palette.onSecondary,
        secondaryContainer: palette.secondaryContainer,
        onSecondaryContainer: palette.onSecondaryContainer,
        tertiary: palette.tertiary,
        onTertiary: palette.onTertiary,
        tertiaryContainer: palette.tertiaryContainer,
        onTertiaryContainer: palette.onTertiaryContainer,
        error: palette.error,
        onError: palette.onError,
        errorContainer: palette.errorContainer,
        onErrorContainer: palette.onErrorContainer,
        background: palette.background,
        onBackground: palette.onBackground,
        surface: palette.surface,
        onSurface: palette.onSurface,
        surfaceVariant: palette.surfaceVariant,
        onSurfaceVariant: palette.onSurfaceVariant,
        outline: palette.outline,
        shadow: palette.shadow,
        inverseSurface: palette.inverseSurface,
        onInverseSurface: palette.onInverseSurface,
        inversePrimary: palette.inversePrimary,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: palette.primary,
        elevation: 0,
        centerTitle: true,
        foregroundColor: palette.onPrimary,
        titleTextStyle: TextStyle(
          color: palette.onPrimary,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        iconTheme: IconThemeData(color: palette.onPrimary),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return palette.primarySwatch; // الخلفية عند التحديد
          }
          return Colors.white; // الخلفية عند عدم التحديد
        }),
        checkColor: WidgetStateProperty.all(
          palette.card,
        ), // لون الصح
        side: WidgetStateBorderSide.resolveWith((states) {
          return BorderSide(
            color:states.contains(WidgetState.selected)?palette.primarySwatch: palette.textColor,
            width: 1,
          );

        }), // لون وحدود الإطار
        shape:RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6), // مربع بحواف ناعمة
        ),

      ),



      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.selected)) {
            return palette.primary;
          }
          return palette.titleColor; // لون خفيف عند عدم التحديد
        }),
        overlayColor: MaterialStateProperty.all(palette.primary.withOpacity(0.1)),
        splashRadius: 24,
        visualDensity: VisualDensity.standard,
      ),

      unselectedWidgetColor: palette.textColor,

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          backgroundColor: palette.primary,
          foregroundColor: palette.onPrimary,
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          backgroundColor: Colors.white,
          foregroundColor: palette.primary,
          side: BorderSide(color: palette.primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          textStyle: TextStyle(
            color: palette.primary,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: palette.primary,
        foregroundColor: palette.onPrimary,
        elevation: 2,
        shape: const StadiumBorder(),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: palette.surfaceVariant,
        selectedColor: palette.primary.withOpacity(0.2),
        disabledColor: palette.disabled,
        checkmarkColor: palette.primary,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: palette.primary.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(12),
        ),
        labelStyle: TextStyle(color: palette.textColor),
        secondaryLabelStyle: TextStyle(color: palette.onSurfaceVariant),
        brightness: palette.brightness,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      ),
      dividerTheme: DividerThemeData(color: palette.divider),
      inputDecorationTheme: InputDecorationTheme(
        isDense: true,
        hintStyle: TextStyle(color: palette.textFieldHintColor),
        labelStyle: TextStyle(
          color: palette.textColor,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        errorStyle: TextStyle(
          color: palette.error,
          fontSize: 12
        ),
        floatingLabelStyle: TextStyle(
          color: palette.primarySwatch,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: palette.textFieldBorder),
        ),
        //لون وقت التحديد
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: palette.primary),
        ),
        //غير مفعل
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: palette.textFieldBorder),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 12),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: palette.textFieldBorder),
        ),
      ),
      // cardTheme: CardTheme(
      //   color: palette.card,
      //   shadowColor: palette.shadow,
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(12),
      //   ),
      //   elevation: 1.5,
      //   margin: const EdgeInsets.all(8),
      // ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: palette.surfaceVariant,
        contentTextStyle: TextStyle(color: palette.onSurfaceVariant),
        behavior: SnackBarBehavior.floating,
      ),
      extensions: [themeExt],
    );
  }
}

//Text('عنوان كبير', style: context.displayLarge(fontWeight: FontWeight.w800));
//
// Container(
//   color: context.secondaryColor,
//   child: Text('لون الخلفية من الثيم'),
// );
//
// ElevatedButton(
//   onPressed: context.toggleTheme,
//   child: Text('تبديل الثيم'),
// );
//
// TextFormField(
//   decoration: context.inputDecorationTheme.copyWith(hintText: "ابحث..."),
// );
