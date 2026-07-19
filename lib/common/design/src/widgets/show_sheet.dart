import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> showCustomBottomSheet(
    {required BuildContext context,
     required Widget child
    }) async {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return child;
      },
  useRootNavigator: true
  );
}
