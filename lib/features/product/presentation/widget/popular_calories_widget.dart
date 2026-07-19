
import 'package:flutter/material.dart';

import '../../../../common/extensions/src/context_extensions.dart';
import '../../../../common/helper/src/locale_keys.dart';
import '../../../../common/models/product_model.dart';

class PopularCaloriesWidget extends StatelessWidget {
  final ProductModel productModel;

  const PopularCaloriesWidget({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsetsGeometry.symmetric(
        horizontal: 20,
        vertical: 12,
      ),
      sliver: SliverToBoxAdapter(
        child: Wrap(
          direction: Axis.horizontal,
          children: [
            productModel.dishTypeLabel == 'Popular'
                ? Container(
              margin: EdgeInsetsDirectional.only(end: 8),
              padding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: context.primarySwatch.withOpacity(
                  .1,
                ),
              ),
              child: Text(
                LocaleKeys.popular.tr(),
                style: context.bodyMedium(
                  color: context.primarySwatch,
                  fontSize: 12,
                ),
              ),
            )
                : SizedBox(),
            productModel.calories == null
                ? SizedBox()
                : Container(
              padding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: context.primarySwatch.withOpacity(
                  .1,
                ),
              ),
              child: Text(
                LocaleKeys.productDetailsCalories.tr(
                  namedArgs: {
                    "value": (productModel.calories!)
                        .toString(),
                  },
                ),
                style: context.bodyMedium(
                  color: context.primarySwatch,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
