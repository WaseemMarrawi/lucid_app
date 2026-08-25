import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'package:restaurants_menu/common/extensions/src/description_extensions.dart';
import 'package:restaurants_menu/common/helper/helper.dart';

import '../../../../../common/extensions/src/context_extensions.dart';
import '../../../../cart/presentation/bloc/cart_bloc.dart';
import '../../../../product/presentation/bloc/product_bloc.dart';
import '../home loading widgets/home_products_loading_widget.dart';
import '../home_failed_sliver_widget.dart';
import '../home_product_widget.dart';
import 'home_empty_sliver_widget.dart';

class HomeProductGridStatusWidget extends StatelessWidget {
  final ProductBloc productBloc;
  final CartBloc cartBloc;
  final Function(GlobalKey)? runAddToCartAnimation;
  final ValueNotifier<bool> animationReady;
  final ItemScrollController itemScrollController;

  const HomeProductGridStatusWidget({
    super.key,
    required this.productBloc,
    required this.cartBloc,
    required this.runAddToCartAnimation,
    required this.animationReady,
    required this.itemScrollController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      bloc: productBloc,
      builder: (context, state) {
        final crossAxisCount = context.isDesktop
            ? 4
            : context.isTablet
            ? 3
            : 2;

        return state.getAllProductData.builder(
          onSuccess: (getAllProduct) {
            final list = state.categoryProductList;

            if (list.isEmpty) {
              return CustomScrollView(
                slivers: [
                  HomeEmptySliverWidget(
                    title: LocaleKeys.noData.tr(
                      namedArgs: {
                        "data": (context.isArabic
                            ? state.selectedSuperCategory?.name?.ar
                            : state.selectedSuperCategory?.name?.en) ??
                            LocaleKeys.data.tr(),
                      },
                    ),
                    subTitle: LocaleKeys.noDataDesc.tr(
                      namedArgs: {
                        "data": (context.isArabic
                            ? state.selectedSuperCategory?.name?.ar
                            : state.selectedSuperCategory?.name?.en) ??
                            LocaleKeys.data.tr(),
                      },
                    ),
                  ),
                ],
              );
            }

            return ScrollablePositionedList.builder(
              itemCount: list.length,
              itemScrollController: itemScrollController,
              itemBuilder: (context, index) {
                final categoryData = list[index];
                final category = categoryData.$1;
                final products = categoryData.$2 ?? [];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// ================= HEADER =================
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 16,
                        bottom: 12,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Divider(
                              height: 1,
                              color: context.primarySwatch,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                            ),
                            child: Text(
                              category.name.getName(),
                              style: context.headlineSmall(),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              height: 1,
                              color: context.primarySwatch,
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// ================= GRID (AlignedGridView) =================
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      child: AlignedGridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: crossAxisCount,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 12,
                        itemCount: products.length,
                        itemBuilder: (context, productIndex) {
                          final product = products[productIndex];

                          return AnimationConfiguration.staggeredGrid(
                            position: productIndex,
                            columnCount: crossAxisCount,
                            duration: const Duration(milliseconds: 375),
                            child: SlideAnimation(
                              verticalOffset: 30,
                              curve: Curves.easeOutCubic,
                              child: FadeInAnimation(
                                child: HomeProductWidget(
                                  productModel: product,
                                  productBloc: productBloc,
                                  cartBloc: cartBloc,
                                  runAddToCartAnimation:
                                  runAddToCartAnimation,
                                  animationReady: animationReady,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    /// ================= SPACE =================
                    const SizedBox(height: 16),
                  ],
                );
              },
            );
          },
          loadingWidget: CustomScrollView(
            slivers: [
              HomeProductsLoadingWidget(),
            ],
          ),
          failedWidget: CustomScrollView(
            slivers: [
              HomeFailedSliverWidget(
                title: state.getAllProductData.errorMessage,
              ),
            ],
          ),
        );
      },
    );
  }
}