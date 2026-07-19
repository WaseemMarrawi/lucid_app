// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:lottie/lottie.dart';
// import '../../../common/design/src/theme/const.dart';
// import '../../../common/design/src/widgets/animation_widget/animated_scale_widget.dart';
// import '../../../common/extensions/src/context_extensions.dart';
// import '../../../common/helper/src/locale_keys.dart';
//
// void showVersionDialog({
//   required BuildContext context,
//   required String? storeUrl,
// }) {
//   showDialog(
//     context: context,
//     builder: (BuildContext ctx) {
//       return AlertDialog(
//         content: Padding(
//           padding: const EdgeInsets.only(top: 40, bottom: 10),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Lottie.asset(
//                 'assets/animations/update.json',
//                 width: 120,
//                 height: 120,
//                 repeat: true, // لتكرار الرسوم المتحركة
//               ),
//               Text(
//                 LocaleKeys.versionANewVersion.tr(),
//                 style: context.headlineSmall(fontSize: 18),
//                 textAlign: TextAlign.center,
//               ),
//
//               Container(
//                 margin: const EdgeInsets.only(top: 16, bottom: 24),
//                 child: Text(
//                   LocaleKeys.versionThisVersionForce.tr(),
//                   style: context.bodySmall(fontSize: 14),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               AnimatedScaleWidget(
//                 child: ElevatedButton(
//                   onPressed:
//                       storeUrl == null
//                           ? null
//                           : () async {
//                             final url = Uri.parse(storeUrl);
//
//                             if (await canLaunchUrl(url)) {
//                               await launchUrl(
//                                 url,
//                                 mode: LaunchMode.externalApplication,
//                               );
//                             } else {}
//                           },
//
//                   child: Text(
//                     LocaleKeys.versionUpdateNow.tr(),
//                     style: context.headlineSmall(
//                       color: Colors.white,
//                       fontSize: 16,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     },
//     barrierDismissible: false,
//   );
// }
//
// void showVersionDialogOptional({
//   required BuildContext context,
//   required String? storeUrl,
//   required Function after,
// }) {
//   showDialog(
//     context: context,
//     builder: (BuildContext ctx) {
//       return AlertDialog(
//         content: Padding(
//           padding: const EdgeInsets.only(top: 40, bottom: 10),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Lottie.asset(
//                 'assets/animations/update.json',
//                 width: 120,
//                 height: 120,
//                 repeat: true, // لتكرار الرسوم المتحركة
//               ),
//               Text(
//                 LocaleKeys.versionANewVersion.tr(),
//                 style: context.headlineSmall(fontSize: 18),
//                 textAlign: TextAlign.center,
//               ),
//
//               Container(
//                 margin: const EdgeInsets.only(top: 16, bottom: 24),
//                 child: Text(
//                   LocaleKeys.versionThisVersionSuggest.tr(),
//                   style: context.bodySmall(fontSize: 14),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               AnimatedScaleWidget(
//                 child: ElevatedButton(
//                   onPressed:
//                       storeUrl == null
//                           ? null
//                           : () async {
//                             final url = Uri.parse(storeUrl);
//
//                             if (await canLaunchUrl(url)) {
//                               await launchUrl(
//                                 url,
//                                 mode: LaunchMode.externalApplication,
//                               );
//                             } else {
//                               // لو ما قدر يفتح الرابط
//                               debugPrint("❌ ما قدرت أفتح الرابط: $url");
//                             }
//                           },
//
//                   child: Text(
//                     LocaleKeys.versionUpdateNow.tr(),
//                     style: context.headlineSmall(
//                       color: Colors.white,
//                       fontSize: 16,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               ),
//               Space.vM1,
//               InkWell(
//                 child: Text(
//                   'Skip',
//                   style: context.headlineSmall(fontSize: 16),
//                   textAlign: TextAlign.center,
//                 ),
//                 onTap: () => ctx.pop(),
//               ),
//             ],
//           ),
//         ),
//       );
//     },
//   ).then((_) {
//     after();
//   });
// }
