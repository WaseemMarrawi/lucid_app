// import 'package:flutter/material.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
//
// import '../../../../common/extensions/src/context_extensions.dart';
//
// class PinWidget extends StatelessWidget {
//   final PinInputController _pinController;
//
//   const PinWidget({
//     super.key,
//     required PinInputController pinController,
//   }) : _pinController = pinController;
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       child: Directionality(
//         textDirection: TextDirection.ltr,
//         child: MaterialPinField(
//           pinController: _pinController,
//           length: 6,
//           mainAxisSize: MainAxisSize.max,
//
//           /// ✅ سلوك مشابه لـ PinCodeTextField
//           keyboardType: TextInputType.number,
//           autoFocus: true,
//           enabled: true,
//           obscureText: false,
//
//
//
//           theme: MaterialPinTheme(
//             borderRadius: BorderRadius.circular(20),
//             borderColor: context.textFieldBorder,
//             focusedBorderColor: context.primarySwatch,
//
//             fillColor: Colors.white,
//             cursorColor: context.primarySwatch,
//             textStyle: context.bodyMedium(
//               color: context.primarySwatch,
//               fontSize: 14,
//             ),
//           ),
//
//
//         ),
//       ),
//     );
//   }
// }