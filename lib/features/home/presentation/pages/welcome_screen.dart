import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurants_menu/common/design/design.dart';
import 'package:restaurants_menu/common/design/src/widgets/animation_widget/animated_title_text_widget.dart';
import 'package:restaurants_menu/common/extensions/src/description_extensions.dart';
import 'package:restaurants_menu/common/helper/helper.dart';
import 'package:restaurants_menu/core/di/injection.dart';
import 'package:restaurants_menu/features/user/presentation/bloc/user_bloc.dart';
import '../../../../common/design/src/widgets/animation_widget/animated_sub_text_widget.dart';
import '../../../../common/extensions/src/context_extensions.dart';
import '../widgets/profile_video_widget.dart';
import '../widgets/welcome_widgets/welcome_change_lang_widget.dart';
import '../widgets/welcome_widgets/welcome_contact_us_widget.dart';
import 'package:restaurants_menu/common/design/src/theme/theme/theme_notifier.dart';
import '../widgets/welcome_widgets/welcome_rate_us_widget.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final UserBloc userBloc = getIt<UserBloc>()..add(UserGetMeEvent());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldExit = await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              insetPadding: const EdgeInsets.symmetric(horizontal: 20),
              contentPadding: const EdgeInsets.all(24),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    LocaleKeys.exitConfirmationTitle.tr(),
                    style: context.headlineSmall(fontSize: 18),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 16),
                    child: Text(
                      LocaleKeys.exitConfirmationMessage.tr(),
                      style: context.bodyMedium(
                        fontSize: 14,
                        color: context.textColor,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: BorderSide(
                              width: 1,
                              color: context.primarySwatch,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                          child: Text(
                            LocaleKeys.exitConfirmationBack.tr(),
                            style: context.bodyMedium(fontSize: 14),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          },
                          child: Text(
                            LocaleKeys.exitConfirmationExit.tr(),

                            style: context.bodyMedium(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );

        return shouldExit ?? false;
      },
      child: Scaffold(
        body: Stack(
          children: [
            /// الخلفية (فيديو أو صورة أو صورة افتراضية)
            Positioned.fill(
              child: Builder(
                builder: (_) {
                  final media = AppVariables.user?.restaurant?.media;

                  if (media?.profileVideo != null &&
                      media!.profileVideo!.isNotEmpty) {
                    return ProfileVideoWidget(videoUrl: media.profileVideo!);
                  }

                  if (media?.coverImage != null &&
                      media!.coverImage!.isNotEmpty) {
                    return Image(
                      image: CachedNetworkImageProvider(media.coverImage!),
                      fit: BoxFit.cover,
                    );
                  }

                  return Image(
                    image: Assets.images.png.logIn.logIn.provider(),
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),

            /// التدرج الأسود فوق الخلفية
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment(0, -0.2),
                    radius: 1.2,
                    colors: [
                      Color.fromRGBO(0, 0, 0, 0.75),
                      Color.fromRGBO(0, 0, 0, 0.15),
                      Colors.transparent,
                    ],
                    stops: [0.0, 0.6, 1.0],
                  ),
                ),
              ),
            ),

            /// المحتوى
            BlocBuilder<UserBloc, UserState>(
              bloc: userBloc,
              buildWhen: (pre,cur)=>pre.getMeData.status!=cur.getMeData.status,
              builder: (context, state) {
                return SafeArea(
                  child: Column(
                    children: [
                      Expanded(
                        child: Center(
                          child: SingleChildScrollView(
                            child: Container(
                              width: context.isDesktop
                                  ? context.width * .4
                                  : context.isTablet
                                  ? context.width * .7
                                  : context.width,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              // decoration: BoxDecoration(
                              //   borderRadius: BorderRadius.circular(16),
                              //   boxShadow: const [
                              //     BoxShadow(
                              //       color: Color.fromRGBO(0, 0, 0, 0.08),
                              //       offset: Offset(0, 4),
                              //       blurRadius: 12,
                              //     ),
                              //   ],
                              // ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                  bottom: context.navigationBarHeight + 8,
                                  top: context.statusBarHeight,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    AppVariables
                                                .user
                                                ?.restaurant
                                                ?.media
                                                ?.logo ==
                                            null
                                        ? Assets.images.png.logo.image(
                                            height: 90,
                                          )
                                        : CacheNetworkImage(
                                            imageUrl: AppVariables
                                                .user!
                                                .restaurant!
                                                .media!
                                                .logo!,
                                            height: 90,
                                            width: 90,
                                          ),

                                    AnimatedTitleTextWidget(
                                      child: Text(
                                        AppVariables
                                                .user
                                                ?.restaurant
                                                ?.nameTranslations
                                                .getName(
                                                  emptyText: LocaleKeys
                                                      .welcomeWelcomeTitle
                                                      .tr(),
                                                ) ??
                                            LocaleKeys.welcomeWelcomeTitle.tr(),
                                        softWrap: true,
                                        textAlign: TextAlign.center,
                                        style: context.headlineSmall(
                                          fontSize: 34,
                                          color: context.primarySwatch,
                                        ),
                                      ),
                                    ),

                                    Space.vM1,

                                    AnimatedSubTextWidget(
                                      child: Text(
                                        AppVariables
                                                .user
                                                ?.restaurant
                                                ?.descriptionTranslations
                                                .getName(
                                                  emptyText: LocaleKeys
                                                      .welcomeWelcomeSubTitle
                                                      .tr(),
                                                ) ??
                                            LocaleKeys.welcomeWelcomeSubTitle
                                                .tr(),
                                        textAlign: TextAlign.center,
                                        style: context.headlineSmall(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),

                                    Space.vM1,

                                    WelcomeChangeLangWidget(),

                                    Space.vM1,

                                    WelcomeRateUsWidget(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      WelcomeContactUsWidget(),
                      Space.vM1,
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
