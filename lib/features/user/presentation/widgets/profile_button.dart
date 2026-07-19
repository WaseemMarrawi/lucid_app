// import 'package:evowash_user_flutter_app/common/extensions/extensions.dart';
// import 'package:flutter/material.dart';
// import '../../../../common/design/src/theme/assets.gen.dart';
// import '../../../../common/design/src/widgets/svg_asset.dart';
// import '../../../../common/helper/src/app_varibles.dart';
//
// class ProfileButton extends StatelessWidget {
//   final String name;
//   final IconData icon;
//   final GestureTapCallback onTap;
//
//   const ProfileButton({
//     super.key,
//     required this.name,
//     required this.icon,
//     required this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(color: context.theme.primaryColor),
//         ),
//         margin: const EdgeInsetsDirectional.symmetric(
//           horizontal: 10,
//           vertical: 10,
//         ),
//         child: ListTile(
//           leading: Icon(icon),
//           title: Text(name),
//           trailing: SvgAsset(
//             AppVariables.checkLanguage(context) == 'ar'
//                 ? Assets.images.svg.leftArrow
//                 : Assets.images.svg.rightArrow,
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class ProfileLanguageButton extends StatefulWidget {
//   final String name;
//   final GestureTapCallback onTap;
//   final String lang;
//
//   const ProfileLanguageButton({
//     super.key,
//     required this.name,
//     required this.onTap,
//     required this.lang,
//   });
//
//   @override
//   State<ProfileLanguageButton> createState() => _ProfileLanguageButtonState();
// }
//
// class _ProfileLanguageButtonState extends State<ProfileLanguageButton> {
//   // late final ValueNotifier<String> trueCheck;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     // trueCheck = ValueNotifier(widget.check);
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: widget.onTap,
//       child: Container(
//         margin: const EdgeInsetsDirectional.symmetric(horizontal: 10),
//         child: ListTile(
//           title: GradiantTextWidget(
//             title: widget.name,
//             isPrimary:
//                 AppVariables.checkLanguage(context) == widget.lang
//                     ? false
//                     : true,
//             fontWeight: FontWeight.w900,
//             fontSize: 16,
//           ),
//           trailing:
//               AppVariables.checkLanguage(context) == widget.lang
//                   ? const Icon(Icons.check, color: Colors.green)
//                   : SvgAsset(
//                     AppVariables.checkLanguage(context) == 'ar'
//                         ? Assets.images.svg.leftArrow
//                         : Assets.images.svg.rightArrow,
//                   ),
//         ),
//       ),
//     );
//   }
// }
//
//
//
// class ProfileAccountButton extends StatelessWidget {
//   final String name;
//   final Widget leading;
//   final GestureTapCallback onTap;
//   final ValueNotifier valueNotifier ;
//   final bool isUser;
//
//   const ProfileAccountButton({super.key, required this.name, required this.leading, required this.onTap, required this.valueNotifier, required this.isUser});
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         margin: const EdgeInsetsDirectional.symmetric(horizontal: 10),
//         child: ValueListenableBuilder(
//
//           builder: (context,value,child){
//             return ListTile(
//               leading: leading,
//               title: GradiantTextWidget(
//                 title: name,
//                 isPrimary:
//                 isUser
//                     ? false
//                     : true,
//                 fontWeight: FontWeight.w900,
//                 fontSize: 16,
//               ),
//               trailing:
//               value
//                   ? const Icon(Icons.check, color: Colors.green)
//                   : SvgAsset(
//                 AppVariables.checkLanguage(context) == 'ar'
//                     ? Assets.images.svg.leftArrow
//                     : Assets.images.svg.rightArrow,
//               ),
//             );
//           },
//           valueListenable:valueNotifier,
//         ),
//       ),
//     );
//   }
// }
//
//
// class ProfileAccount2Button extends StatelessWidget {
//   final String name;
//   final Widget leading;
//   final GestureTapCallback onTap;
//   final ValueNotifier valueNotifier ;
//   final bool isUser;
//
//   const ProfileAccount2Button({super.key, required this.name, required this.leading, required this.onTap, required this.valueNotifier, required this.isUser});
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         margin: const EdgeInsetsDirectional.symmetric(horizontal: 10),
//         child: ValueListenableBuilder(
//
//           builder: (context,value,child){
//             return ListTile(
//               leading: leading,
//               title: GradiantTextWidget(
//                 title: name,
//                 isPrimary:
//                 isUser
//                     ? false
//                     : true,
//                 fontWeight: FontWeight.w900,
//                 fontSize: 16,
//               ),
//               trailing:
//               value
//                   ? SvgAsset(
//                 AppVariables.checkLanguage(context) == 'ar'
//                     ? Assets.images.svg.leftArrow
//                     : Assets.images.svg.rightArrow,
//               )
//                   :
//                 const Icon(Icons.check, color: Colors.green),
//             );
//           },
//           valueListenable:valueNotifier,
//         ),
//       ),
//     );
//   }
// }
