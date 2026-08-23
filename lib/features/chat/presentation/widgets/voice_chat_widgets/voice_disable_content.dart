import 'package:flutter/material.dart';

import '../../../../../common/design/src/theme/assets.gen.dart';
import '../../../../../common/extensions/src/context_extensions.dart';

class VoiceDisableContent extends StatelessWidget {
  const VoiceDisableContent({
    required this.onTap,
    super.key,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: const ValueKey('voice_disable'),
      onTap: onTap,
      child: Assets.images.png.robot.image(
        height: 30,
        color: context.cardColor,
      ),
    );
  }
}