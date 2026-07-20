import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurants_menu/common/design/design.dart';
import 'package:restaurants_menu/features/cart/domin/use_cases/get_offer_code_use_case.dart';
import 'package:restaurants_menu/router/app_router.dart';
import '../../../../common/extensions/src/color_extentions.dart';
import '../../../../common/extensions/src/context_extensions.dart';
import '../../../../common/extensions/src/validation.dart';
import '../../../../common/helper/src/locale_keys.dart';
import '../../domin/use_cases/send_cart_use_case.dart';
import '../bloc/cart_bloc.dart';
import '../widgets/cart_sliver_app_bar_widget.dart';
import '../widgets/cart_type_tap_widget.dart';

class CartSubmittedScreen extends StatefulWidget {
  final CartSubmittedScreenParams arg;

  const CartSubmittedScreen({super.key, required this.arg});

  @override
  State<CartSubmittedScreen> createState() => _CartSubmittedScreenState();
}

class _CartSubmittedScreenState extends State<CartSubmittedScreen> {
  late final ValueNotifier<bool> isHavePromoCode;

  late final TextEditingController offerCodeController;

  late final TextEditingController tableNumberController;

  late final TextEditingController noteController;

  late final TextEditingController nameController;

  late final TextEditingController phoneController;

  late final TextEditingController locationController;

  late final FocusNode offerCodeFocus;

  late final FocusNode tableFocus;

  late final FocusNode noteFocus;

  late final FocusNode nameFocus;

  late final FocusNode phoneFocus;

  late final FocusNode locationFocus;

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _offerCode = GlobalKey<FormState>();

 late final ValueNotifier<double?> priceNotifier;

