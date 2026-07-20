
import 'package:flutter/material.dart';
import 'package:restaurants_menu/common/models/product_model.dart';
import 'package:restaurants_menu/features/cart/presentation/bloc/cart_bloc.dart';

import '../../../../../common/design/src/theme/assets.gen.dart';
import '../../../../../common/design/src/theme/const.dart';
import '../../../../../common/design/src/widgets/svg_asset.dart';
import '../../../../../common/extensions/src/color_extentions.dart';
import '../../../../../common/extensions/src/context_extensions.dart';
import '../../../../../common/helper/src/locale_keys.dart';
import '../../../../../common/models/media_model.dart';

class ProductWidgetNotInCartButton extends StatelessWidget {
  final ProductModel productModel;
  final CartBloc cartBloc;
  final Function(GlobalKey)? runAddToCartAnimation;
  final GlobalKey productCartKey;

  const ProductWidgetNotInCartButton({super.key, required this.productModel, required this.cartBloc, this.runAddToCartAnimation, required this.productCartKey});


  @override
  Widget build(BuildContext context) {
    return Container(
      key: ValueKey(
        "not_in_cart_${productModel.id}",
      ),
      width: context.width,
      margin: const EdgeInsets.only(top: 6),
      child: InkWell(
        onTap: () async{
          cartBloc.add(
            EditCartEvent(
              params: ProductModel(
                id: productModel.id,
                count: 1,
                name: productModel.name,
                media: productModel
                    .media,
                externalPrice:
                productModel
                    .externalPrice,
                internalPrice:
                productModel
                    .internalPrice,
              ),
            ),
          );
          if (!context.mounted) return;


          if (runAddToCartAnimation != null) {
            await runAddToCartAnimation!(productCartKey);

          }


        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius:
            BorderRadius.circular(32),
            // gradient: LinearGradient(
            //   colors: [
            //     context.primarySwatch
            //         .withOpacity(.7),
            //     context.primarySwatch
            //         .withOpacity(.7),
            //     context.primarySwatch,
            //   ],
            //   begin:
            //   Alignment.bottomRight,
            //   end: Alignment.topLeft,
            // ),

            gradient: LinearGradient(
              colors: [
                context.primarySwatch.derivedColor,
                context.primarySwatch,
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,

            ),
            boxShadow: [
              // الظل الأول (0px 2px 4px -2px #0000001A)
              BoxShadow(
                color: const Color(0xFF000000).withOpacity(0.10), // #0000001A
                offset: const Offset(0, 2),
                blurRadius: 4,
                spreadRadius: -2,
              ),
              // الظل الثاني (0px 4px 6px -1px #0000001A)
              BoxShadow(
                color: const Color(0xFF000000).withOpacity(0.10), // #0000001A
                offset: const Offset(0, 4),
                blurRadius: 6,
                spreadRadius: -1,
              ),
            ],


          ),
          padding:
          const EdgeInsets.symmetric(
            vertical: 6,
          ),
          child: Row(
            mainAxisAlignment:
            MainAxisAlignment.center,
            children: [
              SvgAsset(
                Assets
                    .images
                    .svg
                    .home
                    .shoppingCartCheckIn,
                height: 16,
                color:
                context.cardColor,
              ),
              Space.hS2,
              Flexible(
                child: Text(
                  LocaleKeys.homeAddToCart
                      .tr(),
                  style:
                  context.bodyLarge(
                    color:
                    context.cardColor,
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow:
                  TextOverflow
                      .ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
