import 'package:injectable/injectable.dart';
import '../../../../common/helper/src/typedef.dart';
import '../../../../common/models/product_model.dart';
import '../../../../core/use_case/use_case.dart';
import '../../data/model/offer_code_response.dart';
import '../repositories/cart_repositores.dart';

@lazySingleton
class GetOfferCodeUseCase implements UseCase<OfferCodeResponse, GetOfferCodeParams> {
  final CartRepositories _repositories;

  GetOfferCodeUseCase({required CartRepositories repositories})
      : _repositories = repositories;

  @override
  DataResponse<OfferCodeResponse> call(GetOfferCodeParams params) async =>
      await _repositories.getOfferCode(params.getBody());
}

class GetOfferCodeParams with Params {
  final String offerCode;
  final double orderValue;

  GetOfferCodeParams({required this.offerCode, required this.orderValue});

  @override
  BodyMap getBody() {
    return {
    'offer_code':offerCode,
    'order_value':orderValue,

    }..removeWhere((key, value) => value == null || value == ''||value=='null');
  }
}
