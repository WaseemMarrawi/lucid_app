// import 'dart:io';
// import 'dart:typed_data';
// import 'dart:ui';
// import 'package:evowash_user_flutter_app/common/design/src/widgets/my_custom_widget/back_widget.dart';
// import 'package:evowash_user_flutter_app/common/design/src/widgets/my_custom_widget/my_custom_buttons/solid_button_widget.dart';
// import 'package:evowash_user_flutter_app/common/design/src/widgets/my_custom_widget/my_custom_scaffold.dart';
// import 'package:evowash_user_flutter_app/common/extensions/extensions.dart';
// import 'package:evowash_user_flutter_app/features/user/domain/use_cases/user_update_profile_use_cases.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:permission_handler/permission_handler.dart';
// import '../../../../common/extensions/src/image_provider.dart';
// import '../../../../common/helper/src/locale_keys.dart';
// import '../../../../core/di/injection.dart';
// import '../../../../core/permissions/cubit/permissions_cubit.dart';
// import '../bloc/user_bloc.dart';
//
// class ChangePhotoScreen extends StatefulWidget {
//   final ChangePhotoScreenParams arg;
//
//   const ChangePhotoScreen({super.key, required this.arg});
//
//   @override
//   State<ChangePhotoScreen> createState() => _ChangePhotoScreenState();
// }
//
// class _ChangePhotoScreenState extends State<ChangePhotoScreen> {
//   late final PermissionCubit permissionCubit;
//
//   late final ValueNotifier<File?> valueNotifier;
//
//   // المفتاح لالتقاط صورة الـ widget
//
//   @override
//   void initState() {
//     super.initState();
//     permissionCubit = getIt<PermissionCubit>()..checkInitialPermissions();
//     valueNotifier = ValueNotifier(null);
//   }
//
//   @override
//   void dispose() {
//     valueNotifier.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MyCustomScaffold(
//       body: BlocListener<UserBloc, UserState>(
//         bloc: widget.arg.userBloc,
//         listenWhen: (pre, next) =>
//             pre.postProfileImageData.status != next.postProfileImageData.status,
//         listener: (context, state) {
//           state.postProfileImageData.listenerFunction(
//             onSuccess: () {
//               context.pop();
//             },
//           );
//         },
//         child: BlocBuilder<PermissionCubit, PermissionState>(
//           bloc: permissionCubit,
//           builder: (context, state) {
//             return Column(
//               children: [
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     BackWidget(),
//                     SizedBox(width: 8),
//                     Text(
//                       LocaleKeys.profileEditPhoto.tr(),
//                       style: context.labelSmall(
//                         fontSize: 24,
//                         fontFamily: "Nasaq",
//                       ),
//                     ),
//                   ],
//                 ),
//                 Spacer(),
//                 GestureDetector(
//                   child: ValueListenableBuilder<File?>(
//                     valueListenable: valueNotifier,
//                     builder: (BuildContext context, value, Widget? child) {
//                       return Container(
//                         width: context.width,
//                         height: context.width - 20,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: context.textFieldHintColor,
//                         ),
//                         child: value == null
//                             ? const Icon(
//                                 Icons.image_outlined,
//                                 size: 40,
//                                 color: Color.fromRGBO(41, 45, 50, 1),
//                               )
//                             : ClipOval(
//                                 child: Image.file(value, fit: BoxFit.cover),
//                               ),
//                       );
//                     },
//                   ),
//                   onTap: () async {
//                     await _handlePhotosPermission(
//                       context: context,
//                       permissionCubit: permissionCubit,
//                       valueNotifier: valueNotifier,
//                     );
//                   },
//                 ),
//
//                 Padding(
//                   padding: const EdgeInsets.only(top: 36.0),
//                   child: SolidButtonWidget(
//                     onTap: () async {
//                       if (valueNotifier.value != null) {
//                         widget.arg.userBloc.add(
//                           UserUpdateProfileImageEvent(
//                             params: UserUpdateProfileImageParams(
//                               image: valueNotifier.value!,
//                             ),
//                           ),
//                         );
//                       }
//                     },
//                     widget: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 70),
//                       child: Text(
//                         LocaleKeys.profileSave.tr(),
//                         style: context.titleSmall(fontSize: 16),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Spacer(),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   Future<void> _handlePhotosPermission({
//     required BuildContext context,
//     required PermissionCubit permissionCubit,
//     required ValueNotifier<File?> valueNotifier,
//   })
//   async {
//     final currentStatus = permissionCubit.state.photosPermission;
//
//     if (currentStatus.isGranted || currentStatus.isLimited) {
//       print('Enter IsGranted');
//       valueNotifier.value = await getIt<ImageProviderHelper>()
//           .pickImageFromGallery();
//       return;
//     }
//
//     if (currentStatus.isPermanentlyDenied) {
//       print('Enter isPermanentlyDenied');
//       await openAppSettings();
//       await permissionCubit.checkInitialPermissions();
//       return;
//     }
//
//     print('Enter else → requesting permission');
//     print('Current: $currentStatus');
//
//     // ⏳ طلب الإذن
//     final newStatus = await permissionCubit.requestPhotosPermission();
//
//     // ✅ إذا تمت الموافقة، نفّذ اختيار الصورة
//     if (newStatus.isGranted || newStatus.isLimited) {
//       valueNotifier.value = await getIt<ImageProviderHelper>()
//           .pickImageFromGallery();
//     } else {
//       print('Permission denied or restricted');
//     }
//   }
// }
//
// class ChangePhotoScreenParams {
//   final UserBloc userBloc;
//
//   ChangePhotoScreenParams({required this.userBloc});
// }
