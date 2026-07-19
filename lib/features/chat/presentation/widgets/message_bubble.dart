import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';

import '../../../../common/extensions/src/context_extensions.dart';

class MessageBubble extends StatelessWidget {
  final bool isMe;
  final bool isArabic;
  final Widget child;

  const MessageBubble({
    super.key,
    required this.isMe,
    required this.isArabic,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final double leftMargin =
    (isArabic && isMe) || (!isArabic && !isMe) ? 10 : 70;
    final double rightMargin =
    (isArabic && isMe) || (!isArabic && !isMe) ? 70 : 10;

    return Directionality(
      textDirection: isArabic ? TextDirection.ltr  :  TextDirection.rtl,
      child: Bubble(
        nip: isMe
            ? (isArabic ? BubbleNip.leftTop :   BubbleNip.rightTop)
            : (isArabic ? BubbleNip.rightTop :  BubbleNip.leftTop ),
        color: isMe
            ? const Color.fromRGBO(241, 241, 241, 1)
            : const Color.fromRGBO(239, 175, 135, 1),
        radius: const Radius.circular(15),
        padding: const BubbleEdges.symmetric(horizontal: 15, vertical: 10),
        margin: BubbleEdges.only(
          left: leftMargin,
          right: rightMargin,
          top: 5,
          bottom: 5,
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: context.width * 0.65, // أقصى عرض للفقاعة
          ),
          child: child,
        ),
      ),
    );
  }
}
