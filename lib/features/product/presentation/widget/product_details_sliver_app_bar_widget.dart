import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:restaurants_menu/common/design/design.dart';
import 'package:restaurants_menu/common/extensions/src/description_extensions.dart';
import 'package:restaurants_menu/common/helper/helper.dart';
import 'package:restaurants_menu/common/models/product_model.dart';
import 'package:restaurants_menu/features/product/presentation/bloc/product_bloc.dart';
import 'package:restaurants_menu/features/product/presentation/widget/popular_calories_widget.dart';
import 'package:restaurants_menu/features/product/presentation/widget/product_gellery_widget.dart';
import 'package:restaurants_menu/features/product/presentation/widget/product_sliver_app_bar_widget.dart';
import '../../../../common/extensions/src/context_extensions.dart';
import '../../../../common/models/addon_model.dart';
import '../../../cart/presentation/bloc/cart_bloc.dart';
import 'addons_list_widget.dart';
import 'ingredient_widget.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';


class ProductDetailsHeaderAnimation {
  final double progress;

  const ProductDetailsHeaderAnimation({required this.progress});

  double get appBarTitleOpacity {
    return Interval(.75, 1, curve: Curves.easeOut).transform(progress);
  }

  double get expandedTitleOpacity {
    return 1 - Interval(0, .75, curve: Curves.easeOut).transform(progress);
  }

  double get expandedTitlePadding {
    return lerpDouble(20, 72, progress)!;
  }

  Offset get appBarTitleOffset {
    return Offset(lerpDouble(20, 0, appBarTitleOpacity)!, 0);
  }

  Offset get expandedTitleOffset {
    return Offset(0, lerpDouble(0, 20, progress)!);
  }
}

class ProductTitleHeaderWidget extends StatelessWidget {
  final ProductModel productModel;
  final ScrollController scrollController;

  const ProductTitleHeaderWidget({
    super.key,
    required this.productModel,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: scrollController,
      builder: (context, child) {
        // 1. حساب الارتفاع الممدد (مطابق تماماً للـ AppBar)
        final expandedHeight = (context.width * .55).clamp(280.0, 500.0);

        // 2. حساب قيمة الـ offset الحالية
        final offset = scrollController.hasClients
            ? scrollController.offset
            : 0.0;

        // 3. حساب نسبة التحرك من 0.0 (تمدد كامل) إلى 1.0 (إغلاق كامل)
        final progress = (offset / (expandedHeight - kToolbarHeight)).clamp(
          0.0,
          1.0,
        );

        // 4. حساب الأوباسيتي العكسية والإزاحة
        final opacity = (1.0 - progress).clamp(0.0, 1.0);
        final translateY = -15 * progress;

        // تم تغيير SizedBox.expand إلى Container بارتفاع ثابت ليتناسب مع SliverToBoxAdapter
        return Container(
          color: context.scaffoldBackgroundColor,
          child: Opacity(
            opacity: opacity,
            child: Transform.translate(
              offset: Offset(0, translateY * 2),
              child: Padding(
                padding: const EdgeInsetsDirectional.only(
                  start: 20,
                  end: 20,
                  top: 12,
                  bottom: 12,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        productModel.name.getName(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: context.headlineSmall(fontSize: 22),
                      ),
                    ),

                    Space.hS3,

                    Text(
                      LocaleKeys.priceValue.tr(
                        namedArgs: {
                          'value':
                              productModel.internalPrice?.toInt().toString() ??
                              '0',
                        },
                      ),
                      style: context.headlineSmall(
                        fontSize: 24,
                        color: context.primarySwatch,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

//////////////////////

class ProductDetailsContentWidget extends StatelessWidget {
  final ProductModel productModel;
  final CartBloc cartBloc;
  final TextEditingController noteController;
  final List<AddonModel> localeSelectedAddons;
  final ScrollController scrollController;
  final ProductBloc? productBloc;

  const ProductDetailsContentWidget({
    super.key,
    required this.productModel,
    required this.cartBloc,
    required this.noteController,
    required this.localeSelectedAddons,
    required this.scrollController,
     this.productBloc,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top:productBloc!=null? 0:   context.statusBarHeight),
      child: CustomScrollView(
        controller:productBloc==null? null: scrollController ,
        slivers: [
          if(productBloc !=null)...[
            ProductDetailsSliverAppBarWidget(
              productBloc: productBloc!,
              productModel: productModel,
              scrollController: scrollController,
            )
          ],

          SliverToBoxAdapter(
            child: ProductTitleHeaderWidget(
              productModel: productModel,
              scrollController: scrollController,
            ),
          ),

          if (productModel.dishTypeLabel != null &&
              productModel.calories != null)
            PopularCaloriesWidget(productModel: productModel),
          SliverPadding(
            padding: EdgeInsetsGeometry.only(left: 20, right: 20, bottom: 12),
            sliver: SliverToBoxAdapter(
              child: Text(
                productModel.description.getName(),
                style: context.bodySmall(
                  color: context.hintColor,
                  fontSize: 16,
                ),
              ),
            ),
          ),

          if (
          (productModel.ingredientsModel?.ar?.isNotEmpty ?? false) &&
              (productModel.ingredientsModel?.en?.isNotEmpty ?? false)&&
              (productModel.ingredientsModel?.ku?.isNotEmpty ?? false)
          ) ...[
            SliverPadding(
              padding: EdgeInsetsGeometry.only(left: 20, right: 20, bottom: 8),
              sliver: SliverToBoxAdapter(
                child: Text(
                  LocaleKeys.productDetailsIngredients.tr(),
                  style: context.bodyMedium(fontSize: 20),
                ),
              ),
            ),

            ProductIngredientsWidget(
              ingredientsModel: productModel.ingredientsModel!,
            ),
          ],
          if (productModel.addons?.isNotEmpty ?? false) ...[
            SliverPadding(
              padding: EdgeInsetsGeometry.only(left: 20, right: 20, bottom: 8),
              sliver: SliverToBoxAdapter(
                child: Text(
                  LocaleKeys.productDetailsAdditions.tr(),
                  style: context.bodyMedium(fontSize: 20),
                ),
              ),
            ),
            AddonsListWidget(
              cartBloc: cartBloc,
              productModel: productModel,
              localeSelectedAddons: localeSelectedAddons,
            ),
          ],
          SliverPadding(
            padding: EdgeInsetsGeometry.only(left: 20, right: 20, bottom: 8),
            sliver: SliverToBoxAdapter(
              child: Text(
                LocaleKeys.productDetailsNotes.tr(),
                style: context.bodyMedium(fontSize: 20),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsetsGeometry.only(left: 20, right: 20, bottom: 8),
            sliver: SliverToBoxAdapter(
              child: Text(
                LocaleKeys.productDetailsAddYourNotesHere.tr(),
                style: context.bodyLarge(fontSize: 14),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsetsGeometry.only(left: 20, right: 20, bottom: 12),
            sliver: SliverToBoxAdapter(
              child: MyAppTextField(
                minLines: 3,
                maxLines: 6,
                controller: noteController,
                isPadding: false,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.done,
              ),
            ),
          ),



        ],
      ),
    );
  }
}




