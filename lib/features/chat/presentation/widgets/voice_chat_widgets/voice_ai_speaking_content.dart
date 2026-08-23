import 'package:flutter/material.dart';

import '../../../../../common/extensions/src/context_extensions.dart';
import '../ai_wave_widget.dart';
import 'voice_back_button.dart';
import 'voice_circle_icon.dart';

class VoiceAiSpeakingContent extends StatelessWidget {
  const VoiceAiSpeakingContent({
    required this.onStop,
    required this.onClose,
    super.key,
  });

  final VoidCallback onStop;

  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Row(
      key: const ValueKey('voice_ai_speaking'),
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onStop,
          child: const VoiceCircleIcon(
            icon: Icons.stop_rounded,
          ),
        ),
        const SizedBox(width: 12),
        SizedBox(
          height: 45,
          width: context.width * .3,
          child: const AiWaveWidget(),
        ),
        const SizedBox(width: 8),
        VoiceBackButton(
          onTap: onClose,
        ),
      ],
    );
  }
}