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

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: ScaleTransition(
                scale: Tween<double>(
                  begin: 0.95,
                  end: 1.0,
                ).animate(animation),
                child: child,
              ),
            );
          },
          child: isInCart
              ?
          Container(
            key: ValueKey(
              "in_cart_${productModel.id}",
            ),
            margin: const EdgeInsets.only(top: 6),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    child:
                    ProductChangeCartCountWidget(
                      cartBloc: cartBloc,
                      productModel: productModel,
                    ),
                  ),
                  const SizedBox(width: 4),
                  InkWell(
                    onTap: () {
                      cartBloc.add(
                        DeleteFromCartEvent(
                          id: productModel.id!,
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(8),
                        // color: context.cardColor,
                        border: Border.all(
                          color:
                          context.primarySwatch,
                        ),
                      ),
                      padding:
                      const EdgeInsets.symmetric(
                        horizontal: 6,
                      ),
                      child: Center(
                        child: SvgAsset(
                          Assets.images.svg.trash,
                          color:
                          context.primarySwatch,
                          height: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
              : ProductWidgetNotInCartButton(
            productModel: productModel,
            cartBloc: cartBloc,
            productCartKey: productCartKey,
            runAddToCartAnimation: runAddToCartAnimation,
          ),
        );
      },
    );
  }
}
