import 'package:flutter/material.dart';
import '../../../extensions/src/context_extensions.dart';
import '../../../helper/src/locale_keys.dart';
import '../theme/assets.gen.dart';
import '../theme/const.dart';
import 'svg_asset.dart';

class EmptyDataWidget extends StatelessWidget {
  final String? image;
  final double? height;

  const EmptyDataWidget({super.key, this.image, this.height});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgAsset(Assets.images.svg.error.packageProcess,height: 100),

          // Image.asset(
          //   image ?? Assets.images.png.error.empty.keyName,
          //   height: height ?? context.height * .4,
          //
          //
          // ),
          Text(
            LocaleKeys.errorMassegeNocontent.tr(),
            style: context.headlineMedium(
              color: context.primarySwatch,
              fontSize: 24,
            ),
            textAlign: TextAlign.center,

          ),
          Space.vM1,
        ],
      ),
    );
  }
}

class EmptyMessagesDataWidget extends StatelessWidget {
  const EmptyMessagesDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgAsset(Assets.images.svg.error.packageProcess,height: 100),

          // Assets.images.png.error.empty.image(
          //   height: context.height * .4,
          // ),
          Text(
            LocaleKeys.errorMassegeNocontent.tr(),
            style: context.titleLarge(),
          ),
          Space.vM1,
        ],
      ),
    );
  }
}

class EmptyDataSubWidget extends StatelessWidget {
  final String? image;
  final double? height;
  final String title;
  final String subTitle;

  const EmptyDataSubWidget({
    super.key,
    this.image,
    this.height,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgAsset(Assets.images.svg.error.packageProcess,height: 100),

          // Image.asset(
          //   image ?? Assets.images.png.error.empty.keyName,
          //   height: height ?? context.height * .4,
          // ),
          SizedBox(height: 24),
          Text(
           title,
            style: context.labelSmall(fontSize: 24),
            textAlign: TextAlign.center,

          ),
          Space.vM1,
          Text(
            subTitle,
            style: context.bodySmall(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
