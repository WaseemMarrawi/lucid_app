//
// import 'package:evowash_user_flutter_app/common/extensions/extensions.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:permission_handler/permission_handler.dart';
// import '../../../../common/design/src/theme/assets.gen.dart';
// import '../../../../common/design/src/widgets/gradiant_widgets/gradient_button.dart';
// import '../../../../common/design/src/widgets/gradiant_widgets/title_widget.dart';
// import '../../../../common/design/src/widgets/svg_asset.dart';
// import '../../../../common/helper/src/locale_keys.dart';
// import '../../../../core/di/injection.dart';
// import '../../../../core/permissions/cubit/permissions_cubit.dart';
// import '../../../../router/app_router.dart';
// import '../../../auth/presentation/widgets/sign_up_widget.dart';
//
// class SelectLocationScreen extends StatefulWidget {
//   const SelectLocationScreen({super.key});
//
//   @override
//   State<SelectLocationScreen> createState() => _SelectLocationScreenState();
// }
//
// class _SelectLocationScreenState extends State<SelectLocationScreen> {
//   late final PermissionCubit permissionCubit;
//   bool isTapped=false;
//
//   @override
//   void initState() {
//     SystemChrome.setSystemUIOverlayStyle(
//       const SystemUiOverlayStyle(
//         statusBarColor: Colors.transparent, // لون خلفية شريط الحالة
//         statusBarIconBrightness: Brightness.dark, // لون الأيقونات (مثل البطارية والإشارة)
//       ),);
//     permissionCubit = getIt<PermissionCubit>();
//
//     // TODO: implement initState
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: EdgeInsetsDirectional.symmetric(
//           horizontal: context.width * .05,
//
//           // top: context.height * .1,
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             Row(
//               children: [
//                 GestureDetector(
//                   child: TitleWidget(
//                     textStyle: context.textTheme.headlineSmall!.copyWith(
//                       fontSize: 17,
//                       fontWeight: FontWeight.w400,
//                       color: context.secondaryColor,
//                     ),
//                     title: LocaleKeys.selectLocationSkip.tr(),
//                   ),
//                   onTap:
//                       () => context.pushNamedAndRemoveUntil(
//                         RouteName.homeNav,
//                         (e) => false,
//                       ),
//                 ),
//               ],
//             ),
//             SizedBox(),
//             //SizedBox(height: context.height * .1),
//             SvgAsset(
//               Assets.images.svg.word,
//               width: context.width * .9,
//               height: context.width * .6,
//             ),
//             Column(
//               children: [
//                 TitleWidget(title: LocaleKeys.selectLocationSearchNer.tr()),
//                 SubTitleWidget(
//                   subTitle: LocaleKeys.selectLocationPleaseChoose.tr(),
//                 ),
//               ],
//             ),
//             SizedBox(),
//             SizedBox(),
//             SizedBox(
//               height: context.height * .051,
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: BlocConsumer<PermissionCubit, PermissionState>(
//                       bloc: permissionCubit..checkInitialPermissions(),
//
//                       builder: (context, state) {
//                         return GradientButton(
//                           onPressed: () {
//                             isTapped=true;
//                             state.locationPermission.isDenied
//                                 ? permissionCubit.requestLocationPermission()
//
//                                 : context.pushReplacementNamed(RouteName.homeNav);
//                           },
//                           contentChild: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               SvgAsset(Assets.images.svg.gps),
//                               Flexible(
//                                 child: Text(
//                                   LocaleKeys.selectLocationUseYourLocation.tr(),
//                                   style: context.textTheme.titleSmall!.copyWith(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w600,
//                                     overflow: TextOverflow.ellipsis
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           isSecondaryGradient: true,
//                           borderRadius: BorderRadius.circular(500),
//                         );
//                       },
//                       listenWhen:
//                           (pre, suf) =>
//                               pre.locationPermission != suf.locationPermission,
//                       listener: (context, state) {
//                         if ((state.locationPermission.isGranted ||
//                             state.locationPermission.isLimited)&& isTapped==true ) {
//
//                           context.pushReplacementNamed(RouteName.homeNav);
//                         }
//                       },
//                     ),
//                   ),
//                   SizedBox(width: context.width * .01),
//                   Expanded(
//                     child: GestureDetector(
//                       onTap: () {},
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(500),
//                           // gradient:  LinearGradient(
//                           //   colors:  [PColors.secondaryYellow, PColors.secondaryYellowOpacity]
//                           //      ,
//                           //   begin: Alignment.topLeft,
//                           //   end: Alignment.bottomRight,
//                           // ),
//                           border: Border.all(color: context.secondaryColor),
//                         ),
//                         padding: EdgeInsets.all(8),
//
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             SvgAsset(Assets.images.svg.location),
//                             Flexible(
//                               child: Text(
//                                 LocaleKeys.selectLocationChooseFromMap.tr(),
//                                 style: context.textTheme.titleSmall!.copyWith(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w600,
//                                   color: context.secondaryColor,
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                                 maxLines: 2,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
