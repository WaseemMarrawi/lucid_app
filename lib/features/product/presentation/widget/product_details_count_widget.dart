import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';
import '../../../../common/design/src/theme/assets.gen.dart';
import '../../../../common/design/src/widgets/svg_asset.dart';
import '../../../../common/extensions/src/color_extentions.dart';
import '../../../../common/extensions/src/context_extensions.dart';
import '../../../../common/models/addon_model.dart';
import '../../../../common/models/product_model.dart';
import '../../../cart/presentation/bloc/cart_bloc.dart';

class ProductDetailsCountWidget extends StatelessWidget {
  final ProductModel productModel;
  final CartBloc cartBloc;
  final List<AddonModel> localeSelectedAddons;

  const ProductDetailsCountWidget({
    super.key,
    required this.productModel,
    required this.cartBloc,
    required this.localeSelectedAddons,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      key: ValueKey("in_cart_${productModel.id}"),
      margin: const EdgeInsets.only(top: 6),
      child: IntrinsicHeight(
        child: Row(
          children: [
            InkWell(
              onTap: () {
                cartBloc.add(DeleteFromCartEvent(id: productModel.id!));
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  // color: context.cardColor,
                  border: Border.all(color: context.primarySwatch),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Center(
                  child: SvgAsset(
                    Assets.images.svg.trash,
                    color: context.primarySwatch,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: BlocBuilder<CartBloc, CartState>(
                bloc: cartBloc,
                builder: (context, state) {
                  final result = state.cartList.firstWhereOrNull(
                        (e) => e.id == productModel.id,
                  );
                  return result == null
                      ? SizedBox.shrink()
                      : Container(
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
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: result.count! >= 2
                                ? () {
                              final val = result.count! - 1;

                              cartBloc.add(
                                EditCartEvent(
                                  params: productModel.copyWith(
                                    count: val,
                                    selectedAddons: localeSelectedAddons
                                  ),

                                ),
                              );
                            }
                                :(){
                              cartBloc.add(DeleteFromCartEvent(id: productModel.id!));

                            },
                            child: Container(
                              padding: EdgeInsetsGeometry.symmetric(
                                vertical: 10,
                              ),
                              child: Icon(
                                Icons.remove,
                                color: context.cardColor,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex:2,
                          child: Padding(

                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                            ),
                            child: Text(
                              result.count.toString(),
                              style: context.bodyLarge(
                                color: context.cardColor,
                                fontSize: 16,
                              ),
                              textAlign: .center,
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            child: Container(
                              padding: EdgeInsetsGeometry.symmetric(
                                vertical: 10,
                              ),

                              child: Icon(
                                Icons.add_outlined,
                                color: context.cardColor,
                                size: 20,
                              ),
                            ),
                            onTap: () {
                              if (result.count! < 99) {
                                final val = result.count! + 1;

                                cartBloc.add(
                                  EditCartEvent(
                                    params: productModel.copyWith(
                                      count: val,
                                      selectedAddons: localeSelectedAddons

                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

          ],
        ),
      ),
    );
  }
}
