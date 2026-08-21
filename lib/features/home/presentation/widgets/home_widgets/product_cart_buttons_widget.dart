import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurants_menu/common/models/product_model.dart';
import 'package:restaurants_menu/features/home/presentation/widgets/home_widgets/product_widget_not_in_cart_button.dart';
import '../../../../../common/design/src/theme/assets.gen.dart';
import '../../../../../common/design/src/theme/const.dart';
import '../../../../../common/design/src/widgets/svg_asset.dart';
import '../../../../../common/extensions/src/color_extentions.dart';
import '../../../../../common/extensions/src/context_extensions.dart';
import '../../../../../common/helper/src/locale_keys.dart';
import '../../../../../common/models/media_model.dart';
import '../../../../cart/presentation/bloc/cart_bloc.dart';
import '../../../../cart/presentation/widgets/change_cart_count_widget.dart';
import 'package:collection/collection.dart';

class ProductCartButtonsWidget extends StatelessWidget {
  final CartBloc cartBloc;
  final ProductModel productModel;
  final GlobalKey productCartKey;
  final Function(GlobalKey)? runAddToCartAnimation;
 final ValueNotifier<bool> animationReady;
   ProductCartButtonsWidget({super.key, required this.animationReady,required this.cartBloc, required this.productModel, required this.productCartKey, required this.runAddToCartAnimation});



  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<CartBloc, CartState>(
      bloc: cartBloc,
      builder: (context, state) {
        final bool isInCart = state.cartList.any(
              (e) => e.id == productModel.id,
        );

        final result = state.cartList.firstWhereOrNull(
              (e) => e.id == productModel.id,
        );

        return AnimatedContainer(
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeInOutCubic,
          margin: const EdgeInsets.all(6),


          padding: isInCart
              ? const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 4,
          )
              : const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5000),
            gradient: LinearGradient(
              colors: [
                context.primarySwatch.derivedColor.withOpacity(.9),
                context.primarySwatch.withOpacity(.9),
                context.primarySwatch.withOpacity(.9),
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF000000).withOpacity(0.10),
                offset: const Offset(0, 2),
                blurRadius: 4,
                spreadRadius: -2,
              ),
              BoxShadow(
                color: const Color(0xFF000000).withOpacity(0.10),
                offset: const Offset(0, 4),
                blurRadius: 6,
                spreadRadius: -1,
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOutCubic,
                child: !isInCart || result == null
                    ? const SizedBox.shrink()
                    : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: result.count! >= 2
                          ? () {
                        final val = result.count! - 1;

                        cartBloc.add(
                          EditCartEvent(
                            params: productModel.copyWith(
                              count: val,
                            ),
                          ),
                        );
                      }
                          : () {
                        cartBloc.add(
                          DeleteFromCartEvent(
                            id: productModel.id!,
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 6,
                        ),
                        child: Icon(
                          Icons.remove,
                          color: context.cardColor,
                          size: 25,
                        ),
                      ),
                    ),

                    Space.hS3,

                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 180),
                      transitionBuilder: (child, animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: ScaleTransition(
                            scale: animation,
                            child: child,
                          ),
                        );
                      },
                      child: Text(
                        result.count.toString(),
                        key: ValueKey(result.count),
                        style: context.bodyLarge(
                          color: context.cardColor,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    Space.hS3,
                  ],
                ),
              ),

              InkWell(
                onTap: () async {
                  if (isInCart && result != null) {
                    if (result.count! < 99) {
                      final val = result.count! + 1;

                      cartBloc.add(
                        EditCartEvent(
                          params: productModel.copyWith(
                            count: val,
                          ),
                        ),
                      );
                    }

                    return;
                  }

                  cartBloc.add(
                    EditCartEvent(
                      params: ProductModel(
                        id: productModel.id,
                        count: 1,
                        name: productModel.name,
                        media: productModel.media,
                        externalPrice: productModel.externalPrice,
                        internalPrice: productModel.internalPrice,
                      ),
                    ),
                  );

                  if (!context.mounted) return;

                  if (runAddToCartAnimation != null) {
                    await runAddToCartAnimation!(
                      productCartKey,
                    );
                  }
                },
                child: Icon(
                  Icons.add_outlined,
                  color: context.cardColor,
                  size: 25,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}


class CategoryStatusSliverDelegate
    extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double height;

  const CategoryStatusSliverDelegate({
    required this.child,
    required this.height,
  });

  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  Widget build(
      BuildContext context,
      double shrinkOffset,
      bool overlapsContent,
      ) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: child,
    );
  }

  @override
  bool shouldRebuild(
      covariant CategoryStatusSliverDelegate oldDelegate,
      ) {
    return oldDelegate.child != child ||
        oldDelegate.height != height;
  }
}