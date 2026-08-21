import 'package:flutter/material.dart';
import 'package:restaurants_menu/common/extensions/extensions.dart';
import '../../../../common/models/addon_model.dart';
import '../widget/product_details_button_widget.dart';
import '../widget/product_details_sliver_app_bar_widget.dart';
import 'package:restaurants_menu/common/models/product_model.dart';
import 'package:restaurants_menu/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:restaurants_menu/features/product/presentation/bloc/product_bloc.dart';

import '../widget/product_gellery_widget.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductDetailsScreenParams args;

  const ProductDetailsScreen({super.key, required this.args});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late final ProductBloc productBloc;
  late final CartBloc cartBloc;
  late final ProductModel productModel;
  late final ScrollController scrollController;
  late final TextEditingController noteController;
  late final List<AddonModel> localeSelectedAddons;


  @override
  void initState() {
    productBloc = widget.args.productBloc;
    cartBloc = widget.args.cartBloc;
    productModel = widget.args.productModel;
    scrollController = ScrollController();
    noteController = TextEditingController();
    final cartItem = cartBloc.state.cartList
        .where((e) => e.id == productModel.id)
        .firstOrNull;

    localeSelectedAddons = cartItem?.selectedAddons ?? [];

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      body:  context.isDesktop
          ? Row(
        children: [

          Expanded(
            child: ProductGalleryWidget(
              gallery:
              productModel.media?.gallery ?? [],
              isFromDecktop: true,
              productId:productModel.id! ,
              video: productModel.media?.productVideo,
            ),
          ),

          Expanded(

            child: Column(
              children: [

                Expanded(
                  child: ProductDetailsContentWidget(
                    productModel: productModel,
                    cartBloc: cartBloc,
                    noteController: noteController,
                    localeSelectedAddons: localeSelectedAddons,
                    scrollController: scrollController,

                  ),
                ),

                SizedBox(
                  width: double.infinity,
                  child: ProductDetailsButtonWidget(
                    productModel: productModel,
                    cartBloc: cartBloc,
                    localeSelectedAddons:
                    localeSelectedAddons,
                  ),
                ),
              ],
            ),
          ),
        ],
      )
          : Column(
        children: [

          Expanded(
            child: ProductDetailsContentWidget(
              productModel: productModel,
              cartBloc: cartBloc,
              noteController: noteController,
              localeSelectedAddons: localeSelectedAddons,
              scrollController: scrollController,
              productBloc: productBloc,

            ),
          ),

          SizedBox(
            width: context.isMobile
                ? context.width
                : context.width * .7,
            child: ProductDetailsButtonWidget(
              productModel: productModel,
              cartBloc: cartBloc,
              localeSelectedAddons:
              localeSelectedAddons,
            ),
          ),
        ],
      ),
    );

  }
}

class ProductDetailsScreenParams {
  final ProductBloc productBloc;
  final CartBloc cartBloc;
  final ProductModel productModel;

  ProductDetailsScreenParams({
    required this.productBloc,
    required this.cartBloc,
    required this.productModel,
  });
}


