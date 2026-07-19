part of 'cart_bloc.dart';

class CartState {
  final List<ProductModel> cartList;
  final ServiceCartType? selectedService;
  final DataStateModel<void> sentCartData;
  final DataStateModel<OfferCodeResponse?> offerCodeData;
  final double? totalPrice;

  CartState({
    this.cartList = const [],
    this.selectedService,
    this.totalPrice,
    this.sentCartData = const DataStateModel.setDefultValue(defultValue: null),
    this.offerCodeData = const DataStateModel.setDefultValue(defultValue: null),
  });

  CartState copyWith({
    List<ProductModel>? cartList,
    DataStateModel<void>? sentCartData,
    double? totalPrice,
    ServiceCartType? selectedService,
    DataStateModel<OfferCodeResponse?>? offerCodeData,
  }) {
    return CartState(
      cartList: cartList ?? this.cartList,
      sentCartData: sentCartData ?? this.sentCartData,
      totalPrice: totalPrice ?? this.totalPrice,
      selectedService: selectedService ?? this.selectedService,
      offerCodeData: offerCodeData ?? this.offerCodeData,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "cartList": cartList.map((e) => e.toJson()).toList(),
      "totalPrice": totalPrice,
    };
  }

  factory CartState.fromJson(Map<String, dynamic> json) {
    return CartState(
      cartList:
          (json['cartList'] as List<dynamic>?)
              ?.map((e) => ProductModel.fromJson(e))
              .toList() ??
          [],
      totalPrice: json['totalPrice'],
    );
  }
}
