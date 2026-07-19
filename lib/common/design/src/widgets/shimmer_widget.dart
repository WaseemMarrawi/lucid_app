import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../extensions/src/context_extensions.dart';

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({
    super.key,
    this.width,
    this.height,
    this.border,
    this.shape = BoxShape.rectangle,
    this.padding = EdgeInsets.zero,
    this.borderRadius,
  });

  final double? width;
  final double? height;
  final Border? border;
  final BoxShape shape;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Shimmer.fromColors(
        baseColor: const Color.fromRGBO(236, 237, 237, .5),
        highlightColor: const Color.fromRGBO(236, 237, 237, 1),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color:    const Color.fromRGBO(236, 237, 237, 1),
            shape: shape,
            border: border,
            borderRadius: borderRadius,
          ),
        ),
      ),
    );
  }
}

class ShimmerProductWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.25),
            blurRadius: 6, // soften the shadow
            spreadRadius: 0, //extend the shadow
            offset: Offset(
              0, // Move to right 5  horizontally
              4.0, // Move to bottom 5 Vertically
            ),
          ),
        ],
      ),
      child: Shimmer.fromColors(
        baseColor: context.primarySwatch.withOpacity(.1),
        highlightColor: context.primarySwatch.withOpacity(.6),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 6, vertical: 10),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: context.width * .02,
                  top: context.height * .001,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        right: context.width * .02,
                        bottom: context.height * .02,
                        top: context.width * .04,
                      ),
                      width: context.width * .1,
                      height: context.height * .05,
                      child: ClipOval(child: Container(color: Colors.white)),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                              top: context.height * .02,
                              bottom: context.height * .02,
                            ),
                            margin: EdgeInsets.only(
                              top: context.height * .02,
                              bottom: context.height * .01,
                            ),
                            height: context.height * .03,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            width: context.width * .3,
                          ),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                  top: context.height * .02,
                                  bottom: context.height * .02,
                                ),
                                height: context.height * .02,
                                width: context.width * .15,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: context.width * .02,
                                ),
                                height: context.height * .02,
                                child: VerticalDivider(
                                  width: context.width * .02,
                                  color: Colors.grey,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                  top: context.height * .02,
                                  bottom: context.height * .02,
                                ),
                                height: context.height * .02,
                                width: context.width * .15,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: context.width * .02,
                  top: context.height * .02,
                  bottom: context.height * .005,
                ),
                height: context.height * .03,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                width: context.width * .7,
              ),
              Container(
                margin: EdgeInsets.only(left: context.width * .02),
                height: context.height * .03,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                width: context.width * .7,
              ),
              Container(
                margin: EdgeInsets.only(
                  left: context.width * .02,
                  top: context.height * .02,
                ),
                width: double.infinity,
                height: MediaQuery
                    .of(context)
                    .size
                    .height / 4,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),

                // Image.network(
                //   product.photos![0],
                //   fit: BoxFit.fill,
                // ),
              ),
              Container(
                height: context.height * .035,
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: context.width * .02),

                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: context.width * .02),

                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: context.width * .02),

                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Container(
              //   padding: EdgeInsets.all(context.height * .01),
              //   color: Colors.white,
              //   width: context.width * .8,
              //   height: context.height * 1,
              // ),
              // Container(
              //   padding: EdgeInsets.all(context.height * .01),
              //   color: Colors.white,
              //   width: context.width * .8,
              //   height: context.height * 1,
              // ),
              // Container(
              //     color: Colors.white,
              //     width: double.infinity,
              //     height: MediaQuery.of(context).size.height / 3,
              //     child: Container(
              //       margin:
              //           EdgeInsets.symmetric(vertical: context.width * .005),
              //     )
              //     // Image.network(
              //     //   product.photos![0],
              //     //   fit: BoxFit.fill,
              //     // ),
              //
              //     )
            ],
          ),
        ),
      ),
    );
  }
}

class ShimmerDropdownButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: context.primarySwatch.withOpacity(.1),
      highlightColor: context.primarySwatch.withOpacity(.6),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),

        height: context.height * .065,

        width: context.width * .9,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}

class ShimmerMessageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Random randomFormHeight = Random();
    Random randomFormWidth = Random();
    Random randomFormBool = Random();

    bool randomBool = randomFormBool.nextBool();

    double min = .04;
    double max = .15;
    double minWidth = .2;
    double maxWidth = .6;

    double randomValue = min + (randomFormHeight.nextDouble() * (max - min));
    double randomWidth =
        minWidth + (randomFormWidth.nextDouble() * (maxWidth - minWidth));
    return Align(
      alignment: randomBool ? Alignment.centerLeft : Alignment.centerRight,
      child: Shimmer.fromColors(
        baseColor: context.primarySwatch.withOpacity(.1),
        highlightColor: context.primarySwatch.withOpacity(.8),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),

          height: context.height * randomValue,

          width: context.width * randomWidth,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}

class ShimmerCheckBoxWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Random randomFormHeight = Random();

    double min = .04;
    double max = .15;

    double randomValue = min + (randomFormHeight.nextDouble() * (max - min));
    return Shimmer.fromColors(
      baseColor: context.primarySwatch.withOpacity(.1),
      highlightColor: context.primarySwatch.withOpacity(.8),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),

        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.white,
                    blurRadius: 6, // soften the shadow
                    spreadRadius: 0, //extend the shadow
                    offset: Offset(
                      0, // Move to right 5  horizontally
                      4.0, // Move to bottom 5 Vertically
                    ),
                  ),
                ],
              ),
              width: context.width * .05,
              height: context.height * .025,

              // Image.network(
              //   comment.user!.photo!,
              //
              //   fit: BoxFit.fill,
              // ),
            ),
            SizedBox(width: context.width * .02),
            Container(
              height: context.height * .03,
              width: context.width * .14,

              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.white,
                    blurRadius: 6, // soften the shadow
                    spreadRadius: 0, //extend the shadow
                    offset: Offset(
                      0, // Move to right 5  horizontally
                      4.0, // Move to bottom 5 Vertically
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShimmerTitleAccessories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 24),

        Padding(
          padding: const EdgeInsetsDirectional.only(start: 20, end: 20),
          child: Row(
            children: [
              Shimmer.fromColors(
                baseColor: const Color.fromRGBO(236, 237, 237, .5),
                highlightColor: const Color.fromRGBO(236, 237, 237, 1),
                child: Container(
                  height: context.height * .03,
                  width: context.width * .3,

                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(16)
                  ),
                ),
              ),
              const Spacer(),
              Shimmer.fromColors(
                baseColor: const Color.fromRGBO(236, 237, 237, .5),
                highlightColor: const Color.fromRGBO(236, 237, 237, 1),
                child: Container(
                  height: context.height * .01,
                  width: context.width * .1,

                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16)
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),
      ],
    );
  }


}

class ShimmerAccessories extends StatelessWidget {
  const ShimmerAccessories({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height * .33,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(236, 237, 237, 1),
            blurRadius: 0,
            spreadRadius: 0,
            offset: const Offset(4, 4),
          ),
        ],
        border: Border.all(color: Color.fromRGBO(236, 237, 237, 1)),
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 12,
            child: Shimmer.fromColors(
              baseColor: const Color.fromRGBO(236, 237, 237, .5),
              highlightColor: const Color.fromRGBO(236, 237, 237, 1),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16)
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
              child: Shimmer.fromColors(
                baseColor: const Color.fromRGBO(236, 237, 237, .5),
            highlightColor: const Color.fromRGBO(236, 237, 237, 1),
            child: Container(
              height: 10,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24)
              ),

              margin: const EdgeInsets.only(bottom: 6),
            ),
          ),
          flex: 2,
          ),
          Expanded(
            child: Container(
              width: context.width*.4,
              child: Shimmer.fromColors(
                baseColor: const Color.fromRGBO(236, 237, 237, .5),
                highlightColor: const Color.fromRGBO(236, 237, 237, 1),
                child: Container(
                  height: 10,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24)
                  ),

                  margin: const EdgeInsets.only(bottom: 6),
                ),
              ),
            ),
            flex: 2,
          ),
          SizedBox(
              height: 8
          ),
          Expanded(
            child: Container(
              width: context.width*.2,
              child: Shimmer.fromColors(
                baseColor: const Color.fromRGBO(236, 237, 237, .5),
                highlightColor: const Color.fromRGBO(236, 237, 237, 1),
                child: Container(
                  height: 10,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24)
                  ),

                  margin: const EdgeInsets.only(bottom: 6),
                ),
              ),
            ),
            flex: 2,
          ),
          SizedBox(
            height: 8
          ),
          Expanded(
            child: Container(
              width: context.width*.2,
              child: Shimmer.fromColors(
                baseColor: const Color.fromRGBO(236, 237, 237, .5),
                highlightColor: const Color.fromRGBO(236, 237, 237, 1),
                child: Container(
                  height: 10,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24)
                  ),

                  margin: const EdgeInsets.only(bottom: 6),
                ),
              ),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }
}


class ShimmerTextWidget extends StatelessWidget {
  const ShimmerTextWidget({
    super.key,
    this.width,
    this.height,
    this.border,
    this.shape = BoxShape.rectangle,
    this.padding = EdgeInsets.zero,
    this.borderRadius,
  });

  final double? width;
  final double? height;
  final Border? border;
  final BoxShape shape;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Shimmer.fromColors(
        baseColor: const Color.fromRGBO(236, 237, 237, .5),
        highlightColor: const Color.fromRGBO(236, 237, 237, 1),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color:    const Color.fromRGBO(236, 237, 237, 1),

            shape: shape,
            border: border,
            borderRadius: borderRadius,
          ),
        ),
      ),
    );
  }
}
