import 'package:flutter/material.dart';

import '../../../../common/design/src/widgets/svg_asset.dart';
import '../../../../common/extensions/src/context_extensions.dart';

class AuthTopWidget extends StatelessWidget {
  final String image;
  final String title;
  final String subTitle;
  final String leading;
  final bool isPng;

  const AuthTopWidget({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
    required this.leading,
    this.isPng = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        isPng
            ? Image.asset(image, height: context.width * .31)
            : SvgAsset(image, height: context.width * .31),
        Padding(
          padding: EdgeInsets.only(bottom: 8, top: 24),
          child: Text(
            title,
            style: context.labelSmall(fontSize: 24),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: context.height * .03),
          child: Text(
            subTitle,
            style: context.bodySmall(fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ),
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: context.height * .02,
              top: context.height * .01,
            ),
            child: Text(
              leading,
              style: context.labelSmall(fontSize: 20),
            ),
          ),
        ),
      ],
    );
  }
}
