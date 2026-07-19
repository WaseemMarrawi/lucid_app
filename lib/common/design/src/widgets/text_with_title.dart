import 'package:flutter/material.dart';

import '../../../extensions/extensions.dart';

class TextWithTitle extends StatelessWidget {
  const TextWithTitle({
    super.key,
    required this.title,
    this.body,
  });

  final String title;
  final String? body;

  @override
  Widget build(BuildContext context) {
    return (body == null)
        ? Container()
        : Expanded(
            child: Row(
              children: [
                Text(
                  "$title : ",
                  style: context.titleMedium(),
                ),
                Flexible(
                    child: Text(
                  body!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )),
              ],
            ),
          );
  }
}
