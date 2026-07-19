import '../../../../common/helper/src/typedef.dart';
import '../../../../core/unified_api/api_variables.dart';
import '../../../../core/unified_api/dio/api_client.dart';
import '../../../../core/unified_api/error/api_handeler_manager.dart';
import 'package:injectable/injectable.dart';

import '../model/offer_code_response.dart';

@lazySingleton
class CartRemoteData with HandlingApiManager {
  final ApiClient _apiClient;

  CartRemoteData({required ApiClient apiClient}) : _apiClient = apiClient;


  Future<void> sendCart(BodyMap params)
  async {
  return wrapHandlingApi(
    tryCall: () => _apiClient.post(ApiVariables.sendCart(),data: params),
    jsonConvert: (_){},
  );
}

  Future<OfferCodeResponse> getOfferCode(BodyMap params)

  async {
    return wrapHandlingApi(
      tryCall: () => _apiClient.post(ApiVariables.offerCode(),data: params),
      jsonConvert:offerCodeResponseFromJson
    );
  }


}
