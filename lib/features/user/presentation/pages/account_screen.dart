// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:permission_handler/permission_handler.dart';
// import '../../../../common/design/src/theme/assets.gen.dart';
// import '../../../../common/design/src/widgets/animation_widget/animated_title_text_widget.dart';
// import '../../../../common/design/src/widgets/svg_asset.dart';
// import '../../../../common/extensions/src/context_extensions.dart';
// import '../../../../common/extensions/src/image_provider.dart';
// import '../../../../common/helper/src/app_varibles.dart';
// import '../../../../common/helper/src/locale_keys.dart';
// import '../../../../core/di/injection.dart';
// import '../../../../core/permissions/cubit/permissions_cubit.dart';
// import '../../../../router/app_router.dart';
// import '../../domain/use_cases/user_update_profile_use_cases.dart';
// import '../bloc/user_bloc.dart';
// import '../widgets/build_lang_sheet.dart';
// import '../widgets/list_tile_divider.dart';
// import '../widgets/phone_text.dart';
//
// class AccountScreen extends StatefulWidget {
//   const AccountScreen({super.key});
//
//   @override
//   State<AccountScreen> createState() => _AccountScreenState();
// }
//
// class _AccountScreenState extends State<AccountScreen> {
//   late final UserBloc userBloc;
//   late final PermissionCubit permissionCubit;
//   late final ValueNotifier<File?> valueNotifier;
//
//   @override
//   void initState() {
//     userBloc = getIt<UserBloc>();
//     permissionCubit = getIt<PermissionCubit>()..checkInitialPermissions();
//     valueNotifier = ValueNotifier(null);
//     // TODO: implement initState
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<UserBloc, UserState>(
//       listenWhen:
//           (pre, next) =>
//               pre.postProfileImageData.status !=
//               next.postProfileImageData.status,
//       listener: (context, state) {
//         state.postProfileImageData.listenerFunction(
//           onSuccess: () {
//           },
//         );
//       },
//       bloc: userBloc..add(UserGetMeEvent()),
//       builder: (context, state) {
//         return Padding(
//           padding: EdgeInsets.only(
//             top: MediaQuery.of(context).padding.top,
//             left: context.width * .05,
//             right: context.width * .05,
//           ),
//           child: state.getMeData.builder(
//             onSuccess: (_) {
//               return RefreshIndicator(
//                 onRefresh: () async {
//                   userBloc.add(UserGetMeEvent());
//                 },
//                 child: CustomScrollView(
//                   slivers: [
//                     SliverPadding(
//                       padding: EdgeInsets.only(top: 10),
//                       sliver: SliverToBoxAdapter(
//                         child: AnimatedTitleTextWidget(
//                           child: Text(
//                             LocaleKeys.navBarProfile.tr(),
//                             //'Hello',
//                             style: context.labelSmall(
//                               fontSize: 24,
//                               fontFamily: "Nasaq",
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     SliverPadding(
//                       padding: EdgeInsets.only(top: 34, bottom: 8),
//                       sliver: SliverToBoxAdapter(
//                         child: Align(
//                           alignment: Alignment.center,
//                           child: Stack(
//                             alignment: AlignmentDirectional.bottomEnd,
//                             children: [
//                               state.getMeData.data!.data!.profileImage?.url ==
//                                       null
//                                   ? Container(
//                                     width: context.width * .272,
//                                     height: context.width * .272,
//
//                                     decoration: BoxDecoration(
//                                       border: Border.all(
//                                         color: context.textFieldBorder,
//                                       ),
//                                       shape: BoxShape.circle,
//                                     ),
//                                     child: ClipOval(
//                                       child: Align(
//                                         alignment: Alignment.bottomCenter,
//                                         child: FractionallySizedBox(
//                                           widthFactor: 0.8,  // صغّر/كبّر حسب ما بدك
//                                           heightFactor: 0.8,
//                                           child: SvgAsset(
//                                             AppVariables.user.gender == 'male'
//                                                 ? Assets.images.svg.profile.manProfileImage
//                                                 : Assets.images.svg.profile.girlProfileImage,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   )
//                                   : CacheNetworkImage(
//                                     imageUrl:
//                                         state
//                                             .getMeData
//                                             .data!
//                                             .data!
//                                             .profileImage!
//                                             .url!,
//                                     width: context.width * .272,
//                                     height: context.width * .272,
//                                     shape: BoxShape.circle,
//                                   ),
//                               GestureDetector(
//                                 child: Container(
//                                   padding: EdgeInsets.all(10),
//                                   decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     shape: BoxShape.circle,
//                                   ),
//                                   child: SvgAsset(
//                                     Assets.images.svg.profile.cameraIcon,
//                                   ),
//                                 ),
//                                 onTap: () async {
//                                   await _handlePhotosPermission(
//                                     context: context,
//                                     permissionCubit: permissionCubit,
//                                     valueNotifier: valueNotifier,
//                                   );
//                                   final image = valueNotifier.value;
//                                   if (image != null) {
//                                     userBloc.add(
//                                       UserUpdateProfileImageEvent(
//                                         params: UserUpdateProfileImageParams(
//                                           image: image,
//                                         ),
//                                       ),
//                                     );
//                                     valueNotifier.value = null; // reset
//                                   }
//                                 },
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     SliverPadding(
//                       sliver: SliverToBoxAdapter(
//                         child: Center(
//                           child: Text(
//                             state.getMeData.data!.data!.lastName == null
//                                 ? state.getMeData.data!.data!.firstName!
//                                 : '${state.getMeData.data!.data!.firstName!} ${state.getMeData.data!.data!.lastName!}',
//                             style: context.labelSmall(fontSize: 20),
//                             softWrap: true,
//                             textAlign: TextAlign.center,
//                           ),
//                         ),
//                       ),
//                       padding: EdgeInsets.symmetric(vertical: 8),
//                     ),
//                     SliverToBoxAdapter(
//                       child: Center(
//                         child: Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(500),
//                             color: Color.fromRGBO(234, 240, 252, 1),
//                           ),
//                           padding: EdgeInsets.symmetric(
//                             vertical: 8,
//                             horizontal: 24,
//                           ),
//                           margin: EdgeInsets.only(bottom: 24),
//
//                           child: PhoneText(
//                             text: state.getMeData.data!.data!.phone!,
//                           ),
//                         ),
//                       ),
//                     ),
//                     SliverToBoxAdapter(
//                       child: Container(
//                         padding: EdgeInsets.symmetric(vertical: 16),
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             color: context.textFieldBorder,
//                             width: 1,
//                           ),
//                           borderRadius: BorderRadius.circular(16),
//                         ),
//                         child: Column(
//                           children: [
//                             ListTileDivider(
//                               title: LocaleKeys.profilePersonalInformation.tr(),
//                               svgIcon: Assets.images.svg.navBar.accountIcon,
//                               onTap: () {
//                                 context.pushNamed(
//                                   RouteName.personalInformation,
//                                   arguments: PersonalInformationParams(
//                                     userBloc: userBloc,
//                                   ),
//                                 );
//                               },
//                               color: context.primarySwatch,
//                               hasDivider: true,
//                             ),
//
//                             ListTileDivider(
//                               title: LocaleKeys.carMyCars.tr(),
//                               svgIcon: Assets.images.svg.navBar.carIcon,
//                               onTap: () {
//                                 context.pushNamed(
//                                   RouteName.userCars,
//                                   arguments: UserCarsParams(isInOrder: false),
//                                 );
//                               },
//                               color: context.carProfileColor,
//                               hasDivider: true,
//                             ),
//
//                             ListTileDivider(
//                               title: LocaleKeys.profileLanguage.tr(),
//                               svgIcon: Assets.images.svg.profile.languageIcon,
//                               onTap: () async {
//                                 FocusScope.of(context).unfocus();
//                                 buildLangSheet(context);
//                               },
//                               color: context.langColor,
//                               hasDivider: true,
//                             ),
//                             ListTileDivider(
//                               title: LocaleKeys.profileShareThisLing.tr(),
//                               svgIcon: Assets.images.svg.profile.shareIcon,
//                               color: context.shareColor,
//
//                               onTap: () {
//                                 // FocusScope.of(context).unfocus();
//                                 // buildLangSheet(context);
//                               },
//                               hasDivider: true,
//                             ),
//                             ListTileDivider(
//                               title: LocaleKeys.profileAppVersion.tr(),
//                               svgIcon: Assets.images.svg.profile.versionIcon,
//                               color: context.versionColor,
//                               onTap: () {},
//                               hasDivider: true,
//                               isNext: false,
//                             ),
//                             ListTileLogOutWidget(),
//                           ],
//                         ),
//                       ),
//                     ),
//
//                     /////
//                   ],
//                 ),
//               );
//             },
//
//             onTapRetry: () => userBloc..add(UserGetMeEvent()),
//           ),
//         );
//       },
//     );
//   }
//
//   Future<void> _handlePhotosPermission({
//     required BuildContext context,
//     required PermissionCubit permissionCubit,
//     required ValueNotifier<File?> valueNotifier,
//   }) async {
//
//     await permissionCubit.checkInitialPermissions();
//     final status = permissionCubit.state.photosPermission;
//
//     if (status.isGranted || status.isLimited) {
//       valueNotifier.value =
//       await getIt<ImageProviderHelper>().pickImageFromGallery();
//       return;
//     }
//
//     if (status.isPermanentlyDenied) {
//       await openAppSettings();
//       await permissionCubit.checkInitialPermissions();
//       return;
//     }
//
//     final newStatus = await permissionCubit.requestPhotosPermission();
//
//     if (newStatus.isGranted || newStatus.isLimited) {
//       valueNotifier.value =
//       await getIt<ImageProviderHelper>().pickImageFromGallery();
//     }
//   }
//
// }
