import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../design/design.dart';
import '../../helper/src/locale_keys.dart';
import '../../models/accessories_model.dart';



extension Validator on String? {
  String? get isValidEmail {
    const String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    final RegExp regExp = RegExp(pattern);
    if (this == null || this!.isEmpty) {
      return LocaleKeys.validationRequiredfield.tr();
    } else if (!regExp.hasMatch(this!)) {
      return LocaleKeys.validationInvalidemailaddress.tr();
    }
    return null;
  }

  bool _isPasswordStrong(String password) {
    bool hasUpperCase = password.contains(RegExp(r'[A-Z]'));
    bool hasLowerCase = password.contains(RegExp(r'[a-z]'));
    bool hasDigits = password.contains(RegExp(r'\d'));
    bool hasSpecialCharacters = password.contains(
      RegExp(r'[!@#$%^&*(),.?":{}|<>]'),
    );
    bool hasMinimumLength = password.length >= 8;

    return hasUpperCase &&
        hasLowerCase &&
        hasDigits &&
        hasSpecialCharacters &&
        hasMinimumLength;
  }

  bool _isPasswordStrong2(String password) {
    bool hasDigits = password.contains(RegExp(r'\d'));
    bool hasMinimumLength = password.length >= 8;

    return hasDigits && hasMinimumLength;
  }

  String? get validatePassword {
    if (this == null || this!.isEmpty) {
      return LocaleKeys.validationPasswordtooshort.tr();
    }
    if (this!.length <= 7) {
      return LocaleKeys.validationPasswordtooshort.tr();
    }
    // else
    //   if (!_isPasswordStrong2(this!)) {
    //   return LocaleKeys.validationPasswordnotstrong.tr();
    // }
    return null;
  }

  String? get isRatingText {
    return (this == null || this!.isEmpty)
        ? null
        : (this!.length < 2)
        ? LocaleKeys.validationFieldNameTooShort.tr()
        : (this!.length > 40)
        ? LocaleKeys.validationFieldNameTooLong.tr()
        : null;
  }

  String? get isNotShortText {
    return (this == null || this!.isEmpty)
        ? LocaleKeys.validationRequiredfield.tr()
        : (this!.length < 2)
        ? LocaleKeys.validationFieldtooshort.tr()
        : null;
  }

  String? get isNotEnderThreeText {
    return (this == null || this!.isEmpty)
        ? LocaleKeys.validationRequiredfield.tr()
        : (this!.length < 3)
        ? LocaleKeys.validationFieldtooshort.tr()
        : null;
  }

  String? get isNotEnderFourText {
    return (this == null || this!.isEmpty)
        ? LocaleKeys.validationRequiredfield.tr()
        : (this!.length < 3)
        ? LocaleKeys.validationFieldNameTooLongFour.tr()
        : null;
  }

  String? get isPlate {
    return (this == null || this!.isEmpty)
        ? LocaleKeys.validationRequiredfield.tr()
        : (this!.length < 4)
        ? LocaleKeys.validationFieldtooshort.tr()
        : (this!.length > 17)
        ? LocaleKeys.validationPlateTooLong.tr()
        : null;
  }

  String? get isNameText {
    return (this == null || this!.isEmpty)
        ? LocaleKeys.validationRequiredfield.tr()
        : (this!.length < 2)
        ? LocaleKeys.validationFieldNameTooShort.tr()
        : (this!.length > 15)
        ? LocaleKeys.validationFieldNameTooLong.tr()
        : null;
  }

  String? get isNameOptionText {
    return (this == null || this!.isEmpty)
        ? null
        : (this!.length < 2)
        ? LocaleKeys.validationFieldNameTooShort.tr()
        : (this!.length > 15)
        ? LocaleKeys.validationFieldNameTooLong.tr()
        : null;
  }

  String? get isNotShortTextPhone {
    return (this == null || this!.isEmpty)
        ? LocaleKeys.validationRequiredfield.tr()
        : (this!.length < 8)
        ? LocaleKeys.validationFieldtooshort.tr()
        : null;
  }

  String? get isPhoneNumber {
    if (this == null || this!.trim().isEmpty) {
      return LocaleKeys.validationRequiredfield.tr();
    }
    if (this!.length < 8) {
      return LocaleKeys.validationFieldtooshort.tr();
    }
    return null;
  }

