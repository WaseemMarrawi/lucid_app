import 'package:flutter/material.dart';
import 'package:restaurants_menu/common/design/design.dart';
import 'package:restaurants_menu/common/extensions/src/description_extensions.dart';
import 'package:restaurants_menu/router/app_router.dart';
import '../../../../common/extensions/src/context_extensions.dart';
import '../../../../common/helper/src/locale_keys.dart';
import '../../../../common/models/product_model.dart';
import '../../../cart/presentation/bloc/cart_bloc.dart';
import '../../../product/presentation/bloc/product_bloc.dart';
import '../../../product/presentation/page/product_details_screen.dart';
import 'home_widgets/product_cart_buttons_widget.dart';

class HomeProductWidget extends StatelessWidget {
  final ProductModel productModel;
  final ProductBloc productBloc;
  final CartBloc cartBloc;
  final productCartKey = GlobalKey();
  late final Function(GlobalKey)? runAddToCartAnimation;
  final ValueNotifier<bool> animationReady;

  HomeProductWidget({
    super.key,
    required this.productModel,
    required this.productBloc,
    required this.cartBloc,
    required this.runAddToCartAnimation,
    required this.animationReady,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),

      onTap: () {
        context.pushNamed(
          RouteName.productDetails,
          arguments: ProductDetailsScreenParams(
            productBloc: productBloc,
            cartBloc: cartBloc,
            productModel: productModel,
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(

            decoration: BoxDecoration(
              color: context.dividerColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                Container(
                  height: 172,

                  key: productCartKey,

                  child: Hero(

                    tag: '${productModel.id}',
                    child:
                    (productModel.media?.gallery == null ||
                        productModel.media!.gallery!.isEmpty)
                        ? Assets.images.png.logo.image(fit: BoxFit.fitWidth)
                        : CacheNetworkImageLocale(
                      imageUrl: productModel.media!.gallery![0],
                      borderRadius: BorderRadius.circular(16),
                      boxFit: BoxFit.cover,
                    ),
                  ),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {},
                  child: ProductCartButtonsWidget(
                    productModel: productModel,
                    cartBloc: cartBloc,
                    productCartKey: productCartKey,
                    runAddToCartAnimation: runAddToCartAnimation,
                    animationReady: animationReady,
                  ),
                ),
              ],
            ),
          ),

          Container(

            padding: const EdgeInsets.all(8),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  productModel.name.getName(),
                  style: context.headlineSmall(
                    fontSize: 14,
                    color: context.textColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Space.vS2,


                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${productModel.internalPrice?.round() ?? LocaleKeys.nullText.tr()} ${LocaleKeys.homeCurrency.tr()}',
                        style: context.headlineSmall(
                          fontSize: 14,
                          color: context.primarySwatch,
                        ),
                      ),
                    ),
                    if (productModel.dishTypeLabel == 'Popular')
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: context.primarySwatch.withOpacity(.1),
                        ),
                        child: Text(
                          LocaleKeys.popular.tr(),
                          style: context.bodyMedium(
                            color: context.primarySwatch,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    Space.vS2,
                  ],
                ),



              ],
            ),
          ),
        ],
      ),
    );
  }
}
