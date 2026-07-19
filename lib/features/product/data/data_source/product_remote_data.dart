import 'package:injectable/injectable.dart';
import '../../../../core/unified_api/api_variables.dart';
import '../../../../core/unified_api/dio/api_client.dart';
import '../../../../core/unified_api/error/api_handeler_manager.dart';
import '../model/get_all_product_response.dart';

@lazySingleton
class ProductRemoteData with HandlingApiManager {
  final ApiClient _apiClient;

  ProductRemoteData({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<GetAllProductResponse> getAllProduct() async {
    return wrapHandlingApi(
      tryCall: () => _apiClient.get(ApiVariables.getAllProduct()),
      jsonConvert: getAllProductResponseFromJson,
    );
  }


}
