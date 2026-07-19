import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:restaurants_menu/common/extensions/src/description_extensions.dart';
import 'package:restaurants_menu/common/helper/helper.dart';
import 'package:sliver_tools/sliver_tools.dart';
import '../../../../../common/extensions/src/context_extensions.dart';
import '../../../../cart/presentation/bloc/cart_bloc.dart';
import '../../../../product/presentation/bloc/product_bloc.dart';
import '../home_failed_sliver_widget.dart';
import '../home_product_widget.dart';
import '../home loading widgets/home_products_loading_widget.dart';
import 'home_empty_sliver_widget.dart';

class HomeProductGridStatusWidget extends StatelessWidget {
  final ProductBloc productBloc;
  final CartBloc cartBloc;
   final Function(GlobalKey)? runAddToCartAnimation;
 final ValueNotifier<bool> animationReady;
  final Map<int, GlobalKey> categoryKeys;
  const HomeProductGridStatusWidget({
    super.key,
    required this.productBloc,
    required this.cartBloc,
    required this.runAddToCartAnimation,
    required this.animationReady,
    required this.categoryKeys,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      bloc: productBloc,
      builder: (context, state) {

        final crossAxisCount = context.isDesktop?4: context.isTablet ? 3 : 2;

        return state.getAllProductData.builder(
          onSuccess: (getAllProduct) {

            final list = state.categoryProductList;

            if (list.isEmpty) {
              return HomeEmptySliverWidget(
                title: LocaleKeys.noData.tr(
                    namedArgs: {
                      "data":
                      (context.isArabic
                          ? state.selectedSuperCategory?.name
                          ?.ar
                          : state.selectedSuperCategory?.name
                          ?.en) ??
                          LocaleKeys.data.tr(),
                    }
                ),
                subTitle: LocaleKeys.noDataDesc.tr(
                    namedArgs: {
                      "data":
                      (context.isArabic
                          ? state.selectedSuperCategory?.name
                          ?.ar
                          : state.selectedSuperCategory?.name
                          ?.en) ??
                          LocaleKeys.data.tr(),
                    }
                ),
              );
            }

            return MultiSliver(
              children: [
                for (final e in list) ...[

                  /// ================= HEADER =================
                  SliverToBoxAdapter(
                    key: categoryKeys.putIfAbsent(
                      e.$1.id!,
                          () => GlobalKey(),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 16,
                        bottom: 12,
                      ),
                      child: Row(
                        children: [
                          const Expanded(
                              child: Divider(height: 1)),

                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12),
                            child: Text(
                              e.$1.name.getName(),
                              style: context.headlineSmall(),
                            ),
                          ),

                          const Expanded(
                              child: Divider(height: 1)),
                        ],
                      ),
                    ),
                  ),

                  /// ================= GRID =================
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    sliver: SliverAlignedGrid.count(
                      crossAxisCount: crossAxisCount,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 12,
                      itemCount: e.$2?.length ?? 0,
                      itemBuilder: (context, index) {
                        final product = e.$2![index];

                        return AnimationConfiguration
                            .staggeredGrid(
                          position: index,
                          columnCount: crossAxisCount,
                          duration: const Duration(
                              milliseconds: 375),
                          child: SlideAnimation(
                            verticalOffset: 30,
                            curve: Curves.easeOutCubic,
                            child: FadeInAnimation(
                              child: HomeProductWidget(
                                productModel: product,
                                productBloc: productBloc,
                                cartBloc: cartBloc,
                                runAddToCartAnimation: runAddToCartAnimation,
                                animationReady: animationReady,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  /// ================= SPACE =================
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 16),
                  ),
                ],
              ],
            );
          },

          loadingWidget: HomeProductsLoadingWidget(),
          failedWidget:  HomeFailedSliverWidget(
            title:  state.getAllProductData.errorMessage,
          ),
          //   emptyWidget: SliverToBoxAdapter(child: EmptyWidget()),
          //   failedWidget: SliverToBoxAdapter(
          //     child: AppErrorWidget(
          //       errorMessage: state.getAllProductData.errorMessage,
          //       onTap: () => productBloc.add(GetAllProductEvent(isReload: true)),
          //     ),
          //   ),
        );
      },
    );
  }
}
