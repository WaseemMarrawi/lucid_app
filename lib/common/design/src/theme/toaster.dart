import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../design.dart';

class Toaster {
  Toaster._();
  static showLoading() {
    BotToast.showCustomLoading(
      toastBuilder: (_) {
        return const LoadingWidget();
      },
      backButtonBehavior: BackButtonBehavior.ignore,

    );
  }

  static closeAllLoading() {
    BotToast.closeAllLoading();
  }

  static showText({required String text}) {
    BotToast.showText(text: text);
  }
  static showNotification({ required String title}) {
    BotToast.showText(text: title);

  }
  static showCustomErrorToast({required String message}) {
    BotToast.showCustomNotification(
      duration: const Duration(seconds: 4),
      toastBuilder: (cancelFunc) {
        return Container(
          margin: const EdgeInsets.only(bottom: 34,
              right:20 ,left: 20),
          padding: const EdgeInsets.symmetric(horizontal:  18,vertical: 16),
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
      align: const Alignment(0, 0.9), // أسفل الشاشة
      animationDuration: const Duration(milliseconds: 300),
    );
  }
}
