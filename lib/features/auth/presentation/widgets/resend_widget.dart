// import 'package:evowash_user_flutter_app/common/extensions/extensions.dart';
// import 'package:flutter/material.dart';
//
// import '../../../../common/design/src/widgets/my_custom_widget/my_count_down_timer_widget.dart';
// import '../../../../common/helper/src/locale_keys.dart';
// import '../pages/foget_password/forget_password_pin_code_screen.dart';
//
// class ResendWidget extends StatelessWidget {
//   final ValueNotifier<bool> _isTimeEnd;
//   final void Function() resend;
//
//   const ResendWidget({
//     super.key,
//     required ValueNotifier<bool> isTimeEnd,
//     required this.resend,
//   }) : _isTimeEnd = isTimeEnd;
//
//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: AlignmentDirectional.centerStart,
//       child: Padding(
//         padding: EdgeInsets.only(bottom: 16),
//         child: ValueListenableBuilder(
//           valueListenable: _isTimeEnd,
//           builder: (context, value, child) {
//             return GestureDetector(
//               onTap:
//                   value == true
//                       ?resend
//                       : null,
//               child: Row(
//                 children: [
//                   Text(
//                     LocaleKeys.forgetPasswordReSendPin.tr(),
//                     style: context.bodySmall(
//                       fontWeight: FontWeight.w600,
//                       fontSize: 16,
//                       color:
//                           value == true
//                               ? context.primarySwatch
//                               : context.textFieldHintColor,
//                     ),
//                   ),
//                   SizedBox(width: 5),
//                   value == false
//                       ? MyCountDownTimerWidget(isTimeEnd: _isTimeEnd)
//                       : SizedBox(),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