  @override
  void initState() {
    isHavePromoCode = ValueNotifier(false);

    tableNumberController = TextEditingController();
    offerCodeController = TextEditingController();
    noteController = TextEditingController();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    locationController = TextEditingController();

    priceNotifier=ValueNotifier(widget.arg.cartBloc.state.totalPrice);

    ///
    offerCodeFocus = FocusNode();
    tableFocus = FocusNode();
    noteFocus = FocusNode();
    nameFocus = FocusNode();
    phoneFocus = FocusNode();
    locationFocus = FocusNode();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _globalKey,
        child: MultiBlocListener(
          listeners: [
            BlocListener<CartBloc, CartState>(
              bloc: widget.arg.cartBloc,
              listenWhen: (pre, cur) =>
                  pre.sentCartData.status != cur.sentCartData.status,
              listener: (context, state) {
                state.sentCartData.listenerFunction(
                  onSuccess: () {
                    widget.arg.cartBloc.add(ResetCartDataEvent());
                    context.popUntilPage(routeName: RouteName.home);
                  },
                );
              },
            ),
            BlocListener<CartBloc, CartState>(
              bloc: widget.arg.cartBloc,
              listenWhen: (pre, cur) =>
                  pre.offerCodeData.status != cur.offerCodeData.status,
              listener: (context, state) {
                state.offerCodeData.listenerFunction(
                    onSuccess: () {
                  priceNotifier.value=state.offerCodeData.data?.data?.total;

                },
                onFailed: (){
                  priceNotifier.value=state.totalPrice;

                }
                );
              },
            ),
          ],

          child: BlocBuilder<CartBloc, CartState>(
            bloc: widget.arg.cartBloc,
            builder: (context, state) {
              return CustomScrollView(
                slivers: [
                  CartSliverAppBarWidget(),
                  SliverToBoxAdapter(
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Space.vM1,
                            Align(
                              alignment: AlignmentDirectional.centerStart,
                              child: Text(
                                LocaleKeys.confirmFinalInvoice.tr(),
                                style: context.headlineSmall(fontSize: 24),
                              ),
                            ),

                            Space.vM1,
                          ],
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Center(
                      child: Container(
                        width: context.isDesktop ? context.width * .7 : null,
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: context.dividerColor),
                          // color: context.cardColor,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              LocaleKeys.finalCost.tr(),
                              style: context.headlineSmall(fontSize: 20),
                            ),
                            Space.vS3,
                            Row(
                              children: [
                                ValueListenableBuilder(
                                  valueListenable: isHavePromoCode,
                                  builder: (context, value, child) {
                                    return InkWell(
                                      borderRadius: BorderRadius.circular(100),
                                      onTap: () {
                                        isHavePromoCode.value = !value;
                                      },
                                      child: Radio<bool>(
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        visualDensity: const VisualDensity(
                                          horizontal: -4,
                                          vertical: -4,
                                        ),
                                        value: true,
                                        toggleable: true,
                                        groupValue: value ? true : null,
                                        onChanged: (_) {
                                          isHavePromoCode.value = !value;
                                        },
                                      ),
                                    );
                                  },
                                ),
                                Space.hS3,
                                Text(
                                  LocaleKeys.iHavePromoCode.tr(),
                                  style: context.bodyLarge(fontSize: 16),
                                ),
                              ],
                            ),
                            Space.vM1,
                            ValueListenableBuilder<bool>(
                              valueListenable: isHavePromoCode,
                              builder: (context, value, child) {
                                return AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 300),
                                  switchInCurve: Curves.easeOut,
                                  switchOutCurve: Curves.easeIn,
                                  transitionBuilder: (child, animation) {
                                    return SizeTransition(
                                      sizeFactor: animation,
                                      axisAlignment: -1,
                                      child: FadeTransition(
                                        opacity: animation,
                                        child: child,
                                      ),
                                    );
                                  },
                                  child: value
                                      ? Form(
                                          key: _offerCode,
                                          child: Column(
                                            key: const ValueKey(
                                              'promo_visible',
                                            ),
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    LocaleKeys.promoCode.tr(),
                                                    style: context.bodyLarge(
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  Space.hS2,
                                                  Text(
                                                    LocaleKeys.required.tr(),
                                                    style: context.bodyMedium(
                                                      fontSize: 12,
                                                      color: context.errorColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Space.vS3,
                                              MyAppTextField(
                                                controller: offerCodeController,
                                                isPadding: false,
                                                textInputAction:
                                                    TextInputAction.next,
                                                validator: (text) =>
                                                    text.isNameText,
                                                keyboardType:
                                                    TextInputType.name,
                                                focus: offerCodeFocus,
                                                onSubmitted: (_) {
                                                  FocusScope.of(
                                                    context,
                                                  ).requestFocus(
                                                    state
                                                                .selectedService!
                                                                .type ==
                                                            ServiceType.internal
                                                        ? tableFocus
                                                        : nameFocus,
                                                  );
                                                },
                                              ),
                                              Space.vM1,
                                              SizedBox(
                                                width: context.width,
                                                child: ElevatedButton(
                                                  onPressed: () async {
                                                    if (!(_offerCode
                                                            .currentState
                                                            ?.validate() ??
                                                        false)) {
                                                      return;
                                                    }

                                                    widget.arg.cartBloc.add(
                                                      GetOfferCodeEvent(
                                                        params: GetOfferCodeParams(
                                                          offerCode:
                                                              offerCodeController
                                                                  .text
                                                                  .trim(),
                                                          orderValue:
                                                              state
                                                                  .totalPrice ??
                                                              0,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  child: Text(
                                                    LocaleKeys.authConfirm.tr(),
                                                    style: context
                                                        .headlineSmall(
                                                          fontSize: 16,
                                                          color:
                                                              context.cardColor,
                                                        ),
                                                  ),
                                                ),
                                              ),

                                            ],
                                          ),
                                        )
                                      : const SizedBox(
                                          key: ValueKey('promo_hidden'),
                                        ),
                                );
                              },
                            ),
                            Space.vM1,
                            const Divider(height: 1),
                            Space.vM1,
                            Row(
                              children: [
                                Text(
                                  LocaleKeys.subtotal.tr(),
                                  style: context.headlineSmall(fontSize: 16),
                                ),
                                Expanded(
                                  child: ValueListenableBuilder(
                                    valueListenable: priceNotifier,
                                    builder: (context, value, child) {
                                      return Text(
                                        LocaleKeys.priceValue.tr(
                                          namedArgs: {
                                            "value":
                                                '${priceNotifier.value?.round()??0}',
                                          },
                                        ),
                                        style: context.headlineSmall(
                                          fontSize: 16,
                                          color: context.primarySwatch,
                                        ),
                                        textAlign: .end,
                                      );
                                    }
                                  ),
                                ),
                              ],
                            ),
                            Space.vS3,
                            Column(
                              crossAxisAlignment: .start,
                              children:
                                  state.selectedService!.type ==
                                      ServiceType.internal
                                  ? [
                                      Row(
                                        children: [
                                          Text(
                                            LocaleKeys.enterTableNumber.tr(),
                                            style: context.bodyLarge(
                                              fontSize: 16,
                                            ),
                                          ),
                                          Space.hS2,
                                          Text(
                                            LocaleKeys.required.tr(),
                                            style: context.bodyMedium(
                                              fontSize: 12,
                                              color: context.errorColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Space.vS3,
                                      MyAppTextField(
                                        isPadding: false,
                                        controller: tableNumberController,
                                        textInputAction: TextInputAction.next,
                                        validator: (text) => text.isNameText,
                                        keyboardType: TextInputType.name,
                                        focus: tableFocus,
                                        onSubmitted: (_) {
                                          FocusScope.of(
                                            context,
                                          ).requestFocus(noteFocus);
                                        },
                                      ),
                                      Space.vS3,
                                    ]
                                  : [
                                      Row(
                                        children: [
                                          Text(
                                            LocaleKeys.name.tr(),
                                            style: context.bodyLarge(
                                              fontSize: 16,
                                            ),
                                          ),
                                          Space.hS2,
                                          Text(
                                            LocaleKeys.required.tr(),
                                            style: context.bodyMedium(
                                              fontSize: 12,
                                              color: context.errorColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Space.vS3,
                                      MyAppTextField(
                                        controller: nameController,
                                        isPadding: false,
                                        textInputAction: TextInputAction.next,
                                        validator: (text) => text.isNameText,
                                        keyboardType: TextInputType.name,
                                        focus: nameFocus,
                                        onSubmitted: (_) {
                                          FocusScope.of(
                                            context,
                                          ).requestFocus(phoneFocus);
                                        },
                                      ),
                                      Space.vS3,
                                      Row(
                                        children: [
                                          Text(
                                            LocaleKeys.cartPhoneNumber.tr(),
                                            style: context.bodyLarge(
                                              fontSize: 16,
                                            ),
                                          ),
                                          Space.hS2,
                                          Text(
                                            LocaleKeys.required.tr(),
                                            style: context.bodyMedium(
                                              fontSize: 12,
                                              color: context.errorColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Space.vS3,
                                      MyAppTextField(
                                        controller: phoneController,
                                        isPadding: false,
                                        textInputAction: TextInputAction.next,
                                        validator: (text) => text.isPhoneNumber,
                                        keyboardType: TextInputType.name,
                                        focus: phoneFocus,
                                        onSubmitted: (_) {
                                          FocusScope.of(
                                            context,
                                          ).requestFocus(locationFocus);
                                        },
                                      ),
                                      Space.vS3,
                                      Row(
                                        children: [
                                          Text(
                                            LocaleKeys.detailedLocation.tr(),
                                            style: context.bodyLarge(
                                              fontSize: 16,
                                            ),
                                          ),
                                          Space.hS2,
                                          Text(
                                            LocaleKeys.required.tr(),
                                            style: context.bodyMedium(
                                              fontSize: 12,
                                              color: context.errorColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Space.vS3,
                                      MyAppTextField(
                                        controller: locationController,
                                        isPadding: false,
                                        textInputAction: TextInputAction.next,
                                        validator: (text) => text.isNameText,
                                        keyboardType: TextInputType.name,
                                        focus: locationFocus,
                                        onSubmitted: (_) {
                                          FocusScope.of(
                                            context,
                                          ).requestFocus(noteFocus);
                                        },
                                      ),
                                    ],
                            ),

                            Space.vS3,
                            Text(
                              LocaleKeys.otherNotes.tr(),
                              style: context.bodyLarge(fontSize: 16),
                            ),
                            Space.vS3,
                            MyAppTextField(
                              isPadding: false,
                              controller: noteController,
                              maxLines: 6,
                              minLines: 6,
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.done,

                              focus: noteFocus,
                              onSubmitted: (_) {
                                noteFocus.unfocus();
                              },
                            ),
                            Space.vS3,
                            SizedBox(
                              child: InkWell(
                                borderRadius: BorderRadius.circular(32),
                                onTap: () async {
                                  if (!(_globalKey.currentState?.validate() ??
                                      false)) {
                                    return;
                                  }

                                  widget.arg.cartBloc.add(
                                    SendCartEvent(
                                      params: SendCartParams(
                                        customerName: nameController.text,
                                        customerPhone: phoneController.text,
                                        elements: state.cartList,
                                        locationDetails:
                                            locationController.text,
                                        note: noteController.text,
                                        offerCode: offerCodeController.text.trim(),
                                        tableNumber: tableNumberController.text,
                                        type: state.selectedService!.type.name,
                                      ),
                                    ),
                                  );
                                },
                                
                                child: Container(
                                  width: context.width,
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        context.primarySwatch.derivedColor,
                                      context.primarySwatch,
                                    ],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,

                                    ),
                                    borderRadius: BorderRadius.circular(32),
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
                                  
                                  child: Center(
                                    child: Text(
                                      LocaleKeys.submitOrder.tr(),
                                      style: context.headlineSmall(
                                        fontSize: 16,
                                        color: context.cardColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Space.vS3,

                            Container(
                              width: context.width,
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: context.primarySwatch.withOpacity(.1),
                                borderRadius: .circular(12),
                              ),
                              child: Text(
                                state.selectedService!.type ==
                                        ServiceType.internal
                                    ? LocaleKeys.manualPaymentAtCashier.tr()
                                    : LocaleKeys.manualPaymentOnDelivery.tr(),
                                style: context.headlineSmall(
                                  fontSize: 16,
                                  color: context.primarySwatch,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class CartSubmittedScreenParams {
  final CartBloc cartBloc;

  CartSubmittedScreenParams({required this.cartBloc});
}


