// import 'dart:async';
// import 'package:deal/common/extensions/extensions.dart';
// import 'package:deal/features/auth/domain/use_cases/signup_use_case.dart';
// import 'package:deal/features/auth/presentation/widgets/sign_up_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
// import '../../../../common/design/src/widgets/gradiant_widgets/gradient_widget.dart';
// import '../../../../common/design/src/widgets/gradiant_widgets/title_widget.dart';
// import '../../../../common/helper/src/locale_keys.dart';
// import '../../domain/use_cases/confirm_use_case.dart';
// import '../bloc/auth_bloc.dart';
// import '../pages/confirm_screen.dart';
//
// class ConfirmBody extends StatefulWidget {
//   final ConfirmScreenParams confirmScreenParams;
//
//   const ConfirmBody({super.key, required this.confirmScreenParams});
//
//   @override
//   State<ConfirmBody> createState() => _ConfirmBodyState();
// }
//
// class _ConfirmBodyState extends State<ConfirmBody> {
//   late final AuthBloc authBloc;
//
//
//
//   @override
//   void dispose() {
//
//     super.dispose();
//   }
//
//
//
//
//
//
//   @override
//   void initState() {
//     startTimer();
//     // authBloc = widget.confirmScreenParams.authBloc;
//     // phone = widget.confirmScreenParams.phone;
//
//     super.initState();
//   }
//
//
//
// }
//
//
// // class CountdownTimerWidget extends StatefulWidget {
// //   final Function() onTimerComplete;
// //
// //   const CountdownTimerWidget({
// //     Key? key,
// //     required this.onTimerComplete,
// //   }) : super(key: key);
// //
// //   @override
// //   State<CountdownTimerWidget> createState() => _CountdownTimerWidgetState();
// // }
// //
// // class _CountdownTimerWidgetState extends State<CountdownTimerWidget> {
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Column(
// //       mainAxisSize: MainAxisSize.min,
// //       children: [
// //
// //         const SizedBox(height: 8),
// //         ElevatedButton(
// //           onPressed: resetTimer,
// //           child: const Text('إعادة العد'),
// //         ),
// //       ],
// //     );
// //   }
// // }
