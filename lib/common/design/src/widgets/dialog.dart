import 'package:flutter/material.dart';

import '../../../extensions/src/context_extensions.dart';
import '../../../helper/src/locale_keys.dart';

Future<void> showAlertDialog({
  required BuildContext context,
  required String title,
  required String subTitle,
  required Future<void> Function() fun,
  required Color titleColor,
  required Color actionButColor,
  Color? actionButForegroundColor,
  String cancelText = 'Cancel',
  String yesText = 'Yes',
  Widget contentWidget = const SizedBox(),
}) async {
  showDialog(
    context: context,
    builder: (BuildContext ctx) {
      return AlertDialog(
        title: Text(
          title,
          style: TextStyle(color: titleColor, fontWeight: FontWeight.w600),
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Divider(),
            Text(
              subTitle,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
            contentWidget,
            SizedBox(height: context.height * .01),
            Container(
              width: context.width * .7,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: context.width * .3,
                    height: context.height * .05,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: BorderSide(
                          width: 1.0,
                          color: context.primarySwatch,
                        ),
                        foregroundColor: context.primarySwatch,
                      ),
                      child: Text(cancelText, style: context.headlineSmall()),
                    ),
                  ),

                  SizedBox(
                    width: context.width * .3,
                    height: context.height * .05,

                    child: ElevatedButton(
                      onPressed: fun,
                      style: ElevatedButton.styleFrom(
                        foregroundColor:
                            actionButForegroundColor ?? context.primarySwatch,
                        backgroundColor: actionButColor,
                        padding: EdgeInsets.symmetric(
                          horizontal: context.width * .06,
                        ),
                      ),
                      child: Text(
                        yesText,
                        style: context.headlineSmall(
                          color: actionButForegroundColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}

Future<void> showConfirmDialog({
  required BuildContext context,
  required String title,
  required String subTitle,
  required Future<void> Function() fun,
  required Color titleColor,
  required Color actionButColor,
  Color? actionButForegroundColor,
  String cancelText = 'Cancel',
  String? yesText,
  Widget contentWidget = const SizedBox(),
}) async {
  return showDialog(
    context: context,
    builder: (BuildContext ctx) {
      return AlertDialog(
        title: Text(
          title,
          style: ctx.bodyLarge(color: titleColor, fontSize: 18),
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Divider(),
            Text(
              subTitle,

              style: ctx.bodyMedium(color: ctx.textSubColor, fontSize: 14),
            ),
            contentWidget,
            SizedBox(height: context.height * .01),
            SizedBox(
              width: ctx.width,
              child: ElevatedButton(
                onPressed: fun,
                style: ElevatedButton.styleFrom(
                  foregroundColor:
                      actionButForegroundColor ?? context.primarySwatch,
                  backgroundColor: actionButColor,
                  // padding: EdgeInsets.symmetric(
                  //   horizontal: context.width * .06,
                  // ),
                ),
                child: Text(
                  yesText ?? LocaleKeys.authConfirm.tr(),
                  style: context.headlineSmall(
                    color: actionButForegroundColor,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
