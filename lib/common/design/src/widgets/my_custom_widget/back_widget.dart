import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../extensions/src/context_extensions.dart';
import '../../theme/assets.gen.dart';
import '../svg_asset.dart';

class CustomButtonIcon extends StatelessWidget {
  final String svg;
  final GestureTapCallback onTap;
  final double padding;
  final double width;
  final double height;

  const CustomButtonIcon({
    super.key,
    required this.svg,
    required this.onTap,
    this.padding = 10,
    this.width = 24,
    this.height = 24,

  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.topStart,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(padding),

          decoration: BoxDecoration(
            border: Border.all(color: context.textFieldBorderColor),
            shape: BoxShape.circle,
          ),
          child: SvgAsset(  svg, width: width,
            height: height,
            ),
        ),
      ),
    );
  }
}

class BackWidget extends StatelessWidget {
  final PageController? pageController;

  BackWidget({super.key, this.pageController});

  @override
  Widget build(BuildContext context) {
    final bool isArabic = context.locale.languageCode == 'ar';

    return Align(
      alignment: AlignmentDirectional.topStart,
      child: GestureDetector(
        child: Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsetsDirectional.only(end: 8),

          decoration: BoxDecoration(
            border: Border.all(color: context.textFieldBorderColor),
            shape: BoxShape.circle,
            color: Colors.white,

          ),
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()..scale(isArabic ? -1.0 : 1.0, 1.0),
            child: SvgAsset(
              Assets.images.svg.nextArrowIcon,

              color: Color.fromRGBO(35, 31, 32, 1),
            ),
          ),
        ),
        onTap: () {
          if (pageController == null) {
            context.pop();
          } else {
            final currentPage = pageController!.page?.round() ?? 0;
            if (currentPage == 0) {
              context.pop();
            }
            if (currentPage > 0) {
              pageController!.animateToPage(
                currentPage - 1,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            }
          }
        },
      ),
    );
  }
}
class CarsSearchBackWidget extends StatelessWidget {
 final GestureTapCallback onTab;

  const CarsSearchBackWidget({super.key, required this.onTab});

  @override
  Widget build(BuildContext context) {
    final bool isArabic = context.locale.languageCode == 'ar';

    return Align(
      alignment: AlignmentDirectional.topStart,
      child: GestureDetector(
        child: Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsetsDirectional.only(end: 8),

          decoration: BoxDecoration(
            border: Border.all(color: context.textFieldBorderColor),
            shape: BoxShape.circle,
            color: Colors.white,

          ),
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()..scale(isArabic ? -1.0 : 1.0, 1.0),
            child: SvgAsset(
              Assets.images.svg.nextArrowIcon,

              color: Color.fromRGBO(35, 31, 32, 1),
            ),
          ),
        ),
        onTap: onTab,
      ),
    );
  }
}

class CustomEditButtonIcon extends StatelessWidget {
  final String svg;
  final GestureTapCallback onTap;
  final bool isShadow;

  final double padding;
  final Color? color;
  final Color? svgColor;
  final double width;
  final double height;

  const CustomEditButtonIcon({
    super.key,
    required this.svg,
    this.isShadow = false,
    required this.onTap,
    this.padding = 10,
    this.width = 24,
    this.height = 24,
    this.color,
    this.svgColor,
  });

  @override
  Widget build(BuildContext context) {
    final bool isArabic = context.locale.languageCode == 'ar';

    return Align(
      alignment: AlignmentDirectional.topStart,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(padding),

          decoration: BoxDecoration(
            border: Border.all(color: context.textFieldBorderColor),
            shape: BoxShape.circle,
            color: color,
            boxShadow: isShadow
                ? [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, .2),
                      offset: Offset(0, 2),
                      blurRadius: 4,
                      spreadRadius: 0,
                    ),
                  ]
                : [],
          ),
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()..scale(isArabic ? 1.0 : 1.0, 1.0),
            child: SvgAsset( svg, height:height, width: width, color: svgColor),
          ),
        ),
      ),
    );
  }
}

class CustomBackButtonIcon extends StatelessWidget {
  final bool withShadow;

  const CustomBackButtonIcon({super.key, this.withShadow = false});

  @override
  Widget build(BuildContext context) {
    final bool isArabic = context.locale.languageCode == 'ar';

    return Align(
      alignment: AlignmentDirectional.topStart,
      child: GestureDetector(
        onTap: () {
          context.pop();
        },
        child: Container(
          padding: EdgeInsets.all(10),

          decoration: BoxDecoration(
            border: Border.all(color: context.textFieldBorderColor),
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: withShadow
                ? [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, .2),
                      offset: Offset(0, 2),
                      blurRadius: 4,
                      spreadRadius: 0,
                    ),
                  ]
                : null,
          ),
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()..scale(isArabic ? -1.0 : 1.0, 1.0),
            child: SvgAsset(
              Assets.images.svg.nextArrowIcon,
              color: Color.fromRGBO(35, 31, 32, 1),
            ),
          ),
        ),
      ),
    );
  }
}

class BackWithOnTapWidget extends StatelessWidget {

  final GestureTapCallback? onTap;

  const BackWithOnTapWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final bool isArabic = context.locale.languageCode == 'ar';

    return Align(
      alignment: AlignmentDirectional.topStart,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsetsDirectional.only(end: 8),
          decoration: BoxDecoration(
            border: Border.all(color: context.textFieldBorderColor),
            shape: BoxShape.circle,
          ),
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()..scale(isArabic ? -1.0 : 1.0, 1.0),
            child: SvgAsset(

              Assets.images.svg.nextArrowIcon,
              color: context.textColor,




            ),
          ),
        ),
      ),
    );
  }
}
