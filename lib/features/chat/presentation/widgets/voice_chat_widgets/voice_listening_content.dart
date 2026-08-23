import 'package:flutter/material.dart';

import '../../../../../common/extensions/src/context_extensions.dart';
import '../../../../../common/helper/src/locale_keys.dart';
import 'voice_back_button.dart';
import 'voice_circle_icon.dart';

class VoiceListeningContent extends StatelessWidget {
  const VoiceListeningContent({
    required this.onClose,
    required this.animation,
    super.key,
  });

  final VoidCallback onClose;

  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return Row(
      key: const ValueKey('voice_listening'),
      mainAxisSize: MainAxisSize.min,
      children: [
        VoiceCircleIcon(
          icon: Icons.mic_rounded,
          isRecording: true,
          animation: animation,
        ),
        const SizedBox(width: 12),
        Text(
          LocaleKeys.audioRecording.tr(),
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