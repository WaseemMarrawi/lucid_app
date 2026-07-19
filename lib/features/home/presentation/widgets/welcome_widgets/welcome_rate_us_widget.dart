import 'package:flutter/material.dart';
import 'package:restaurants_menu/common/design/src/widgets/animation_widget/animated_scale_widget.dart';
import 'package:restaurants_menu/router/app_router.dart';
import '../../../../../common/extensions/src/context_extensions.dart';
import '../../../../../common/helper/src/locale_keys.dart';

class WelcomeRateUsWidget extends StatelessWidget {
  const WelcomeRateUsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      child: AnimatedScaleWidget(
        child: OutlinedButton(
          onPressed: () {
            context.pushNamed(RouteName.rate);
          },
          style: OutlinedButton.styleFrom(
            backgroundColor: const Color(0xFF2A180C).withOpacity(0.80),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
        
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
          child: Text(
            LocaleKeys.welcomeRateResto.tr(),
            style: context.headlineSmall(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
