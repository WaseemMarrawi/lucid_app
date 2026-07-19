import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurants_menu/common/design/design.dart';
import '../../../../common/extensions/src/context_extensions.dart';
import '../../../../common/extensions/src/validation.dart';
import '../../../../common/helper/src/locale_keys.dart';
import '../../../../core/di/injection.dart';
import '../../../../router/app_router.dart';
import '../../domain/use_cases/login_use_case.dart';
import '../bloc/auth_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final AuthBloc authBloc;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  late final FocusNode emailFocusNode;

  late final FocusNode passwordFocusNode;

  late final ValueNotifier<String?> signature;

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,

        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
    authBloc = getIt<AuthBloc>();
    passwordController = TextEditingController();
    emailController = TextEditingController();

    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    signature = ValueNotifier(null);

    super.initState();
  }

  @override
  void dispose() {
    authBloc.close();
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  void _login() {
    if (!(_globalKey.currentState?.validate() ?? false)) return;

    authBloc.add(
      LoginEvent(
        params: LoginParams(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      bloc: authBloc,
      listenWhen: (pre, cur) => pre.loginData.status != cur.loginData.status,
      listener: (context, state) {
        state.loginData.listenerFunction(
          onSuccess: () {
            context.pushNamedAndRemoveUntil(RouteName.welcome, (e) => false);
          },
        );
      },
      child: Scaffold(
        backgroundColor: context.scaffoldBackgroundColor,
        body: Container(
          width: double.infinity,
          height: double.infinity,

          // padding: EdgeInsets.only(
          //   bottom: context.navigationBarHeight,
          //   top: context.statusBarHeight,
          // ),

          // 🔥 الخلفية (الصورة فقط)
          decoration: BoxDecoration(
            // image: DecorationImage(
            //   image: Assets.images.png.logIn.logIn.provider(),
            //   fit: BoxFit.cover,
            // ),
          ),

          child: Container(
            // 🔥 طبقة الـ gradient فوق الصورة
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(0, 0.2),
                radius: 1.2,
                colors: [
                  Color.fromRGBO(0, 0, 0, 0.75),
                  Color.fromRGBO(0, 0, 0, 0.15),
                  Colors.transparent,
                ],
                stops: [0.0, 0.6, 1.0],
              ),
            ),

            child: Container(
              padding: EdgeInsets.only(
                bottom: context.navigationBarHeight,
                top: context.statusBarHeight,
              ),
              child: Center(
                child: SingleChildScrollView(
                  child: Container(
                    width: context.isDesktop
                        ? context.width * .4
                        : context.isTablet
                        ? context.width * .7
                        : double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.all(16),

                    decoration: BoxDecoration(
                      color:context.scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.08),
                          offset: Offset(0, 4),
                          blurRadius: 12,
                        ),
                      ],
                    ),

                    child: Form(
                      key: _globalKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [



                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Text(
                                "lucid",
                                style: context.headlineSmall(
                                  fontSize: 28,
                                  color:Color(0xFF242628),
                                  fontFamily: AppFontFamily.comfortaa
                                ),
                              ),


                              const SizedBox(width: 12),
                              // Assets.images.png.logo.image(
                              //     height: 40
                              // ),
                              SvgAsset(Assets.images.svg.logo,height: 40)
                            ],
                          ),

                          Space.vM4,

                          Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Text(
                              LocaleKeys.authUserEmail.tr(),
                              style: context.headlineSmall(
                                color: context.hintColor,
                                fontSize: 12,
                              ),
                            ),
                          ),

                          Space.vS3,

                          MyAppTextField(
                            textInputAction: TextInputAction.next,
                            isPadding: false,
                            fillColor: context.scaffoldBackgroundColor,
                            controller: emailController,
                            validator: (text) => text.isValidEmail,
                            keyboardType: TextInputType.emailAddress,
                            focus: emailFocusNode,
                            onSubmitted: (_) {
                              FocusScope.of(
                                context,
                              ).requestFocus(passwordFocusNode);
                            },
                          ),

                          Space.vM4,

                          Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Text(
                              LocaleKeys.authPassword.tr(),
                              style: context.headlineSmall(
                                color: context.hintColor,
                                fontSize: 12,
                              ),
                            ),
                          ),

                          Space.vS3,

                          MyAppTextField(
                            textInputAction: TextInputAction.done,
                            isPadding: false,
                            fillColor: context.scaffoldBackgroundColor,

                            controller: passwordController,
                            validator: (text) => text.validatePassword,
                            keyboardType: TextInputType.visiblePassword,
                            focus: passwordFocusNode,
                            isPassword: true,
                            onSubmitted: (_) {
                              passwordFocusNode.unfocus();
                            },
                          ),

                          Space.vM4,

                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _login,
                              child: Text(
                                LocaleKeys.authLogIn.tr(),
                                style: context.bodyLarge(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
