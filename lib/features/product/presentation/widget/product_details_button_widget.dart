import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurants_menu/common/extensions/extensions.dart';
import 'package:restaurants_menu/common/models/product_model.dart';
import '../../../../common/models/addon_model.dart';
import '../../../cart/presentation/bloc/cart_bloc.dart';
import 'product_details_add_button_widget.dart';
import 'product_details_count_widget.dart';

class ProductDetailsButtonWidget extends StatelessWidget {
  final CartBloc cartBloc;
  final ProductModel productModel;
   final List<AddonModel> localeSelectedAddons;
  const ProductDetailsButtonWidget({
    super.key,
    required this.cartBloc,
    required this.productModel,
    required this.localeSelectedAddons,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      bloc: cartBloc,
      builder: (context, state) {
        final bool isInCart = state.cartList.any(
          (e) => e.id == productModel.id,
        );

        return Padding(
          padding:  EdgeInsets.only(
            left: 20,
            right: 20,
            bottom:context.navigationBarHeight+8,
            top: 4,
          ),
          child: AnimatedSwitcher(
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
                ? ProductDetailsCountWidget(
                    productModel: productModel,
                    cartBloc: cartBloc,
                localeSelectedAddons:localeSelectedAddons
                  )
                : ProductDetailsAddButtonWidget(
                    cartBloc: cartBloc,
                    productModel: productModel,
              localeSelectedAddons: localeSelectedAddons,
                  ),
          ),
        );
      },
    );
  }
}


