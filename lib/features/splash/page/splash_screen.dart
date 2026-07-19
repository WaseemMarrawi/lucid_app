import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurants_menu/common/design/design.dart';
import '../../../common/design/src/theme/assets.gen.dart';
import '../../../common/extensions/src/context_extensions.dart';
import '../../../core/di/injection.dart';
import '../../../router/app_router.dart';
import 'cubit/splash_cubit.dart';
import 'show_version_dialog.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final SplashCubit splashCubit;

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );

    super.initState();
    splashCubit = getIt<SplashCubit>();

    Future.delayed(
      (Duration(seconds: 1)),
          () {
            splashCubit.checkNavigator();
      },
    );

  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        // BlocListener<SplashCubit, SplashState>(
        //   bloc: splashCubit,
        //   listenWhen:
        //       (previous, current) =>
        //           previous.getVersionData.status !=
        //           current.getVersionData.status,
        //   listener: (context, state) {
        //     if (state.getVersionData.isSuccess) {
        //       if (state.getVersionData.data!.updateRequired == true) {
        //         showVersionDialog(
        //           context: context,
        //           storeUrl: state.getVersionData.data?.storeUrl,
        //         );
        //       } else if (state.getVersionData.data!.updateAvailable == true &&
        //           state.getVersionData.data!.updateRequired == false) {
        //         showVersionDialogOptional(
        //           context: context,
        //           storeUrl: state.getVersionData.data?.storeUrl,
        //           after: () {
        //             splashCubit.checkNavigator();
        //           },
        //         );
        //       } else {
        //         Future.delayed(const Duration(seconds: 1)).then((value) {
        //           splashCubit.checkNavigator();
        //         });
        //       }
        //     }
        //   },
        // ),
        BlocListener<SplashCubit, SplashState>(
          bloc: splashCubit,
          listenWhen:
              (previous, current) =>
                  previous.splashStatus != current.splashStatus,
          listener: (context, state) {
            if (state.splashStatus == SplashStatus.isAuth) {
              context.pushReplacementNamed(RouteName.welcome);
            } else  {
              context.pushReplacementNamed(RouteName.login);

            }
          },
        ),
      ],

      child: Scaffold(
        body: Container(
          width: context.width,
          height: context.height,
          color: context.scaffoldBackgroundColor,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Center(

                child: Assets.images.png.splashLogo.image(

                  width: context.width*.7,

                  fit: BoxFit.cover,
                ),
              ),

              // Positioned(
              //   bottom: context.navigationBarHeight + context.height * .1,
              //   child: BlocBuilder<SplashCubit, SplashState>(
              //     bloc: splashCubit,
              //     builder: (context, state) {
              //       return state.getVersionData.builder(
              //         onSuccess: (_) {
              //           return const SizedBox();
              //         },
              //
              //         loadingWidget: CircularProgressIndicator(
              //           color: context.textSubColor,
              //         ),
              //
              //         failedWidget: SizedBox(
              //           width: context.width,
              //           child: Padding(
              //             padding: const EdgeInsets.symmetric(horizontal: 20),
              //             child: Column(
              //               children: [
              //                 IconButton(
              //                   onPressed: () {
              //                     splashCubit.checkVersion();
              //                   },
              //                   icon: Icon(
              //                     Icons.refresh,
              //                     color: Colors.white,
              //                     size: 50,
              //                   ),
              //                 ),
              //
              //                 Text(
              //                   state.getVersionData.errorMessage,
              //                   style: context.titleSmall(color: Colors.white),
              //                   softWrap: true,
              //                   textAlign: TextAlign.center,
              //                 ),
              //               ],
              //             ),
              //           ),
              //         ),
              //       );
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
