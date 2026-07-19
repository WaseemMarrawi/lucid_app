//
//
//   import 'dart:async';
//
// import 'package:evowash_user_flutter_app/common/enums/enums.dart';
// import 'package:evowash_user_flutter_app/common/extensions/extensions.dart';
// import 'package:evowash_user_flutter_app/features/auth/presentation/bloc/auth_bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
//
//   class PinCustomWidget extends StatelessWidget {
//
//
//       final ValueNotifier<bool> _isValid;
//       final TextEditingController _pinController;
//        final StreamController<ErrorAnimationType> errorController;
//        final AuthBloc authBloc;
//        final BlocStatus stateStatus;
//        final bool isArabic;
//
//   const PinCustomWidget({super.key,
//     required ValueNotifier<bool> isValid,
//     required  this.isArabic,
//     required TextEditingController pinController, required this.errorController, required this.authBloc, required this.stateStatus}) : _isValid = isValid, _pinController = pinController;
//
//
//
//
//       @override
//       Widget build(BuildContext context) {
//         return BlocBuilder<AuthBloc, AuthState>(
//           bloc: authBloc,
//           builder: (context, state) {
//             final isSuccess = stateStatus ==BlocStatus.success;
//
//             return ValueListenableBuilder(
//               valueListenable: _isValid,
//               builder: (context, value, child) {
//
//                 final borderColor = isSuccess
//                     ? context.successColor
//                     : context.primarySwatch;
//
//                 return Directionality(
//                   textDirection: TextDirection.ltr,
//
//                   child: PinCodeTextField(
//                     controller: _pinController,
//                     appContext: context,
//                     length: 6,
//                     animationType: AnimationType.fade,
//
//                     pinTheme: PinTheme(
//                       fieldHeight: 70,
//
//                       fieldWidth: MediaQuery.of(context).size.width / 7.5,
//                       shape: PinCodeFieldShape.box,
//                       borderRadius: BorderRadius.circular(16),
//                       selectedColor: borderColor,
//                       activeColor: borderColor,
//                       inactiveColor: context.textFieldBorderColor,
//                       activeFillColor: Colors.white,
//                       inactiveFillColor: Colors.white,
//                       selectedFillColor: Colors.white,
//                       activeBorderWidth: 1,
//                       selectedBorderWidth: 1,
//                       errorBorderColor: context.errorColor,
//                     ),
//
//                     animationDuration: const Duration(milliseconds: 500),
//                     textStyle: context.displaySmall(),
//                     errorTextDirection:isArabic?TextDirection.rtl: TextDirection.ltr,
//
//                     keyboardType: TextInputType.number,
//                     cursorColor: Colors.transparent,
//                     enableActiveFill: true,
//                     validator: (text) =>
//                         text.isValidPinText(errorController, value),
//                     errorAnimationController: errorController,
//                   ),
//                 );
//               },
//             );
//           },
//         );
//       }
//     }
