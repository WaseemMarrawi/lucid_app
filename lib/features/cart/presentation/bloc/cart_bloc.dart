import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:restaurants_menu/common/models/product_model.dart';
import '../../../../common/helper/src/data_state_model.dart';
import '../../../../common/helper/src/locale_keys.dart';
import 'package:injectable/injectable.dart';
import '../../data/model/offer_code_response.dart';
import '../../domin/use_cases/get_offer_code_use_case.dart';
import '../../domin/use_cases/send_cart_use_case.dart';
import '../widgets/cart_type_tap_widget.dart';

part 'cart_event.dart';

part 'cart_state.dart';

@lazySingleton
class CartBloc extends HydratedBloc<CartEvent, CartState> {
  final SendCartUseCase _sendCartUseCase;
  final GetOfferCodeUseCase _getOfferCodeUseCase;

  CartBloc(this._sendCartUseCase, this._getOfferCodeUseCase)
    : super(CartState()) {
    // on<GetCartEvent>(_getCart);
    on<SendCartEvent>(_sendCart);
    on<EditCartEvent>(_editCart);
    on<DeleteFromCartEvent>(_deleteFromCart);
    on<ResetCartDataEvent>(_reset);
    on<InitSelectedServices>(_initSelected);
    on<ChangeSelectedServices>(_changeSelected);
    on<GetOfferCodeEvent>(_getOfferCode);
  }

  FutureOr<void> _getOfferCode(
    GetOfferCodeEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(state.copyWith(offerCodeData: state.offerCodeData.setLoading()));

    final val = await _getOfferCodeUseCase(event.params);

    val.fold(
      (l) {
        emit(
          state.copyWith(
            offerCodeData: state.offerCodeData.setFaild(
              errorMessage: l.message,
            ),
          ),
        );
      },
      (r) {
        emit(
          state.copyWith(
            offerCodeData: state.offerCodeData.setSuccess(data: r),
          ),
        );
      },
    );

    if (emit.isDone) return;

    emit(state.copyWith( offerCodeData: state.offerCodeData.resetData()));
  }

  FutureOr<void> _initSelected(
    InitSelectedServices event,
    Emitter<CartState> emit,
  ) async {
    final selected = ServiceCartType(
      name: LocaleKeys.homeDineIn.tr(),
      type: ServiceType.internal,
    );

    final total = state.cartList.fold<double>(
      0,
      (sum, e) =>
          sum +
          (((selected.type == ServiceType.internal
                      ? e.internalPrice
                      : e.externalPrice) ??
                  0) *
              (e.count ?? 1)),
    );

    emit(state.copyWith(selectedService: selected, totalPrice: total));
  }

  FutureOr<void> _changeSelected(
    ChangeSelectedServices event,
    Emitter<CartState> emit,
  ) async {
    final newState = state.copyWith(selectedService: event.serviceCartType);

    final total = newState.cartList.fold<double>(
      0,
      (sum, e) =>
          sum +
          (((event.serviceCartType.type == ServiceType.internal
                      ? e.internalPrice
                      : e.externalPrice) ??
                  0) *
              (e.count ?? 1)),
    );

    emit(newState.copyWith(totalPrice: total));
  }

  FutureOr<void> _reset(
    ResetCartDataEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(state.copyWith(cartList: [], totalPrice: 0));
  }

  FutureOr<void> _editCart(EditCartEvent event, Emitter<CartState> emit) async {
    final inCart = state.cartList.any((e) => e.id == event.params.id);

    final list = inCart
        ? state.cartList
              .map(
                (e) => e.id == event.params.id
                    ? e.copyWith(
                        count: event.params.count,
                        selectedAddons: event.params.selectedAddons,
                      )
                    : e,
              )
              .toList()
        : (List<ProductModel>.from(state.cartList)
            ..add(event.params.copyWith(count: 1)));

    final total = list.fold<double>(
      0,
      (sum, e) =>
          sum +
          (((state.selectedService?.type == ServiceType.internal
                      ? e.internalPrice
                      : e.externalPrice) ??
                  0) *
              (e.count ?? 1)),
    );

    emit(state.copyWith(cartList: list, totalPrice: total));
  }

  FutureOr<void> _deleteFromCart(
    DeleteFromCartEvent event,
    Emitter<CartState> emit,
  ) async {
    final List<ProductModel> list = List.from(
      state.cartList.where((e) => e.id != event.id).toList(),
    );
    final total = list.fold<double>(
      0,
      (sum, e) =>
          sum +
          (((state.selectedService?.type == ServiceType.internal
                      ? e.internalPrice
                      : e.externalPrice) ??
                  0) *
              (e.count ?? 1)),
    );
    emit(state.copyWith(cartList: list, totalPrice: total));
  }

  FutureOr<void> _sendCart(SendCartEvent event, Emitter<CartState> emit) async {
    emit(state.copyWith(sentCartData: state.sentCartData.setLoading()));

    final val = await _sendCartUseCase(
      SendCartParams(
        elements: state.cartList,
        type: event.params.type,
        note: event.params.note,
        customerName: event.params.customerName,
        customerPhone: event.params.customerPhone,
        locationDetails: event.params.locationDetails,
        offerCode: event.params.offerCode,
        tableNumber: event.params.tableNumber,
      ),
    );

    val.fold(
      (l) {
        emit(
          state.copyWith(
            sentCartData: state.sentCartData.setFaild(errorMessage: l.message),
          ),
        );
      },
      (r) {
        emit(
          state.copyWith(sentCartData: state.sentCartData.setSuccess(data: r)),
        );
      },
    );
  }

  // FutureOr<void> _getCart(GetCartEvent event, Emitter<CartState> emit) async {
  //   emit(state.copyWith(cartList: state.cartList));
  // }

  @override
  CartState? fromJson(Map<String, dynamic> json) {
    try {
      debugPrint('FROM JSON => $json');

      final state = CartState.fromJson(json);

      debugPrint('PARSED SUCCESS');

      return state;
    } catch (e, s) {
      debugPrint('FROM JSON ERROR => $e');
      debugPrintStack(stackTrace: s);
      return CartState();
    }
  }

  @override
  Map<String, dynamic>? toJson(CartState state) {
    final data = state.toJson();
    print('TO JSON => $data');
    return data;
  }
}
