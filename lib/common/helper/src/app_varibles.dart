import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/di/injection.dart';
import '../../../core/unified_api/dio/api_client.dart';
import '../../models/user_model.dart';
import '../helper.dart';

class AppVariables {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static final SharedPreferences _pref = getIt<SharedPreferences>();

  static String? get token => _pref.getString(PrefsKeys.token);

  static set token(String? token) =>
      token == null ? null : _pref.setString(PrefsKeys.token, token);

  static String? get fcmToken => _pref.getString(PrefsKeys.fcmToken);

  static set fcmToken(String? fcmToken) =>
      fcmToken == null ? null : _pref.setString(PrefsKeys.fcmToken, fcmToken);


  static UserModel? get user {
    final data = _pref.getString(PrefsKeys.userInfo);

    if (data == null || data.isEmpty) {
      return null;
    }

    return UserModel.fromJson(jsonDecode(data));
  }

  static set user(UserModel? user) {
    if (user == null) {
      _pref.remove(PrefsKeys.userInfo);
      return;
    }

    _pref.setString(
      PrefsKeys.userInfo,
      jsonEncode(user.toJson()),
    );
  }


  static void setCurrentLang(BuildContext context) {
    String val = context.locale.languageCode; // ar | en | ku
    _pref.setString(PrefsKeys.lang, val);
    getIt<ApiClient>().resetHeader();
  }

  static String getCurrentLang() {
    final lang = _pref.getString(PrefsKeys.lang);

    if (lang != null) return lang;

    final context = AppVariables.navigatorKey.currentContext;

    if (context != null) {
      return EasyLocalization.of(context)!.locale.languageCode;
    }

    return 'ar'; // fallback آمن
  }


  static String checkLanguage(BuildContext context) {
    final code = context.locale.languageCode;

    switch (code) {
      case 'ar':
        return 'ar';
      case 'ku':
        return 'ku';
      case 'en':
      default:
        return 'en';
    }
  }


  // getter لقراءة الثيم المحفوظ
  static String get savedTheme =>
      _pref.getString(PrefsKeys.appTheme) ?? 'light';

  // setter لحفظ الثيم
  static set savedTheme(String theme) =>
      _pref.setString(PrefsKeys.appTheme, theme);


}


// static List<Chat?> get chats {
//   final val = _pref.getString(PrefsKeys.chats);
//
//   if (val != null) {
//     List value = json.decode(val);
//
//     final list = List<Chat>.from(value.map((e) => Chat.fromJson(e))).toList();
//
//     return list;
//   } else {
//     return [];
//   }
//
//
//
// }
//
// static set chats(List<Chat?> chats) =>
//     chats == [] ? null :
//     _pref.setString(
//         PrefsKeys.chats, jsonEncode(chats.map((e) => e!.toJson()).toList()));
