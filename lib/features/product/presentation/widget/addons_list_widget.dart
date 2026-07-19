import 'package:flutter/material.dart';
import 'package:restaurants_menu/features/cart/presentation/bloc/cart_bloc.dart';
import '../../../../common/models/addon_model.dart';
import '../../../../common/models/product_model.dart';
import 'addons_widget.dart';

class AddonsListWidget extends StatelessWidget {
 final ProductModel productModel;
 final CartBloc cartBloc;
 final List<AddonModel> localeSelectedAddons;

  const AddonsListWidget({super.key, required this.productModel, required this.cartBloc, required this.localeSelectedAddons});



  @override
  Widget build(BuildContext context) {
    return  SliverPadding(
      padding: EdgeInsetsGeometry.only(
        left: 20,
        right: 20,
        bottom: 12,
      ),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
              (context, index) {
                return AddonsWidget(
                cartBloc: cartBloc,
                addonModel: productModel.addons![index],
                productModel: productModel,
                    localeSelectedAddons:localeSelectedAddons
              );
              },
          childCount: productModel.addons?.length ?? 0,
        ),
      ),
    );
  }
}
