import 'package:flutter/material.dart';
import 'package:restaurants_menu/common/design/src/widgets/animation_widget/animated_scale_widget.dart';

import '../../../../common/extensions/src/context_extensions.dart';
import '../../../../common/helper/src/locale_keys.dart';
import '../../../../common/models/ingredient_model.dart';
import '../../../../common/models/product_model.dart';

class ProductIngredientsWidget extends StatelessWidget {
  final IngredientsModel ingredientsModel;

  const ProductIngredientsWidget({
    super.key,
    required this.ingredientsModel,
  });

  @override
  Widget build(BuildContext context) {
    final ingredients =
    context.isArabic ?
    ingredientsModel.ar :
    context.isEnglish ?
    ingredientsModel.en : ingredientsModel.ku;

    if (ingredients == null || ingredients.isEmpty) {
      return SliverToBoxAdapter(child: const SizedBox.shrink());
    }

    return SliverPadding(
      padding: EdgeInsetsGeometry.only(
        left: 20,
        right: 20,
        bottom: 12,
      ),
      sliver: SliverToBoxAdapter(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: ingredients.map((e) {
              return AnimatedScaleWidget(
                child: Container(
                  margin: const EdgeInsetsDirectional.only(end: 8),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: context.cardColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: context.dividerColor,
                    ),
                  ),
                  child: Text(
                    e,
                    style: context.bodyMedium(
                      fontSize: 14,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}