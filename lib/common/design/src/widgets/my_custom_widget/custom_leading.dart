// import 'dart:math' as math;
// import 'package:easy_localization/easy_localization.dart';
// import 'package:evowash_user_flutter_app/common/extensions/extensions.dart';
// import 'package:flutter/material.dart';
// import '../../theme/assets.gen.dart';
// import '../svg_asset.dart';
//
// class CustomLeadingBlack extends StatelessWidget {
//   const CustomLeadingBlack({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsetsDirectional.only(start: 20.0, top: 14, bottom: 14),
//       child: GestureDetector(
//         onTap: () => context.pop(),
//         child: Transform(
//           transform: context.locale.languageCode == 'ar'
//               ? Matrix4.identity()
//               : Matrix4.rotationY(math.pi),
//           alignment: Alignment.center,
//           child: Container(
//             width: 24.0, // يمكنك تعديل الحجم حسب الحاجة
//             height: 24.0, // يمكنك تعديل الحجم حسب الحاجة
//             child: FittedBox(
//               fit: BoxFit.contain,
//               child: SvgAsset(Assets.images.svg.backBlackIcon),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
// class CustomLeadingWhite extends StatelessWidget {
//   const CustomLeadingWhite({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsetsDirectional.only(start: 20.0, top: 14, bottom: 14),
//       child: GestureDetector(
//         onTap: () => context.pop(),
//         child: Transform(
//           transform: context.locale.languageCode == 'ar'
//               ? Matrix4.identity()
//               : Matrix4.rotationY(math.pi),
//           alignment: Alignment.center,
//           child: Container(
//             width: 24.0, // يمكنك تعديل الحجم حسب الحاجة
//             height: 24.0, // يمكنك تعديل الحجم حسب الحاجة
//             child: FittedBox(
//               fit: BoxFit.contain,
//               child: SvgAsset(Assets.images.svg.backWhiteIcon),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
