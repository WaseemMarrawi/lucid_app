part of 'cart_bloc.dart';

sealed class CartEvent {}

// class GetCartEvent extends CartEvent  {}

class SendCartEvent extends CartEvent{
  final SendCartParams params;

  SendCartEvent({required this.params});
}

class ResetCartDataEvent extends CartEvent {}


class EditCartEvent extends CartEvent {
  final ProductModel params;
  EditCartEvent({required this.params});
}

class DeleteFromCartEvent extends CartEvent {
  final int id;

  DeleteFromCartEvent({required this.id});
}

class InitSelectedServices extends CartEvent{}



class ChangeSelectedServices extends CartEvent{
  final ServiceCartType serviceCartType;

  ChangeSelectedServices({required this.serviceCartType});
}


class GetOfferCodeEvent extends CartEvent{
  final GetOfferCodeParams params;

  GetOfferCodeEvent({required this.params});

}


