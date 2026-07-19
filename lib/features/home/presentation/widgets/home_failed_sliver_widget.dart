
import 'package:flutter/material.dart';

import '../../../../common/design/src/theme/assets.gen.dart';
import '../../../../common/design/src/theme/const.dart';
import '../../../../common/design/src/widgets/svg_asset.dart';
import '../../../../common/extensions/src/context_extensions.dart';
import '../../../../common/helper/src/locale_keys.dart';

class HomeFailedSliverWidget extends StatelessWidget {
  final String title;
  final String? subTitle;

  const HomeFailedSliverWidget({super.key,required this.title, this.subTitle});


  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Column(
        mainAxisAlignment: .center,
        children: [
          SvgAsset(
            Assets.images.svg.error.alert02,
            height: 100,
            color: context.hintColor,

          ),
          Text(
            title,
            style: context.headlineSmall(fontSize: 22),
            textAlign: TextAlign.center,

          ),
          Space.vS3,
          Text(
              subTitle?? LocaleKeys.pleaseReload.tr(),
            style: context.bodySmall(
              fontSize: 14,
              color: context.hintColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
