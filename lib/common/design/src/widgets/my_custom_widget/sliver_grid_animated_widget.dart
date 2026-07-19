
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class SliverGridAnimatedWidget extends StatelessWidget {

  final Widget child;
  final int crossCount;
  final double mainSpacing;
  final double crossSpacing;
  final double AspectRatio;
  final int count;

  const SliverGridAnimatedWidget({super.key, required this.crossCount, required this.mainSpacing, required this.crossSpacing, required this.AspectRatio, required this.count, required this.child});

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossCount,
        mainAxisSpacing: mainSpacing,
        crossAxisSpacing: crossSpacing,
        childAspectRatio: AspectRatio,
      ),
      delegate: SliverChildBuilderDelegate((
          BuildContext context,
          int index,
          ) {
        return AnimationConfiguration.staggeredGrid(
          position: index,
          duration: const Duration(milliseconds: 375),
          columnCount: crossCount,
          child:  ScaleAnimation(
            child: FadeInAnimation(
              child:child,
            ),
          ),
        );
      }, childCount: count),
    );
  }
}
