
import 'package:flutter/material.dart';

import '../../../../common/design/src/theme/const.dart';
import '../../../../common/design/src/widgets/app_drop_down.dart';
import '../../../../common/design/src/widgets/app_text_field.dart';
import '../../../../common/extensions/src/context_extensions.dart';
import '../../../../common/helper/src/locale_keys.dart';

class PhoneTableWidget extends StatelessWidget {
  final TextEditingController phoneController;
  final TextEditingController tableController;

  const PhoneTableWidget({super.key, required this.phoneController, required this.tableController});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.phoneNumber.tr(),
                style: context.bodyLarge(fontSize: 14),
              ),
              Space.vS3,

              MyAppTextField(isPadding: false,controller: phoneController,),
            ],
          ),
        ),
        Space.hM1,
        Expanded(
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,

            children: [
              Text(
                LocaleKeys.tableNumber.tr(),
                style: context.bodyLarge(
                  fontSize: 14,
                ),
              ),
              // Row(
              //   children: [
              //     Text(
              //       LocaleKeys.tableNumber.tr(),
              //       style: context.bodyLarge(
              //         fontSize: 14,
              //       ),
              //     ),
              //     Space.hS2,
              //     Text(
              //       LocaleKeys.required.tr(),
              //       style: context.bodyMedium(
              //         fontSize: 12,
              //         color: context.errorColor,
              //       ),
              //     ),
              //   ],
              // ),
              Space.vS3,
              MyAppTextField(
                isPadding: false,
                controller: tableController,


              ),
            ],
          ),
        ),
      ],
    );
  }
}