  String? isName(String controllerVal) {
    return (controllerVal.length < 8) ? '' : null;
  }



  String? isValidPin(bool valid) {
    return (this!.length == 6 && valid == true)
        ? null
        : LocaleKeys.validationRequiredfield.tr();
  }

  String? get isNotEmpty {
    return (this == null || this!.isEmpty)
        ? LocaleKeys.validationRequiredfield.tr()
        : (this!.length < 1)
        ? LocaleKeys.validationFieldtooshort.tr()
        : null;
  }

  String? isConfirmPassword(String password) {
    return (this == null || this!.isEmpty)
        ? LocaleKeys.validationRequiredfield.tr()
        : (this != password)
        ? LocaleKeys.validationPasswordsdonotmatch.tr()
        : null;
  }


  //
  // String? isNotEmptyDropDown(ValueNotifier<bool> val) {
  //   if (this == null || this!.isEmpty) {
  //     val.value = true;
  //     showCustomErrorToast(LocaleKeys.accessoriesDetailsPleaseGiveCount.tr());
  //     return '';
  //   } else {
  //     val.value = false;
  //     return null;
  //   }
  // }

  void showCustomErrorToast(String message) {
    BotToast.showCustomNotification(
      duration: const Duration(seconds: 4),
      toastBuilder: (cancelFunc) {
        return Container(
          margin: const EdgeInsets.only(bottom: 34, right: 20, left: 20),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          decoration: BoxDecoration(
            color: const Color(0xFFFB2C36),

            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              SvgAsset(Assets.images.svg.signUp.errorIcon),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  message,
                  style: GoogleFonts.cairo(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  // textDirection: TextDirection.rtl,
                ),
              ),
              // IconButton(
              //   icon: const Icon(Icons.close, color: Colors.red, size: 20),
              //   onPressed: cancelFunc,
              // )
            ],
          ),
        );
      },
      onlyOne: true,
      align: const Alignment(0, 0.9),
      // أسفل الشاشة
      animationDuration: const Duration(milliseconds: 300),
    );
  }
  // bool get isValidPhone {
  //   return RegExp(
  //     r'^((\+|00)963|0)9\d{8}$',
  //     caseSensitive: false,
  //     multiLine: false,
  //   ).hasMatch(this);
  // }

  // bool get isValidPassword {
  //   return RegExp(
  //     r'[a-z0-9]{8,}',
  //     caseSensitive: false,
  //     multiLine: false,
  //   ).hasMatch(this);
  // }

  // bool get isValidWebsite {
  //   return RegExp(
  //     r"^(((https:\/\/)|(http:\/\/)){1})?(w{3}\.)?([a-z0-9])(.[a-z0-9]{1,})",
  //     caseSensitive: false,
  //     multiLine: false,
  //   ).hasMatch(this);
  // }

  // bool get isValidFacebook {
  //   return RegExp(
  //     r"^((https:\/\/){1})?(w{3}\.)?(facebook)(.com)\/[0-9a-zA-Z]+\/?",
  //     caseSensitive: false,
  //     multiLine: false,
  //   ).hasMatch(this);
  // }

  // bool get isValidInstagram {
  //   return RegExp(
  //     r"^((https:\/\/){1})?(w{3}\.)?(instagram)(.com)\/[0-9a-zA-Z]+\/?",
  //     caseSensitive: false,
  //     multiLine: false,
  //   ).hasMatch(this);
  // }

  // bool get isValidLinkedin {
  //   return RegExp(
  //     r"^((https:\/\/){1})?(w{3}\.)?(linkedin)(.com)\/[0-9a-zA-Z]+\/?",
  //     caseSensitive: false,
  //     multiLine: false,
  //   ).hasMatch(this);
  // }

  // bool get isValidTiktok {
  //   return RegExp(
  //     r"^((https:\/\/){1})?(w{3}\.)?(tiktok)(.com)\/[0-9a-zA-Z]+\/?",
  //     caseSensitive: false,
  //     multiLine: false,
  //   ).hasMatch(this);
  // }

  // bool get isValidYoutube {
  //   return RegExp(
  //     r"^((https:\/\/){1})?(w{3}\.)?(youtube)(.com)\/[0-9a-zA-Z]+\/?",
  //     caseSensitive: false,
  //     multiLine: false,
  //   ).hasMatch(this);
  // }
}

