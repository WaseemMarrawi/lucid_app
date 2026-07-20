import 'package:flutter/material.dart';
import 'package:restaurants_menu/common/design/design.dart';
import 'package:restaurants_menu/common/extensions/src/description_extensions.dart';
import 'package:restaurants_menu/common/models/product_model.dart';
import 'package:restaurants_menu/features/cart/presentation/bloc/cart_bloc.dart';
import '../../../../common/extensions/src/context_extensions.dart';
import '../../../../common/helper/src/locale_keys.dart';
import 'cart_type_tap_widget.dart';
import 'change_cart_count_widget.dart';

class CartWidget extends StatelessWidget {
  final ProductModel productModel;
  final CartBloc cartBloc;
  final ServiceCartType selectedType;

  const CartWidget({
    super.key,
    required this.productModel,
    required this.cartBloc,
    required this.selectedType,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      decoration: BoxDecoration(
        // color: context.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.dividerColor),
      ),
      child: Column(
        children: [
          Row(
            children: [
              (productModel.media?.gallery != null&&productModel.media!.gallery!.isNotEmpty)
                  ? CacheNetworkImage(
                      imageUrl: productModel.media!.gallery![0],
                      height: 52,
                      width: 52,
                      borderRadius: BorderRadius.circular(12),
                    )
                  : Assets.images.png.logo.image(width: 52, height: 52),
              Space.hM1,
              SizedBox(
                height: 52,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      productModel.name.getName(),
                      style: context.headlineSmall(fontSize: 16),
                    ),
                    InkWell(
                      onTap: () {
                        cartBloc.add(DeleteFromCartEvent(id: productModel.id!));
                      },
                      child: SvgAsset(
                        Assets.images.svg.trash,
                        color: context.primarySwatch,
                        height: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Space.vS3,
          Row(
            children: [
              ChangeCartCountWidget(
                cartBloc: cartBloc,
                productModel: productModel,
              ),
              Expanded(
                child: Text(
                  '${(productModel.count ?? 1) * ((selectedType.type == ServiceType.internal ? productModel.internalPrice : productModel.externalPrice) ?? 0).round()} ${LocaleKeys.homeCurrency.tr()}',

                  style: context.headlineSmall(
                    fontSize: 16,
                    color: context.primarySwatch,
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
