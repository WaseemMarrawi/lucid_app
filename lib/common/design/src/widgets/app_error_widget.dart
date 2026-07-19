import 'package:flutter/material.dart';

import '../../../extensions/extensions.dart';
import '../../../helper/src/locale_keys.dart';
import '../../design.dart';

class AppErrorWidget extends StatelessWidget {
  const AppErrorWidget({
    super.key,
    required this.errorMessage,
    required this.onTap,
  });

  final String errorMessage;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.width * .05),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgAsset(Assets.images.svg.error.alert02,height: 100),
          Space.vM4,
          Text(
            errorMessage,
            style: context.bodyMedium(fontSize: 16,color: context.textColor),
            textAlign: TextAlign.center,
          ),
          Space.vM1,


          SizedBox(
            width: context.width,
            child: ElevatedButton(
              onPressed: onTap,
              child:  Text(LocaleKeys.retry.tr(),style: context.bodyMedium(
                  color: Colors.white,
                  fontSize: 16
              ),),
            ),
          ),
        ],
      ),
    );
  }
}

class AppErrorWidgetReFresh extends StatelessWidget {
  const AppErrorWidgetReFresh({
    super.key,
    required this.errorMessage,
    required this.onTap,
  });

  final String errorMessage;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        onTap();
      },
      child: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: context.width * .05),
              child: GestureDetector(
                onTap: onTap,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgAsset(Assets.images.svg.error.alert02,height: 100),

                    // Assets.images.png.error.error.image(
                    //   width: context.width
                    // ),
                   Space.vM4,

                    Text(
                      errorMessage,
                      style: context.bodyMedium(fontSize: 16,color: context.textColor),
                      textAlign: TextAlign.center,
                    ),
                    Space.vM1,

                    SizedBox(
                      width: context.width,
                      child: ElevatedButton(
                        onPressed: onTap,
                        child:  Text(LocaleKeys.retry.tr(),style: context.bodyMedium(
                            color: Colors.white,
                            fontSize: 16
                        ),),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AppErrorWidgetNullReFresh extends StatelessWidget {
  const AppErrorWidgetNullReFresh({
    super.key,
    required this.errorMessage,
    required this.errorSubMessage,
    required this.onTap,
    this.image,
  });

  final String errorMessage;
  final String errorSubMessage;
  final String? image;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        onTap();
      },
      child: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: context.width * .05),
              child: GestureDetector(
                onTap: onTap,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgAsset(Assets.images.svg.error.alert02,height: 100),

                    // image == null
                    //     ? Assets.images.png.error.error.image(
                    //         width: context.width * .63,
                    //       )
                    //     : Image.asset(image!, width: context.width * .63),
                    // const SizedBox(height: 24),
                    Text(
                      errorMessage,
                      style: context.labelSmall(fontSize: 24),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      errorSubMessage,
                      style: context.bodySmall(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class AppCenterErrorImageWidget extends StatelessWidget {
  final String subErrorMessage;
  final VoidCallback? onTapRetry;
  final String? image;

  const AppCenterErrorImageWidget({
    super.key,
   required this.subErrorMessage,
    this.image,
    this.onTapRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgAsset(Assets.images.svg.error.alert02,height: 100),

        // Image.asset(Assets.images.png.error.error.path,width: context.width,),
        Space.vS3,
        Text(
          subErrorMessage! ,
          style: context.bodySmall(fontSize: 18, color: context.hintColor),
          textAlign: TextAlign.center,
        ),
        Space.vL3,
        onTapRetry == null
            ? SizedBox()
            : SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onTapRetry,
            child:  Text(LocaleKeys.retry.tr(),style: context.bodyMedium(
              color: Colors.white,
              fontSize: 16
            ),),
          ),
        ),
      ],
    );
  }
}