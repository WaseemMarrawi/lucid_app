import 'package:flutter/material.dart';
import 'package:restaurants_menu/common/models/media_model.dart';
import '../../../../common/design/src/theme/assets.gen.dart';
import '../../../../common/design/src/theme/const.dart';
import '../../../../common/design/src/widgets/svg_asset.dart';
import '../../../../common/extensions/src/color_extentions.dart';
import '../../../../common/extensions/src/context_extensions.dart';
import '../../../../common/helper/src/locale_keys.dart';
import '../../../../common/models/addon_model.dart';
import '../../../../common/models/product_model.dart';
import '../../../cart/presentation/bloc/cart_bloc.dart';

class ProductDetailsAddButtonWidget extends StatelessWidget {
  final CartBloc cartBloc;
  final ProductModel productModel;
  final List<AddonModel> localeSelectedAddons;


  const ProductDetailsAddButtonWidget({
    super.key,
    required this.cartBloc,
    required this.productModel,
    required this.localeSelectedAddons,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(32),
      onTap: () {
        cartBloc.add(
          EditCartEvent(
            params: ProductModel(
              id: productModel.id,
              count: 1,
              name: productModel.name,
              media: productModel.media,
              externalPrice: productModel.externalPrice,
              internalPrice: productModel.internalPrice,
              selectedAddons: List<AddonModel>.from(
                localeSelectedAddons,
              ),
            ),
          ),
        );
      },
      child: Container(
        width: context.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          gradient: LinearGradient(
            colors: [
              context.primarySwatch.derivedColor,
              context.primarySwatch,
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
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgAsset(
              Assets.images.svg.home.shoppingCartCheckIn,
              height: 16,
              color: context.cardColor,
            ),
            Space.hS2,
            Text(
              LocaleKeys.homeAddToCart.tr(),
              style: context.bodyLarge(fontSize: 14, color: context.cardColor),
            ),
          ],
        ),
      ),
    );
  }
}
