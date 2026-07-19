
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../../../common/design/src/widgets/shimmer_widget.dart';
import '../../../../../common/extensions/src/context_extensions.dart';

class HomeProductsLoadingWidget extends StatelessWidget {
  const HomeProductsLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final crossAxisCount = context.isMobile ? 2 : 4;

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 26),
      sliver: SliverAlignedGrid.count(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: 16,
        crossAxisSpacing: 8,
        itemCount: crossAxisCount * 2,
        itemBuilder: (context, index) {
          return ShimmerWidget(
            borderRadius: BorderRadius.circular(12),
            width: double.infinity,
            height: 250,
          );
        },
      ),
    );
  }
}