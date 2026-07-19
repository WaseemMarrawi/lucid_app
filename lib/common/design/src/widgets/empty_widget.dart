import 'package:flutter/material.dart';

import '../../../extensions/src/context_extensions.dart';
import '../../../helper/src/locale_keys.dart';
import '../../design.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            LocaleKeys.errorMassegeNocontent.tr(),
            style: context.titleLarge(
              color: context.primarySwatch,
            ),
          ),
          Space.vM1,
        ],
      ),
    );
  }
}
