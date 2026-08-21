import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurants_menu/common/design/design.dart';
import 'package:restaurants_menu/common/design/src/widgets/animation_widget/animated_sub_text_widget.dart';
import 'package:restaurants_menu/common/design/src/widgets/animation_widget/animated_title_text_widget.dart';
import 'package:restaurants_menu/features/cart/presentation/pages/cart_submitted_screen.dart';
import 'package:restaurants_menu/features/cart/presentation/widgets/cart_widget.dart';
import 'package:restaurants_menu/router/app_router.dart';
import '../../../../common/design/src/widgets/animation_widget/animated_scale_widget.dart';
import '../../../../common/extensions/src/context_extensions.dart';
import '../../../../common/helper/src/locale_keys.dart';
import '../../../home/presentation/widgets/home_widgets/home_empty_sliver_widget.dart';
import '../bloc/cart_bloc.dart';
import '../widgets/cart_sliver_app_bar_widget.dart';
import '../widgets/cart_type_tap_widget.dart';

class CartScreen extends StatefulWidget {
  final CartScreenParams arg;

  const CartScreen({super.key, required this.arg});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late final CartBloc cartBloc;

  @override
  void initState() {
    cartBloc = widget.arg.cartBloc;

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CartBloc, CartState>(
        bloc: cartBloc,
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    CartSliverAppBarWidget(),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            Space.vM1,
                            Row(
                              children: [
                                AnimatedTitleTextWidget(
                                  child: Align(
                                    alignment: AlignmentDirectional.centerStart,
                                    child: Text(
                                      LocaleKeys.homeCart.tr(),
                                      style: context.headlineSmall(fontSize: 24),
                                    ),
                                  ),
                                ),
                                Spacer(),

                               state.cartList.isNotEmpty?
                                InkWell(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (context) {
                                        return AlertDialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(16),
                                          ),
                                          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
                                          contentPadding: const EdgeInsets.all(24),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                LocaleKeys.clearCartTitle.tr(),
                                                style: context.headlineSmall(fontSize: 18),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(top: 8, bottom: 16),
                                                child: Text(
                                                  LocaleKeys.clearCartDescription.tr(),
                                                  style: context.bodyMedium(
                                                    fontSize: 14,
                                                    color: context.textColor,
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: ElevatedButton(
                                                      style: ElevatedButton.styleFrom(
                                                        backgroundColor: Colors.white,
                                                        side: BorderSide(
                                                          width: 1,
                                                          color: context.primarySwatch,
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.of(context).pop(false);
                                                      },
                                                      child: Text(
                                                        LocaleKeys.clearCartCancel.tr(),
                                                        style: context.bodyMedium(fontSize: 14),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Expanded(
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.of(context).pop(true);
                                                        cartBloc.add(ResetCartDataEvent());
                                                      },
                                                      child: Text(
                                                        LocaleKeys.clearCartConfirm.tr(),
                                                        style: context.bodyMedium(
                                                          color: Colors.white,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: SvgAsset(
                                    Assets.images.svg.trash,
                                    color: context.primarySwatch,
                                    height: 30,
                                  ),
                                ):SizedBox(),

                              ],
                            ),
                            Space.vM1,

                            AnimatedSubTextWidget(
                              child: Row(
                                children: [
                                  Text(
                                    LocaleKeys.homeSelectOrderType.tr(),
                                    //'Hello',
                                    style: context.bodyLarge(fontSize: 16),
                                  ),
                                  Space.hS2,
                                  Text(
                                    LocaleKeys.homeRequired.tr(),
                                    //'Hello',
                                    style: context.bodyLarge(
                                      fontSize: 12,
                                      color: context.errorColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Space.vS3,
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: AnimatedScaleWidget(
                          child: CartTypeTapWidget(
                            selectedIndex: state.selectedService!,
                            cartBloc: cartBloc,
                          ),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(child: Space.vS3),

                    state.cartList.isEmpty
                        ? HomeEmptySliverWidget(
                            title: LocaleKeys.noData.tr(
                              namedArgs: {"data": LocaleKeys.data.tr()},
                            ),
                            subTitle: LocaleKeys.cartEmpty.tr(),
                          )
                        : SliverList.builder(
                            itemBuilder: (context, index) {
                              return CartWidget(
                                productModel: state.cartList[index],
                                cartBloc: cartBloc,
                                selectedType: state.selectedService!,
                              );
                            },
                            itemCount: state.cartList.length,
                          ),
                  ],
                ),
              ),
              Container(
                // color: context.cardColor,
                child: Column(
                  children: [
                    Divider(height: 1),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 20,
                        right: 20,
                        bottom: context.navigationBarHeight + 10,
                        top: 10,
                      ),
                      child: AnimatedScaleWidget(
                        child: SizedBox(
                          width: context.isMobile
                              ? context.width
                              : context.isTablet
                              ? context.width * .7
                              : context.width * .5,
                          child: ElevatedButton(
                            onPressed: () {
                              if (state.cartList.isNotEmpty) {
                                context.pushNamed(
                                  RouteName.cartSubmitted,
                                  arguments: CartSubmittedScreenParams(
                                    cartBloc: cartBloc,
                                  ),
                                );
                              } else {
                                Toaster.showCustomErrorToast(
                                  message: LocaleKeys.cartEmptyMessage.tr(),
                                );
                              }

                              //selectedIndex
                            },
                            child: Text(
                              LocaleKeys.homeNextWithPrice.tr(
                                namedArgs: {
                                  "value": '${state.totalPrice?.round() ?? 0}',
                                },
                              ),
                              style: context.bodyLarge(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            ],
          );
        },
      ),
    );
  }
}

class CartScreenParams {
  final CartBloc cartBloc;

  CartScreenParams({required this.cartBloc});
}
