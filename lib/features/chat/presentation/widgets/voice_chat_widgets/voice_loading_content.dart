import 'package:flutter/material.dart';

import '../../../../../common/extensions/src/context_extensions.dart';
import '../../../../../common/helper/src/locale_keys.dart';
import 'voice_back_button.dart';

class VoiceLoadingContent extends StatelessWidget {
  const VoiceLoadingContent({
    required this.onClose,
    super.key,
  });

  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Row(
      key: const ValueKey('voice_loading'),
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: const SizedBox(
            width: 21,
            height: 21,
            child: CircularProgressIndicator(
              strokeWidth: 2.3,
              valueColor: AlwaysStoppedAnimation<Color>(
                Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          LocaleKeys.chatThinking.tr(),
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