import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurants_menu/common/design/design.dart';
import 'package:restaurants_menu/common/extensions/src/description_extensions.dart';
import 'package:restaurants_menu/common/models/cart_product_model.dart';
import 'package:restaurants_menu/router/app_router.dart';
import '../../../../common/design/src/theme/assets.gen.dart';
import '../../../../common/design/src/theme/const.dart';
import '../../../../common/design/src/widgets/cach_network_image.dart';
import '../../../../common/extensions/src/context_extensions.dart';
import '../../../../common/helper/src/locale_keys.dart';
import '../../../../common/models/product_model.dart';
import '../../../cart/presentation/bloc/cart_bloc.dart';
import '../../../cart/presentation/widgets/change_cart_count_widget.dart';
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
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: context.scaffoldBackgroundColor,
        border: Border.all(color: context.primarySwatch),

        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, .25),
            blurRadius: 5,
            offset: Offset(0, 0),
          ),
        ],
      ),

      child: Stack(
        clipBehavior: Clip.none,
        children: [
          InkWell(
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
            child: Container(
              height: 172,
              key: productCartKey,

              decoration: BoxDecoration(
                color: context.dividerColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Hero(
                tag: '${productModel.id}',
                child:
                    (productModel.media?.gallery == null ||
                        productModel.media!.gallery!.isEmpty)
                    ? Assets.images.png.logo.image(fit: BoxFit.fitWidth)
                    : CacheNetworkImage(
                        imageUrl: productModel.media!.gallery![0],
                        borderRadius: BorderRadius.circular(16),
                        boxFit: BoxFit.cover,
                      ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 160),
            child: Container(
              margin: context.isMobile
                  ? EdgeInsets.only(left: 4, right: 4, bottom: 4)
                  : EdgeInsets.only(left: 8, right: 8, bottom: 8),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: context.scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: context.dividerColor),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0x1A000000), // #0000001A
                    offset: const Offset(0, 8),
                    blurRadius: 10,
                    spreadRadius: -6,
                  ),
                  BoxShadow(
                    color: const Color(0x1A000000),
                    offset: const Offset(0, 20),
                    blurRadius: 25,
                    spreadRadius: -5,
                  ),
                ],
              ),
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

                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        '${productModel.internalPrice?.round() ?? LocaleKeys.nullText.tr()} ${LocaleKeys.homeCurrency.tr()}',
                        style: context.headlineSmall(
                          fontSize: 14,
                          color: context.primarySwatch,
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

                    ],
                  ),

                  ProductCartButtonsWidget(
                    productModel: productModel,
                    cartBloc: cartBloc,
                    productCartKey: productCartKey,
                    runAddToCartAnimation: runAddToCartAnimation,
                    animationReady: animationReady,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
