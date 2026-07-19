//
// import 'package:evowash_user_flutter_app/common/extensions/extensions.dart';
// import 'package:evowash_user_flutter_app/features/auth/presentation/pages/sign_up_name_screen.dart';
// import 'package:evowash_user_flutter_app/features/auth/presentation/widgets/sign_up_widget.dart';
// import 'package:flutter/material.dart';
// import '../../../../common/design/src/theme/assets.gen.dart';
// import '../../../../common/design/src/widgets/app_text_field.dart';
// import '../../../../common/design/src/widgets/my_custom_widget/my_custom_drop_down_widget.dart';
// import '../../../../common/design/src/widgets/svg_asset.dart';
// import '../../../../common/helper/src/locale_keys.dart';
//
// class SignUpBody extends StatefulWidget {
//
//   @override
//   State<SignUpBody> createState() => _SignupBodyState();
// }
//
// class _SignupBodyState extends State<SignUpBody> {
//
//   @override
//   Widget build(BuildContext context) {
//     return ;
//
//       Scaffold(
//       // appBar: AppBar(
//       //   leading: const CustomLeadingBlack(),
//       //   backgroundColor: Colors.transparent,
//       //   title: GradiantTextWidget(
//       //     title: LocaleKeys.authCreateNewAccount.tr(),
//       //     fontSize: 22,
//       //     fontWeight: FontWeight.bold,
//       //   ),
//       //   centerTitle: true,
//       // ),
//       body: Form(
//         key: _globalKey2,
//         child: Padding(
//           padding: EdgeInsetsDirectional.only(
//             start: context.width * .05,
//             end: context.width * .05,
//           ),
//           child: CustomScrollView(
//             slivers: [
//               SliverToBoxAdapter(
//                 child: SubTitleWidget(
//                   subTitle: LocaleKeys.authHelloInLaqta.tr(),
//                 ),
//               ),
//               SliverToBoxAdapter(
//                 child: Padding(
//                   padding: EdgeInsets.only(bottom: context.height * .02),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: MyAppTextField(
//                           isPadding: false,
//
//                           hintText: LocaleKeys.authFirstName.tr(),
//                           controller: firstNameController,
//                           validator: (text) => text.isNotShortText,
//                           keyboardType: TextInputType.name,
//                         ),
//                       ),
//                       SizedBox(width: context.width * .04),
//                       Expanded(
//                         child: MyAppTextField(
//                           isPadding: false,
//                           // prefixIcon: Transform.scale(
//                           //   scale: .7,
//                           //   child: SvgAsset(Assets.images.svg.login),
//                           // ),
//
//                           hintText: LocaleKeys.authLastName.tr(),
//                           controller: lastNameController,
//                           validator: (text) => text.isNotShortText,
//                           keyboardType: TextInputType.name,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SliverToBoxAdapter(
//                 child: Padding(
//                   padding: EdgeInsets.only(bottom: context.height * .02),
//                   child: MyAppTextField(
//                     isPadding: false,
//                     prefixIcon: Icon(
//                       Icons.mail_outline_outlined,
//                       color: context.primarySwatch,
//                       size: 20,
//                     ),
//                     hintText: LocaleKeys.authEnterEmail.tr(),
//                     controller: emailController,
//                     validator: (text) => text.isValidEmail,
//                     keyboardType: TextInputType.emailAddress,
//
//                   ),
//                 ),
//               ),
//               SliverToBoxAdapter(
//                 child: Padding(
//                   padding: EdgeInsets.only(bottom: context.height * .02),
//
//                   child:ValueListenableBuilder<String?>(
//                     valueListenable: genderValue,
//
//                     builder: (context,value,child){
//                       return  MyCustomDropDownWidget<String>(
//                         value: value,
//                         fun: (String? value) {
//                           // tabCat = true;
//                           // categoryBloc.add(
//                           //     SelectCategoryEvent(
//                           //         category: category));
//                           genderValue.value=value;
//
//                         },
//                         getString: (String value) {
//                           return value;
//                         },
//                         list:  genderList ,
//                         hint: LocaleKeys.authGender.tr(),
//                         prefixIcon: Icon(
//                           Icons.male_outlined,
//                           color: context.primarySwatch,
//                           size: 20,
//                         ),
//                       );
//                     },
//                   ),
//
//                   // MyAppTextField(
//                   //   isPadding: false,
//                   //   prefixIcon: Icon(
//                   //     Icons.male_outlined,
//                   //     color: context.primarySwatch,
//                   //     size: 20,
//                   //   ),
//                   //   hintText: LocaleKeys.authGender.tr(),
//                   //   controller: genderController,
//                   //   // validator:
//                   //   //     (text) =>
//                   //   //         text.isConfirmPassword(passwordController.text),
//                   //   validator: (text) => text.isNotShortText,
//                   //   keyboardType: TextInputType.name,
//                   // ),
//                 ),
//               ),
//               SliverToBoxAdapter(
//                 child: Padding(
//                   padding: EdgeInsets.only(bottom: context.height * .01),
//
//                   child: MyAppTextField(
//                     isPadding: false,
//                     prefixIcon: Icon(
//                       Icons.phone_outlined,
//                       color: context.primarySwatch,
//                       size: 20,
//                     ),
//                     hintText: LocaleKeys.authEnterPhone.tr(),
//                     controller: phoneController,
//                     validator: (text) => text.isNotShortTextPhone,
//                     keyboardType: TextInputType.phone,
//                     // onChanged: (val) {
//                     //   checkEight.value = val.length >= 8 ? true : false;
//                     //   checkContainNumber.value =
//                     //       val.contains(RegExp(r'\d')) ? true : false;
//                     // },
//                   ),
//                 ),
//               ),
//               // const PasswordShouldWidget(),
//               // CheckPasswordWidget(
//               //   checkEight: checkEight,
//               //   checkContainNumber: checkContainNumber,
//               // ),
//               PrivacyWidget(checkPrivacy: checkPrivacy),
//               // SliverToBoxAdapter(
//               //   child: CustomWidthBottomGradient(
//               //     text: LocaleKeys.authSignIn.tr(),
//               //     onTap: () {
//               //       if (_globalKey2.currentState?.validate() ?? false) {
//               //         // context.pushNamed(
//               //         //   RouteName.signupSetPassword,
//               //         //   arguments: SignUpSetPasswordScreenParam(
//               //         //     email: emailController.text,
//               //         //     firstName: firstNameController.text,
//               //         //     lastName: lastNameController.text,
//               //         //     gender: genderValue.value!,
//               //         //     phone: phoneController.text,
//               //         //   ),
//               //         // );
//               //
//               //         // widget.authBloc.add(SignupEvent(
//               //         //     params: SignUpParams(
//               //         //         firstName: firstNameController.text,
//               //         //         lastName: lastNameController.text,
//               //         //         phone: numberController.text)));
//               //       }
//               //     },
//               //   ),
//               // ),
//               const DontHaveAccount(),
//               // const SliverToBoxAdapter(child: SignOption()),
//               // SliverToBoxAdapter(
//               //   child: Padding(
//               //     padding: const EdgeInsets.only(top: 14.0),
//               //     child: GradientWidget(
//               //       width: double.infinity,
//               //       height: context.width * .15,
//               //       borderRadius: BorderRadius.circular(500),
//               //       isSecond: true,
//               //       child: Row(
//               //         mainAxisAlignment: MainAxisAlignment.center,
//               //         children: [
//               //           Text(
//               //             'Google',
//               //             style: context.textTheme.titleMedium!.copyWith(
//               //               fontSize: 15,
//               //               fontWeight: FontWeight.bold,
//               //             ),
//               //           ),
//               //           Padding(
//               //             padding: const EdgeInsetsDirectional.only(start: 6.0),
//               //
//               //             child: SvgAsset(Assets.images.svg.google),
//               //           ),
//               //         ],
//               //       ),
//               //     ),
//               //   ),
//               // ),
//               // SliverToBoxAdapter(
//               //   child: Padding(
//               //     padding: const EdgeInsets.only(top: 14.0),
//               //     child: Container(
//               //       width: double.infinity,
//               //       height: context.width * .15,
//               //       decoration: BoxDecoration(
//               //         borderRadius: BorderRadius.circular(500),
//               //         color: Colors.black,
//               //       ),
//               //
//               //       child: Row(
//               //         mainAxisAlignment: MainAxisAlignment.center,
//               //         children: [
//               //           Text(
//               //             'Apple',
//               //             style: context.textTheme.titleMedium!.copyWith(
//               //               fontSize: 15,
//               //               fontWeight: FontWeight.bold,
//               //             ),
//               //           ),
//               //           Padding(
//               //             padding: const EdgeInsetsDirectional.only(start: 6.0),
//               //
//               //             child: SvgAsset(Assets.images.svg.apple),
//               //           ),
//               //         ],
//               //       ),
//               //     ),
//               //   ),
//               // ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
