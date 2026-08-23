import 'package:flutter/material.dart';

import '../../../../../common/extensions/src/context_extensions.dart';
import '../../../../../common/helper/src/locale_keys.dart';
import 'voice_back_button.dart';
import 'voice_circle_icon.dart';

class VoiceFailedContent extends StatelessWidget {
  const VoiceFailedContent({
    required this.onRetry,
    required this.onClose,
    super.key,
  });

  final VoidCallback onRetry;

  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Row(
      key: const ValueKey('voice_failed'),
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onRetry,
          child: const VoiceCircleIcon(
            icon: Icons.refresh_rounded,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          LocaleKeys.retryChat.tr(),
          style: context.bodyMedium(
            color: context.cardColor,
          ),
        ),
        const SizedBox(width: 12),
        VoiceBackButton(
          onTap: onClose,
        ),
      ],
    );
  }
}