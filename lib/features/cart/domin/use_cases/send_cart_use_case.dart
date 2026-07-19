import 'package:injectable/injectable.dart';
import '../../../../common/helper/src/typedef.dart';
import '../../../../common/models/cart_product_model.dart';
import '../../../../common/models/product_model.dart';
import '../../../../core/use_case/use_case.dart';
import '../repositories/cart_repositores.dart';

@lazySingleton
class SendCartUseCase implements UseCase<void, SendCartParams> {
  final CartRepositories _repositories;

  SendCartUseCase({required CartRepositories repositories})
    : _repositories = repositories;

  @override
  DataResponse<void> call(SendCartParams body) async =>
      await _repositories.sendCart(body.getBody());
}

class SendCartParams with Params {
  final List<ProductModel> elements;
  final String? note;
  final String? type;
  final String? customerName;
  final String? customerPhone;
  final String? locationDetails;
  final String? offerCode;
  final String? tableNumber;

  SendCartParams({
    required this.elements,
    required this.note,
    required this.type,
    required this.customerName,
    required this.customerPhone,
    required this.locationDetails,
    required this.offerCode,
    required this.tableNumber,
  });

  @override
  BodyMap getBody() {
    return {
      "type": type,
      "table_number": tableNumber,
      "customer_name": customerName,
      "customer_phone": customerPhone,
      "location_details": locationDetails,
      "offer_code": offerCode,
      "notes": note,
      "items": elements.map((e) => e.toApi()).toList(),

    }..removeWhere((key, value) => value == null || value == ''||value=='null');
  }
}
