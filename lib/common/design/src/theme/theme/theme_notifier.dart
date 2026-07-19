import 'package:flutter/material.dart';
import '../../../../helper/src/app_varibles.dart';
import 'package:injectable/injectable.dart';

import 'theme_collection.dart';
enum AppThemeType { light}

@lazySingleton
class AppThemeNotifier with ChangeNotifier {
  AppThemeNotifier() {
    _loadThemeFromPrefsOrUser();
  }

  AppThemeType _currentTheme = AppThemeType.light;

  AppThemeType get currentTheme => _currentTheme;

  ThemeData get themeData {
    switch (_currentTheme) {
      // case AppThemeType.female:
      //   return ThemeCollection.femaleTheme;
      // case AppThemeType.male:
      default:
        return ThemeCollection.lightTheme;
    }
  }

  void setTheme(AppThemeType type) {

    _currentTheme = type;
    _saveThemeToPrefs(type);
    notifyListeners();
  }

  void _loadThemeFromPrefsOrUser() {


  }

  void _saveThemeToPrefs(AppThemeType type) {
    AppVariables.savedTheme = type.name;
  }
  void refreshTheme() => notifyListeners();
}

