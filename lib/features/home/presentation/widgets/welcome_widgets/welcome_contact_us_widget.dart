
import 'package:flutter/material.dart';

import '../../../../../common/design/src/theme/assets.gen.dart';
import '../../../../../common/design/src/theme/const.dart';
import '../../../../../common/extensions/src/context_extensions.dart';
import '../../../../../common/helper/src/app_launcher.dart';
import '../../../../../common/helper/src/app_varibles.dart';
import '../../../../../common/helper/src/locale_keys.dart';

class WelcomeContactUsWidget extends StatelessWidget {
  const WelcomeContactUsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return                     Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: (){
            AppLauncher.launchLink(
              AppVariables.user?.restaurant?.facebookUrl,
            );
          },
          child: Assets.images.png.welcome.facebook.image(
            height: 45,
            width: 45,
          ),
        ),
        Space.hM1,
        InkWell(
          onTap: (){
            AppLauncher.launchLink(
              AppVariables.user?.restaurant?.instagramUrl,
            );
          },
          child: Assets.images.png.welcome.instgram.image(
            height: 45,
            width: 45,
          ),
        ),
        Space.hM1,

        InkWell(
          onTap: (){
            AppLauncher.launchWhatsapp(
              AppVariables.user?.restaurant?.whatsappNumber,
            );
          },
          child: Assets.images.png.welcome.whats.image(
            height: 45,
            width: 45,
          ),
        ),
        Space.hM1,

        InkWell(
          onTap: (){
            AppLauncher.launchLink(
              AppVariables.user?.restaurant?.telegramUrl,
            );
          },
          child: Assets.images.png.welcome.telegram.image(
            height: 45,
            width: 45,
          ),
        ),
      ],
    );
  }
}
