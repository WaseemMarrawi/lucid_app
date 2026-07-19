import '../../../../core/unified_api/api_variables.dart';
import '../../../../core/unified_api/dio/api_client.dart';
import '../../../../core/unified_api/error/api_handeler_manager.dart';
import '../../domin/use_cases/review_service_use_case.dart';
import 'package:injectable/injectable.dart';

import '../model/review_response.dart';

@lazySingleton
class ReviewDataSource with HandlingApiManager {
  final ApiClient _apiClient;

  ReviewDataSource({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<ReviewResponse> reviewService(ReviewServiceParams params) async =>
      wrapHandlingApi(
        tryCall: () => _apiClient.post(
          ApiVariables.reviewService(),
          data: params.getBody(),
        ),
        jsonConvert: reviewServiceResponseFromJson,
      );
}
