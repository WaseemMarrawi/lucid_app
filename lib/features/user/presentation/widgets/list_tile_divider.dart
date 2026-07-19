//
// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../../../common/design/src/theme/assets.gen.dart';
// import '../../../../common/design/src/theme/theme/theme_notifier.dart';
// import '../../../../common/design/src/widgets/my_custom_widget/rotating_widget.dart';
// import '../../../../common/design/src/widgets/svg_asset.dart';
// import '../../../../common/extensions/src/context_extensions.dart';
// import '../../../../common/helper/src/app_varibles.dart';
// import '../../../../common/helper/src/locale_keys.dart';
// import '../../../../core/di/injection.dart';
// import '../../../../router/app_router.dart';
// import '../../../auth/presentation/bloc/auth_bloc.dart';
//
// class ListTileDivider extends StatelessWidget {
//   final String title;
//   final String svgIcon;
//   final bool hasDivider;
//   final VoidCallback? onTap;
//   final Color color;
//   final bool isNext;
//
//   const ListTileDivider({
//     super.key,
//     required this.title,
//     required this.svgIcon,
//     this.hasDivider = false,
//     this.onTap,
//     required this.color,
//     this.isNext = true,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final bool isArabic = context.locale.languageCode == 'ar';
//
//     return GestureDetector(
//       onTap: onTap,
//       child: Column(
//         children: [
//           ListTile(
//             title: Text(title, style: context.headlineSmall(fontSize: 16)) .animate()
//                 .fadeIn(delay: 200.ms, duration: 600.ms)
//                 .scale(
//                 begin: const Offset(0.5, 0.5),
//                 end: const Offset(1, 1),
//                 curve: Curves.elasticOut,
//
//             ),
//             leading: SolidShadowButtonWidget(color: color, svgIcon: svgIcon)
//                 .animate()
//                 .fadeIn(delay: 200.ms, duration: 600.ms)
//                 .scale(
//               begin: const Offset(0.5, 0.5),
//               end: const Offset(1, 1),
//               curve: Curves.elasticOut,
//
//             ),
//             trailing: isNext
//                 ? FlippableImage(
//                   child: SvgAsset(
//                    Assets.images.svg.nextArrowIcon,
//                     color: context.primarySwatch,
//                     width: 24
//                   ),
//                 )
//                 : SizedBox(),
//           ),
//           hasDivider
//               ? Container(
//                   width: double.infinity,
//                   height: 1,
//
//                   margin: EdgeInsets.symmetric(vertical: 16),
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [
//                         context.grey.withOpacity(0),
//                         context.grey.withOpacity(.5),
//                         context.grey.withOpacity(0),
//                       ],
//                       begin: AlignmentDirectional.centerStart,
//                       end: AlignmentDirectional.centerEnd,
//                     ),
//                   ),
//                 )
//               : const SizedBox(),
//         ],
//       ),
//     );
//   }
// }
//
// class ListTileLogOutWidget extends StatefulWidget {
//   @override
//   State<ListTileLogOutWidget> createState() => _ListTileLogOutWidgetState();
// }
//
// class _ListTileLogOutWidgetState extends State<ListTileLogOutWidget> {
//   late final AuthBloc authBloc;
//
//   @override
//   void initState() {
//     authBloc = getIt<AuthBloc>();
//     // TODO: implement initState
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final bool isArabic = context.locale.languageCode == 'ar';
//
//     // TODO: implement build
//     return BlocListener<AuthBloc, AuthState>(
//       bloc: authBloc,
//       listener: (context, state) {
//         state.logOutData.listenerFunction(
//           onSuccess: () {
//             context.read<AppThemeNotifier>().setTheme(
//              AppThemeType.male,
//             );
//             context.pushNamedAndRemoveUntil(RouteName.splash, (e) => false);
//           },
//         );
//       },
//       child: GestureDetector(
//         onTap: () {
//           showDialog(
//             context: context,
//             builder: (_) {
//               return AlertDialog(
//                 content: SizedBox(
//                   width: context.width,
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       SizedBox(height: 12),
//                       Text(
//                         LocaleKeys.profileConfirmLogOut.tr(),
//                         style: context.labelSmall(
//                           fontSize: 20,
//                           fontFamily: "Nasaq",
//                         ),
//                       ),
//                       SizedBox(height: 12),
//                       Text(
//                         LocaleKeys.profileAreUSure.tr(),
//                         style: context.bodySmall(fontSize: 14),
//                         textAlign: TextAlign.center,
//                       ),
//                       SizedBox(height: 24),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: SolidBorderButtonText(
//                               padding: 12,
//                               onTap: () {
//                                 context.pop();
//                               },
//                               title: LocaleKeys.profileBack.tr(),
//                               ctx: context,
//                             ),
//                           ),
//                           SizedBox(width: 12),
//                           Expanded(
//                             child: SolidTextCenterButtonWidget(
//
//                               padding: 12,
//                               title: LocaleKeys.drawerLogOut.tr(),
//                               onTap: () {
//                                 authBloc.add(LogOutEvent());
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 4),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//         child: ListTile(
//           title: Text(
//             LocaleKeys.drawerLogOut.tr(),
//             style: context.headlineSmall(
//               fontSize: 16,
//               color: context.errorColor,
//             ),
//           ),
//           leading: Padding(
//             padding: EdgeInsets.all(10),
//             child: SvgAsset(
//               Assets.images.svg.drawer.logOutIcon,
//               color: context.errorColor,
//               width: 25,
//               height: 25,
//             ),
//           ),
//
//           trailing: Transform(
//             alignment: Alignment.center,
//             transform: Matrix4.identity()..scale(isArabic ? 1.0 : -1.0, -1.0),
//             child: SvgAsset(
//               Assets.images.svg.nextArrowIcon,
//               color: context.errorColor,
//
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
