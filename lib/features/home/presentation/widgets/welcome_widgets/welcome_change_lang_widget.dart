
import 'package:flutter/material.dart';
import 'package:restaurants_menu/common/design/src/widgets/animation_widget/animated_scale_widget.dart';
import 'package:restaurants_menu/features/home/presentation/widgets/welcome_widgets/const_left_to_right_widget.dart';
import 'package:restaurants_menu/router/app_router.dart';

import '../../../../../common/design/src/theme/const.dart';
import '../../../../../common/extensions/src/context_extensions.dart';
import '../../../../../common/helper/helper.dart';

class WelcomeChangeLangWidget extends StatelessWidget {
  const WelcomeChangeLangWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ConstLeftToRightWidget(
          child: Row(
            children: [
              Expanded(
                child: AnimatedScaleWidget(
                  child: ElevatedButton(
                    onPressed: () {
                      context.setLocale(const Locale('en'));
                      AppVariables.setCurrentLang(context);
                      HelperFunc.changeLang();
                      context.pushNamed(RouteName.home);

                    },
                    child: Text(
                      "English",
                      style: context.bodyLarge(
                        fontSize: 20,
                        color:  context.scaffoldBackgroundColor,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(width: context.width * .05),
              Expanded(
                child: AnimatedScaleWidget(
                  child: ElevatedButton(
                    onPressed: () {
                      context.setLocale(const Locale('ar'));
                      AppVariables.setCurrentLang(context);
                      HelperFunc.changeLang();
                      context.pushNamed(RouteName.home);
                    },
                    child: Text(
                      "العربية",
                      style: context.bodyLarge(
                        fontSize: 20,
                        color: context.scaffoldBackgroundColor,
                      ),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
        Space.vS3,
        Space.vS2,
        AnimatedScaleWidget(
          child: Container(
            width:
    (context.isDesktop
    ? context.width * .4
        : context.isTablet
    ? context.width * .7
        : context.width)*.5 ,
            child: ElevatedButton(
              onPressed: () {
                context.setLocale(const Locale('fa'));
                AppVariables.setCurrentLang(context);
                HelperFunc.changeLang();
                context.pushNamed(RouteName.home);
              },
              child: Text(
                "ܟܘܪܕܝܐ",
                style: context.bodyLarge(
                  fontSize: 20,
                  color:  context.scaffoldBackgroundColor,
                ),
              ),
            ),
          ),
        ),

      ],
    );
  }
}
