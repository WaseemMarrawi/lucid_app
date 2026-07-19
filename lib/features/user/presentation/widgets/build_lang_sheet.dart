// import 'package:flutter/material.dart';
// import '../../../../common/extensions/src/context_extensions.dart';
// import '../../../../common/helper/src/app_varibles.dart';
// import '../../../../common/helper/src/helper_func.dart';
// import '../../../../common/helper/src/locale_keys.dart';
//
// Future<dynamic> buildLangSheet(BuildContext context) {
//   final isArabic = context.locale.languageCode == 'ar' ? true : false;
//
//   final ValueNotifier<bool> valueNotifier = ValueNotifier(isArabic);
//   return showModalBottomSheet(
//     context: context,
//     isScrollControlled: true,
//     backgroundColor: Colors.transparent,
//     builder: (ctx) {
//       return Container(
//         width: double.infinity,
//         height: context.height * 0.3,
//         padding: EdgeInsets.only(top: context.height * .03),
//         decoration: const BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 12),
//             // Center(
//             //   child: Container(
//             //     width: context.width * .28,
//             //     decoration: BoxDecoration(
//             //       borderRadius: BorderRadius.circular(24),
//             //       color: context.fieldLabelColor.withOpacity(.24),
//             //     ),
//             //     height: 6,
//             //   ),
//             // ),
//             SizedBox(height: 16),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: EdgeInsetsDirectional.only(start: 20),
//                   child: Text(
//                     LocaleKeys.profileLanguage.tr(),
//                     style: context.labelSmall(fontSize: 24),
//                   ),
//                 ),
//                 SizedBox(height: 24),
//                 GestureDetector(
//                   onTap: () {
//                     print('set ar');
//
//                     valueNotifier.value = true; // اختر العربية
//                     context.setLocale(const Locale('ar'));
//                     AppVariables.setCurrentLang(context);
//                     HelperFunc.changeLang();
//                     context.pop();
//                     print('set ar finished');
//                   },
//                   child: Row(
//                     children: [
//                       ValueListenableBuilder<bool>(
//                         valueListenable: valueNotifier,
//                         builder: (context, value, _) {
//                           return Radio<bool>(
//                             value: true,
//                             groupValue: value,
//                             onChanged: null,
//                             activeColor: context.primarySwatch,
//                           );
//                         },
//                       ),
//                       Text(
//                         "العربية",
//                         style: context.headlineSmall(fontSize: 16),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 12),
//                 GestureDetector(
//                   onTap: () {
//                     print('set en');
//                     valueNotifier.value = false; // اختر English
//                     context.setLocale(const Locale('en'));
//                     AppVariables.setCurrentLang(context);
//                     HelperFunc.changeLang();
//                     context.pop();
//
//                     print('finish en');
//                   },
//                   child: Row(
//                     children: [
//                       ValueListenableBuilder<bool>(
//                         valueListenable: valueNotifier,
//                         builder: (context, value, _) {
//                           return Radio<bool>(
//                             value: false,
//                             groupValue: value,
//                             onChanged: null,
//                             activeColor: context.primarySwatch,
//                           );
//                         },
//                       ),
//                       Text(
//                         "English",
//                         style: context.headlineSmall(fontSize: 16),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//
//             // ProfileLanguageButton(
//             //   name: LocaleKeys.profileEnglish.tr(),
//             //   onTap: () {
//             //     context.setLocale(Locale('en'));
//             //   },
//             //   lang: 'en',
//             // ),
//             // هنا تضع محتوى الـ bottomSheet
//           ],
//         ),
//       );
//     },
//     useRootNavigator: true,
//   );
// }
//
// //Container(
// //             width: double.infinity,
// //             height: context.height * 0.5,
// //             padding: EdgeInsets.only(top: context.height * .03),
// //             decoration: const BoxDecoration(
// //               color: Colors.white,
// //               borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
// //             ),
// //             child: SingleChildScrollView(
// //               child: Column(
// //                 children: [
// //                   Center(
// //                     child: SvgAsset(
// //                       Assets.images.svg.profile.alert,
// //                       width: 60,
// //                       height: 60,
// //                     ),
// //                   ),
// //                   SizedBox(
// //                     height:context.height*.02 ,
// //                   ),
// //                   Padding(
// //                     padding: const EdgeInsets.only(bottom:  16.0),
// //                     child: Text(
// //                       LocaleKeys.switchAccountAlmostSwitch.tr(),
// //                       style: context.textTheme.headlineLarge!.copyWith(
// //                         fontSize: 14,
// //                         fontWeight: FontWeight.w900,
// //                       ),
// //                     ),
// //                   ),
// //                   Padding(
// //                     padding:  EdgeInsets.only(bottom:context.height*.03),
// //                     child: Text(
// //                       LocaleKeys.switchAccountCanBack.tr(),
// //                       style: context.textTheme.headlineLarge!.copyWith(
// //                         fontSize: 10,
// //                         fontWeight: FontWeight.w400,
// //                       ),
// //                     ),
// //                   ),
// //                   Padding(
// //                     padding:  EdgeInsets.only(bottom:  context.height*.05),
// //                     child: Text(
// //                       LocaleKeys.switchAccountPartOf.tr(),
// //                       style: context.textTheme.headlineLarge!.copyWith(
// //                         fontSize: 20,
// //                         fontWeight: FontWeight.w400,
// //                       ),
// //                       textAlign: TextAlign.center,
// //                     ),
// //                   ),
// //                   Padding(
// //                     padding:  EdgeInsets.only(bottom:  context.height*.03),
// //                     child: Text(
// //                       LocaleKeys.switchAccountNote.tr(),
// //                       style: context.textTheme.headlineLarge!.copyWith(
// //                         fontSize: 12,
// //                         fontWeight: FontWeight.w400,
// //                       ),
// //                     ),
// //                   ),
// //                   Row(
// //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //                     children: [
// //                       GradientButton(
// //                         onPressed: () {},
// //                         contentChild: Text(LocaleKeys.switchContinueAs.tr(),
// //                           style: context.textTheme.titleMedium!.copyWith(
// //                               fontWeight: FontWeight.w900,
// //                               fontSize: 16
// //                           ),
// //
// //                         ),
// //                         borderRadius: BorderRadius.circular(500),
// //                         isSecondaryGradient: true,
// //                       ),
// //                       GradiantTextWidget(
// //                         title: LocaleKeys.switchAccountCancel.tr(),
// //                         fontSize: 16,
// //                         fontWeight: FontWeight.w900,
// //                       ),
// //                     ],
// //                   ),
// //
// //                   // هنا تضع محتوى الـ bottomSheet
// //                 ],
// //               ),
// //             ),
// //           )
