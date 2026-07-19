// import 'package:evowash_user_flutter_app/common/extensions/extensions.dart';
// import 'package:flutter/material.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
//
// class ConfirmPinCodeField extends StatelessWidget {
//   final TextEditingController controller;
//   final Color primaryColor;
//   final Color secondaryColor;
//
//   const ConfirmPinCodeField({
//     super.key,
//     required this.controller,
//     required this.primaryColor,
//     required this.secondaryColor,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return PinCodeTextField(
//       controller: controller,
//       appContext: context,
//       length: 4,
//       animationType: AnimationType.fade,
//       pinTheme: PinTheme(
//         shape: PinCodeFieldShape.box,
//         borderRadius: BorderRadius.circular(20),
//         fieldHeight: 72,
//         fieldWidth: 72,
//         selectedColor: secondaryColor,
//         inactiveColor: Colors.grey,
//         activeColor: primaryColor,
//         activeFillColor: Colors.white,
//         inactiveFillColor: Colors.white,
//         selectedFillColor: Colors.white,
//         activeBorderWidth: 2,
//         selectedBorderWidth: 4,
//       ),
//       animationDuration: const Duration(milliseconds: 500),
//       textStyle: TextStyle(color: primaryColor),
//       keyboardType: TextInputType.number,
//       cursorColor: Colors.transparent,
//       enableActiveFill: true,
//     );
//   }
// }
//
// // import 'package:flutter/material.dart';
//
// class ConfirmValidationMessage extends StatelessWidget {
//   final bool isValid;
//   final String errorMessage;
//   final TextStyle textStyle;
//
//   const ConfirmValidationMessage({
//     super.key,
//     required this.isValid,
//     required this.errorMessage,
//     required this.textStyle,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     if (isValid) return const SizedBox.shrink();
//
//     return Padding(
//       padding: const EdgeInsets.only(top: 4.0),
//       child: Text(errorMessage, style: textStyle),
//     );
//   }
// }
//
// // import 'package:flutter/material.dart';
//
// class ConfirmTimerRow extends StatelessWidget {
//   final int remainingSeconds;
//   final String prefixText;
//   final TextStyle textStyle;
//   final Color timerColor;
//
//   const ConfirmTimerRow({
//     super.key,
//     required this.remainingSeconds,
//     required this.prefixText,
//     required this.textStyle,
//     required this.timerColor,
//   });
//
//   String _formatTime(int seconds) {
//     final minutes = seconds ~/ 60;
//     final secs = seconds % 60;
//     return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 8),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(prefixText, style: textStyle),
//           const SizedBox(width: 4),
//           Text(
//             _formatTime(remainingSeconds),
//             style: textStyle.copyWith(color: timerColor),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // import 'package:flutter/material.dart';
// // import 'package:deal/common/design/src/widgets/gradiant_widgets/gradient_button.dart';
//
// // class ConfirmButton extends StatelessWidget {
// //   final bool isEnabled;
// //   final VoidCallback onPressed;
// //   final String buttonText;
// //   final TextStyle textStyle;
// //
// //   const ConfirmButton({
// //     super.key,
// //     required this.isEnabled,
// //     required this.onPressed,
// //     required this.buttonText,
// //     required this.textStyle,
// //   });
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return GradientButton(
// //       borderRadius: BorderRadius.circular(28),
// //       height: context.width * .15,
// //       width: double.infinity,
// //       isSecondaryGradient: true,
// //       onPressed: isEnabled ? onPressed : null,
// //       contentChild: Center(
// //         child: Text(
// //           buttonText,
// //           style: textStyle,
// //         ),
// //       ),
// //     );
// //   }
// // }
//
// //
// // import 'package:flutter/material.dart';
//
// // class ResendButton extends StatelessWidget {
// //   final VoidCallback onPressed;
// //   final String buttonText;
// //
// //   const ResendButton({
// //     super.key,
// //     required this.onPressed,
// //     required this.buttonText,
// //   });
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       margin: EdgeInsets.only(top: context.height * .02),
// //       width: double.infinity,
// //       height: context.width * .15,
// //       child: OutlinedButton(
// //         onPressed: onPressed,
// //         child: Text(buttonText),
// //       ),
// //     );
// //   }
// // }
