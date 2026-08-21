import 'package:flutter/material.dart';
import 'package:restaurants_menu/common/design/design.dart';
import '../../../../../common/extensions/src/context_extensions.dart';
import '../../../../../common/helper/src/app_launcher.dart';
import '../../../../../common/helper/src/app_varibles.dart';

class WelcomeContactUsWidget extends StatelessWidget {
  const WelcomeContactUsWidget({super.key});

  bool _isValidUrl(String? value) {
    if (value == null || value.trim().isEmpty) {
      return false;
    }

    final uri = Uri.tryParse(value.trim());

    return uri != null &&
        (uri.scheme == 'http' || uri.scheme == 'https') &&
        uri.host.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final facebookUrl = AppVariables.user?.restaurant?.facebookUrl;
    final instagramUrl = AppVariables.user?.restaurant?.instagramUrl;
    final whatsappNumber = AppVariables.user?.restaurant?.whatsappNumber;
    final telegramUrl = AppVariables.user?.restaurant?.telegramUrl;

    print(facebookUrl);
    print(facebookUrl);
    print(instagramUrl);
    print(whatsappNumber);
    print(telegramUrl);
    final List<Widget> contactItems = [];

    if (_isValidUrl(facebookUrl)) {
      contactItems.add(
        ContactUsElement(
          svgImage: Assets.images.svg.contactUs.facebook,
          onTap: () {
            AppLauncher.launchLink(facebookUrl);
          },
        ),
      );
    }

    if (_isValidUrl(instagramUrl)) {
      contactItems.add(
        ContactUsElement(
          svgImage: Assets.images.svg.welcome.instagram,
          onTap: () {
            AppLauncher.launchLink(instagramUrl);
          },
        ),
      );
    }

    if (whatsappNumber != null && whatsappNumber.trim().isNotEmpty) {
      contactItems.add(
        ContactUsElement(
          svgImage: Assets.images.svg.contactUs.whatsApp,
          onTap: () {
            AppLauncher.launchWhatsapp(whatsappNumber);
          },
        ),
      );
    }

    if (_isValidUrl(telegramUrl)) {
      contactItems.add(
        ContactUsElement(
          svgImage: Assets.images.svg.contactUs.wep,
          onTap: () {
            AppLauncher.launchLink(telegramUrl);
          },
        ),
      );
    }

    if (contactItems.isEmpty) {
      return const SizedBox.shrink();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < contactItems.length; i++) ...[
          if (i > 0) Space.hM1,
          contactItems[i],
        ],
      ],
    );
  }
}

class ContactUsElement extends StatelessWidget {
  final GestureTapCallback onTap;
  final String svgImage;

  const ContactUsElement({
    super.key,
    required this.onTap,
    required this.svgImage,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFF2A180C).withOpacity(0.80),
          shape: BoxShape.circle,
          border: Border.all(
            color: context.primarySwatch,
          ),
        ),
        child: SvgAsset(
          svgImage,
          color: Colors.white,
        ),
      ),
    );
  }
}