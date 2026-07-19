// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
// import '../../../../common/extensions/src/context_extensions.dart';
// import '../../../../common/helper/src/locale_keys.dart';
// import '../../domain/use_cases/confirm_use_case.dart';
// import '../bloc/auth_bloc.dart';
//
// class ConfirmChangePasswordBody extends StatefulWidget {
//   // final ConfirmScreenParams confirmScreenParams;
//   //
//   // const ConfirmChangePasswordBody({super.key, required this.confirmScreenParams});
//
//   @override
//   State<ConfirmChangePasswordBody> createState() => _ConfirmChangePasswordBodyState();
// }
//
// class _ConfirmChangePasswordBodyState extends State<ConfirmChangePasswordBody> {
//   late final AuthBloc authBloc;
//   late final String phone;
//   late final TextEditingController _controller;
//   final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
//   final ValueNotifier<bool> isValid = ValueNotifier(false);
//
//   @override
//   void initState() {
//     // authBloc = widget.confirmScreenParams.authBloc;
//     // phone = widget.confirmScreenParams.phone;
//     _controller = TextEditingController();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _globalKey,
//       child: Container(
//         padding: EdgeInsetsDirectional.only(
//           top: context.height * .1,
//           start: context.width * .05,
//           end: context.width * .05,
//         ),
//         child: CustomScrollView(
//           slivers: [
//             // SliverToBoxAdapter(
//             //   child: TitleWidget(title: LocaleKeys.authCheckEmail.tr()),
//             // ),
//             // SliverToBoxAdapter(
//             //   child: Padding(
//             //     padding: const EdgeInsets.only(top: 8.0),
//             //     child: SubTitleWidget(subTitle: LocaleKeys.authWeSend.tr()),
//             //   ),
//             // ),
//             SliverToBoxAdapter(
//               child: PinCodeTextField(
//                 controller: _controller,
//                 appContext: context,
//                 length: 4,
//                 animationType: AnimationType.fade,
//                 pinTheme: PinTheme(
//                   shape: PinCodeFieldShape.box,
//                   borderRadius: BorderRadius.circular(20),
//                   fieldHeight: 72,
//                   fieldWidth: 72,
//
//                   inactiveColor: Colors.grey,
//                   activeColor: context.primarySwatch,
//                   activeFillColor: Colors.white,
//                   inactiveFillColor: Colors.white,
//                   selectedFillColor: Colors.white,
//                   activeBorderWidth: 2,
//                   selectedColor: context.secondaryColor,
//                   selectedBorderWidth: 4,
//                 ),
//                 animationDuration: Duration(milliseconds: 500),
//                 textStyle: TextStyle(color: context.primarySwatch),
//                 keyboardType: TextInputType.number,
//                 cursorColor: Colors.transparent,
//                 enableActiveFill: true,
//
//                 // validator: (text)=>text.isValidPinText,
//               ),
//             ),
//             SliverToBoxAdapter(
//               child: ValueListenableBuilder<bool>(
//                 valueListenable: isValid,
//                 builder: (context, value, child) {
//                   return value ? child! : const SizedBox();
//                 },
//                 child: Text(
//                   LocaleKeys.validationRequiredfield.tr(),
//                   style: context.displaySmall(
//                     color: context.theme.colorScheme.error,
//                     fontSize: 12,
//                   ),
//                 ),
//               ),),
//             SliverToBoxAdapter(
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 8.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     // Text(
//                     //   LocaleKeys.authEndIn.tr(),
//                     //   style: context.textTheme.displaySmall!.copyWith(
//                     //     fontSize: 12,
//                     //     fontWeight: FontWeight.bold,
//                     //   ),
//                     // ),
//                     CountdownTimerWidget(),
//                   ],
//                 ),
//               ),
//             ),
//             SliverToBoxAdapter(child: SizedBox(height: context.height * .45)),
//             // SliverToBoxAdapter(
//             //   child: GradientWidget(
//             //     borderRadius: BorderRadius.circular(28),
//             //     height: context.width * .15,
//             //     width: double.infinity,
//             //     isSecond: true,
//             //     child: Center(
//             //       child: TextButton(
//             //         onPressed: () {
//             //           if (_controller.text.length == 4) {
//             //
//             //                 // context.pushNamed(RouteName.resetPassword);
//             //             isValid.value = false;
//             //             // authBloc.add(
//             //             //   ConfirmEvent(
//             //             //     params: ConfirmParams(
//             //             //       otp: _controller.text,
//             //             //       phone: phone,
//             //             //     ),
//             //             //   ),
//             //             // );
//             //           } else {
//             //             isValid.value = true;
//             //           }
//             //         },
//             //         child: Text(
//             //           LocaleKeys.authConfirm.tr(),
//             //           style: context.textTheme.titleSmall!.copyWith(
//             //             fontSize: 16,
//             //             fontWeight: FontWeight.w900,
//             //           ),
//             //         ),
//             //       ),
//             //     ),
//             //   ),
//             // ),
//             SliverToBoxAdapter(
//               child: Container(
//                 margin: EdgeInsets.only(top: context.height * .02),
//                 width: double.infinity,
//                 height: context.width * .15,
//                 child: OutlinedButton(
//                   onPressed: () {
//                     if (_controller.text.length == 4) {
//                       isValid.value = false;
//                       authBloc.add(
//                         ConfirmEvent(
//                           params: ConfirmParams(
//                             otp: _controller.text,
//                             phone: phone,
//                           ),
//                         ),
//                       );
//                     } else {
//                       isValid.value = true;
//                     }
//                   },
//                   child: Text(LocaleKeys.authReSend.tr()),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class CountdownTimerWidget extends StatefulWidget {
//   const CountdownTimerWidget({Key? key}) : super(key: key);
//
//   @override
//   State<CountdownTimerWidget> createState() => _CountdownTimerWidgetState();
// }
//
// class _CountdownTimerWidgetState extends State<CountdownTimerWidget> {
//   static const int _initialTime = 4 * 60; // 4 دقائق بالثواني
//   late int _remainingTime;
//   Timer? _timer;
//
//   @override
//   void initState() {
//     super.initState();
//     _startTimer();
//   }
//
//   void _startTimer() {
//     _remainingTime = _initialTime;
//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       if (_remainingTime == 0) {
//         timer.cancel();
//       } else {
//         setState(() {
//           _remainingTime--;
//         });
//       }
//     });
//   }
//
//   String _formatTime(int seconds) {
//     final minutes = seconds ~/ 60;
//     final secs = seconds % 60;
//     return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
//   }
//
//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text(
//         _formatTime(_remainingTime),
//         style:  TextStyle(
//           fontSize: 12,
//           fontWeight: FontWeight.bold,
//           color: context.secondaryColor,
//         ),
//       ),
//     );
//   }
// }
