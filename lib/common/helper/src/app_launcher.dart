import 'package:url_launcher/url_launcher.dart';
import '../../design/src/theme/toaster.dart';
import 'locale_keys.dart';


class AppLauncher {
  const AppLauncher._();

  static Future<void> launchLink(String? url) async {
    if (url == null || url.trim().isEmpty) {
      _showError();
      return;
    }

    try {
      final uri = Uri.parse(url);

      final canLaunch = await canLaunchUrl(uri);

      if (!canLaunch) {
        _showError();
        return;
      }

      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    } catch (_) {
      _showError();
    }
  }

  static Future<void> launchWhatsapp(String? phone) async {
    if (phone == null || phone.trim().isEmpty) {
      _showError();
      return;
    }

    try {
      final cleanPhone = phone.replaceAll('+', '');

      final uri = Uri.parse(
        'https://wa.me/$cleanPhone',
      );

      final canLaunch = await canLaunchUrl(uri);

      if (!canLaunch) {
        _showError();
        return;
      }

      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    } catch (_) {
      _showError();
    }
  }

  static void _showError() {
    Toaster.showCustomErrorToast(
      message: LocaleKeys.linkInvalid.tr(),
    );
  }
}