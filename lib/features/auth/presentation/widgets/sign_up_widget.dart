// import 'package:evowash_user_flutter_app/common/extensions/extensions.dart';
// import 'package:flutter/material.dart';
// import '../../../../common/helper/src/locale_keys.dart';
// import '../../../../router/app_router.dart';
//
// class SignOption extends StatelessWidget {
//   const SignOption({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(child: Container(height: 1, color: Colors.grey)),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 8.0),
//           child: Text(
//             LocaleKeys.authOrSignWith.tr(),
//             style: context.bodySmall(
//               fontWeight: FontWeight.w500,
//               fontSize: 12,
//             ),
//           ),
//         ),
//         Expanded(child: Container(height: 1, color: Colors.grey)),
//       ],
//     );
//   }
// }
// class PasswordShouldWidget extends StatelessWidget {
//   const PasswordShouldWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return SliverToBoxAdapter(
//       child: Padding(
//         padding: const EdgeInsetsDirectional.only(start: 14),
//         // child: Text(
//         //   LocaleKeys.authPasswordShouldHave.tr(),
//         //   style: context.textTheme.labelSmall!.copyWith(
//         //     fontSize: 12,
//         //     fontWeight: FontWeight.bold,
//         //   ),
//         // ),
//       ),
//     );
//   }
// }
// class DontHaveAccount extends StatelessWidget {
//   const DontHaveAccount({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return SliverToBoxAdapter(
//       child: Padding(
//         padding: const EdgeInsetsDirectional.only(start: 14),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Text(
//               LocaleKeys.authAlreadyHave.tr(),
//               style: context.textTheme.labelSmall!.copyWith(
//                 fontWeight: FontWeight.w500,
//                 fontSize: 12,
//               ),
//             ),
//             TextButton(
//               onPressed: () {
//                 context.pushNamedAndRemoveUntil(RouteName.login,(e)=>false);
//               },
//               child: Text(
//                 LocaleKeys.authLogIn.tr(),
//                 style: context.textTheme.labelSmall!.copyWith(
//                   fontWeight: FontWeight.w500,
//                   fontSize: 12,
//                   color: context.secondaryColor,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// class SubTitleWidget extends StatelessWidget {
//   final String subTitle;
//
//   const SubTitleWidget({super.key, required this.subTitle});
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Padding(
//         padding: EdgeInsets.only(bottom: context.height * .03),
//         child: Text(
//           subTitle,
//           style: context.textTheme.displaySmall!.copyWith(
//             fontSize: 12,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ),
//     );
//   }
// }
// class CheckPasswordWidget extends StatelessWidget {
//   const CheckPasswordWidget({
//     super.key,
//     required this.checkEight,
//     required this.checkContainNumber,
//   });
//
//   final ValueNotifier<bool> checkEight;
//   final ValueNotifier<bool> checkContainNumber;
//
//   @override
//   Widget build(BuildContext context) {
//     return SliverToBoxAdapter(
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Row(
//             children: [
//               ValueListenableBuilder(
//                 valueListenable: checkEight,
//                 builder: (context, value, child) {
//                   return Transform.scale(
//                     scale: 1.3,
//                     child: Checkbox(
//                       side: WidgetStateBorderSide.resolveWith(
//                             (states) => states.contains(WidgetState.selected)
//                             ? const BorderSide(
//                           color: Colors.transparent,
//
//                         )
//                             : const BorderSide(
//                           color: Colors.transparent,
//
//                         ),
//                       ),
//                       visualDensity: const VisualDensity(vertical: -4.0),
//                       value: value,
//                       onChanged: (val) {},
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(
//                           50,
//                         ),
//
//                       ),
//
//
//                       fillColor:
//                       value
//                           ? MaterialStateProperty.all(
//                         const Color.fromRGBO(227, 255, 241, 1),
//                       )
//                           : MaterialStateProperty.all(
//                         const Color.fromRGBO(251, 218, 196, 1),
//                       ),
//
//                       checkColor:
//                       value
//                           ? context.primarySwatch
//                           : context.secondaryColor,
//                     ),
//                   );
//                 },
//               ),
//
//               // Text(
//               //   LocaleKeys.authNumberCount.tr(),
//               //   style: context.textTheme.bodySmall!.copyWith(
//               //     fontWeight: FontWeight.w500,
//               //     fontSize: 12,
//               //     color: context.secondaryColor,
//               //   ),
//               // ),
//             ],
//           ),
//           Row(
//             children: [
//               Transform.scale(
//                 scale: 1.3,
//
//                 child: ValueListenableBuilder(
//                   valueListenable: checkContainNumber,
//                   builder: (context, value, child) {
//                     return Checkbox(
//                       side: WidgetStateBorderSide.resolveWith(
//                             (states) => states.contains(WidgetState.selected)
//                             ? const BorderSide(
//                           color: Colors.transparent,
//
//                         )
//                             : const BorderSide(
//                           color: Colors.transparent,
//
//                         ),
//                       ),
//
//                       visualDensity: const VisualDensity(vertical: -4.0),
//                       value: value,
//                       onChanged: (val) {},
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(
//                           50,
//                         ),
//                       ),
//
//                       fillColor:
//                       value
//                           ? MaterialStateProperty.all(
//                         const Color.fromRGBO(227, 255, 241, 1),
//                       )
//                           : MaterialStateProperty.all(
//                         const Color.fromRGBO(251, 218, 196, 1),
//                       ),
//
//                       checkColor:
//                       value
//                           ? context.primarySwatch
//                           : context.secondaryColor,
//
//
//                     );
//                   },
//                 ),
//               ),
//               // Text(
//               //   LocaleKeys.authCharOne.tr(),
//               //   style: context.textTheme.bodySmall!.copyWith(
//               //     fontWeight: FontWeight.w500,
//               //     fontSize: 12,
//               //     color: context.secondaryColor,
//               //   ),
//               // ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
// class PrivacyWidget extends StatelessWidget {
//   const PrivacyWidget({
//     super.key,
//     required this.checkPrivacy,
//   });
//
//   final ValueNotifier<bool> checkPrivacy;
//
//   @override
//   Widget build(BuildContext context) {
//     return SliverToBoxAdapter(
//
//       child: Padding(
//
//         padding: EdgeInsets.only(bottom: context.height * .01),
//
//         child: Row(
//           children: [
//             ValueListenableBuilder(
//               valueListenable: checkPrivacy,
//               builder: (context, value, child) {
//                 return Checkbox(
//                   value: value,
//                   onChanged: (val) {
//                     checkPrivacy.value = val!;
//                   },
//                   visualDensity: VisualDensity(vertical: -4.0),
//                   side: value == true
//                       ? BorderSide(color: context.textFieldHintColor, width: 1.5)
//                       : BorderSide(color: context.primarySwatch, width: 1.0),
//
//
//
//                 );
//               },
//             ),
//             // Text(
//             //   LocaleKeys.authConfirmPolitic.tr(),
//             //   style: context.textTheme.labelSmall!.copyWith(
//             //     fontWeight: FontWeight.w500,
//             //     fontSize: 12,
//             //   ),
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
