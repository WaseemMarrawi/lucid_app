// import 'package:evowash_user_flutter_app/common/design/src/widgets/my_custom_widget/my_custom_scaffold.dart';
// import 'package:evowash_user_flutter_app/common/extensions/extensions.dart';
// import 'package:evowash_user_flutter_app/common/helper/helper.dart';
// import 'package:evowash_user_flutter_app/core/di/injection.dart';
// import 'package:evowash_user_flutter_app/features/user/domain/use_cases/user_update_me_use_cases.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../../../common/design/src/theme/assets.gen.dart';
// import '../../../../common/design/src/theme/theme/theme_notifier.dart';
// import '../../../../common/design/src/widgets/app_text_field.dart';
// import '../../../../common/design/src/widgets/my_custom_widget/back_widget.dart';
// import '../../../../common/design/src/widgets/my_custom_widget/phone_field_with_validation.dart';
// import '../../../../common/helper/src/locale_keys.dart';
// import '../../../auth/presentation/widgets/check_widget.dart';
// import '../bloc/user_bloc.dart';
//
// class PersonalInformationScreen extends StatefulWidget {
//
//   final PersonalInformationParams arg;
//
//   const PersonalInformationScreen({super.key, required this.arg});
//
//   @override
//   State<PersonalInformationScreen> createState() =>
//       _PersonalInformationScreenState();
// }
//
// class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
//   late final TextEditingController firstNameController;
//   late final TextEditingController lastNameController;
//   late final TextEditingController phoneController;
//   late final GlobalKey<FormState> _globalKey;
//   late final UserBloc userBloc;
//   late final ValueNotifier<String>? phoneFiledValue;
//   late final ValueNotifier<bool> valueNotifier;
//   late final ValueNotifier<String> selectedGenderNotifier;
//   final FocusNode firstNameFocus = FocusNode();
//   final FocusNode lastNameFocus = FocusNode();
//   final FocusNode phoneFocus = FocusNode();
//
//   @override
//   void initState() {
//     firstNameController = TextEditingController(
//       text: AppVariables.user.firstName,
//     );
//     lastNameController = TextEditingController(
//       text: AppVariables.user.lastName,
//     );
//     phoneController = TextEditingController();
//     // passwordController = TextEditingController(
//     //   text: AppVariables.user
//     // );
//     _globalKey = GlobalKey<FormState>();
//     valueNotifier = ValueNotifier(false);
//     phoneFiledValue = ValueNotifier(AppVariables.user.phone!);
//     selectedGenderNotifier = ValueNotifier(AppVariables.user.gender!);
//     userBloc = widget.arg.userBloc;
//
//     // TODO: implement initState
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<UserBloc, UserState>(
//       bloc: userBloc,
//       builder: (context, state) {
//         return MyCustomScaffold(
//           top: 10,
//           body: Form(
//             key: _globalKey,
//             child: SingleChildScrollView(
//               child: ValueListenableBuilder(
//                 valueListenable: valueNotifier,
//                 builder: (context, value, chiled) {
//                   return Column(
//                     children: [
//                       Row(
//                         children: [
//                           BackWidget(),
//                           SizedBox(width: 8),
//                           Text(
//                             LocaleKeys.navBarProfile.tr(),
//                             style: context.labelSmall(
//                               fontSize: 24,
//                               fontFamily: "Nasaq",
//                             ),
//                           ),
//                           Spacer(),
//                           CustomEditButtonIcon(
//                             svg: value == true
//                                 ? Assets.images.svg.profile.checkIcon
//                                 : Assets.images.svg.profile.editIcon,
//                             onTap: () {
//                               if (valueNotifier.value == true) {
//                                 userBloc.add(
//                                   UserUpdateMeEvent(
//                                     params: UserUpdateMeParams(
//                                         firstName: firstNameController.text,
//                                         lastName: lastNameController.text,
//                                         phone: phoneFiledValue!.value,
//                                         gender: selectedGenderNotifier.value
//                                     ),
//                                   ),
//                                 );
//                               } else {
//                                 valueNotifier.value = true;
//                               }
//                             },
//                             color: value == true
//                                 ? context.primarySwatch
//                                 : Colors.white,
//                             svgColor: value == true ? Colors.white : null,
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 38),
//                       MyAppTextField(
//                         isPadding: false,
//                         labelText: LocaleKeys.profileFirstNameEdit.tr(),
//                         controller: firstNameController,
//                         validator: (text) => text.isNotShortText,
//                         keyboardType: TextInputType.name,
//                         enabled: value,
//                         focus: firstNameFocus,
//                         textInputAction: TextInputAction.next,
//                         onSubmitted: (_) {
//                           FocusScope.of(context).requestFocus(lastNameFocus);
//                         },
//                       ),
//                       SizedBox(height: 16),
//                       MyAppTextField(
//                         isPadding: false,
//                         labelText: LocaleKeys.profileLastNameEdit.tr(),
//                         controller: lastNameController,
//                         // validator: (text) => text.isNotShortTextPhone,
//                         keyboardType: TextInputType.name,
//                         enabled: value,
//                         focus: lastNameFocus,
//                         textInputAction: TextInputAction.next,
//                         onSubmitted: (_) {
//                           FocusScope.of(context).requestFocus(phoneFocus);
//                         },
//                       ),
//                       SizedBox(height: 16),
//                       MyPhoneNumberField(
//                         controller: phoneController,
//                         labelText: LocaleKeys.authEnterPhone.tr(),
//                         isMargin: false,
//                         readOnly: !value,
//                         internationalPhoneValue: phoneFiledValue,
//
//                         focusNode: phoneFocus,
//                         textInputAction: TextInputAction.done,
//
//                       ),
//                       SizedBox(height: context.height * .01),
//                       Row(
//                         children: [
//                           CheckWidget(
//                             selectedGenderNotifier: selectedGenderNotifier,
//                             title: LocaleKeys.authMale.tr(),
//                             value: 'male',
//                             isEnable: value,
//                           ),
//
//                           SizedBox(width: 16),
//                           CheckWidget(
//                             selectedGenderNotifier: selectedGenderNotifier,
//                             title: LocaleKeys.authFemale.tr(),
//                             value: 'female',
//                             isEnable: value,
//
//                           ),
//                         ],
//                       ),
//                       // MyAppTextField(
//                       //   enabled: value,
//                       //   isPadding: false,
//                       //   labelText: LocaleKeys.authPassword.tr(),
//                       //   controller: passwordController,
//                       //   validator: (text) => text.validatePassword,
//                       //   keyboardType: TextInputType.visiblePassword,
//                       //   isPassword: true,
//                       // ),
//                     ],
//                   );
//                 },
//               ),
//             ),
//           ),
//         );
//       },
//       listenWhen: (pre, next) =>
//       pre.updateMeData.status != next.updateMeData.status,
//       listener: (context, state) {
//         state.updateMeData.listenerFunction(onSuccess: () {
//           // userBloc.add(UserGetMeEvent());
//
//           context.read<AppThemeNotifier>().setTheme(
//             AppVariables.user.gender == 'female'
//                 ? AppThemeType.female
//                 : AppThemeType.male,
//           );
//           context.pop();
//         });
//       },
//     );
//   }
// }
//
//
// class PersonalInformationParams {
//   final UserBloc userBloc;
//
//   PersonalInformationParams({required this.userBloc});
// }