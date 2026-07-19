import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/di/injection.dart';
import '../../../core/unified_api/dio/api_client.dart';
import '../../extensions/extensions.dart';
import '../helper.dart';

class HelperFunc {
  static final SharedPreferences _pref = getIt<SharedPreferences>();
  static bool isAuth() => _pref.containsKey(PrefsKeys.userInfo);

  static void logout() {
    _pref.remove(PrefsKeys.userInfo);
    _pref.remove(PrefsKeys.token);
    _pref.remove(PrefsKeys.currentCountry);
    _pref.remove(PrefsKeys.appTheme);
    getIt<ApiClient>().resetHeader();
  }

  static void changeLang() {
    getIt<ApiClient>().resetHeader();

  }

  static bool isPhone(BuildContext context) {
    return MediaQuery.of(context).size.shortestSide < 550 ? true : false;
  }

  static T responsiveCondition<T>(BuildContext context,
      {required T mobile, required T desktop, T? tablet})
  {
    if (context.isMobile) {
      return mobile;
    } else if (MediaQuery.sizeOf(context).width <= 1280) {
      return tablet ?? desktop;
    } else {
      return desktop;
    }
  }

  static bool get isPlatformDesktop =>
      Platform.isLinux || Platform.isMacOS || Platform.isWindows;
}

extension MediaQuerySize on BuildContext {
  Size get sz => MediaQuery.of(this).size;
}
