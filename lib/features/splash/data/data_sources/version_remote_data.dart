import '../../../../common/helper/src/typedef.dart';
import '../../../../core/unified_api/api_variables.dart';
import '../../../../core/unified_api/dio/api_client.dart';
import '../../../../core/unified_api/error/api_handeler_manager.dart';
import '../models/get_version_response.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class VersionRemoteData with HandlingApiManager {
  final ApiClient _apiClient;

  VersionRemoteData({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<GetVersionResponse> getVersion(BodyMap params) async {
    return wrapHandlingApi(
      tryCall: () => _apiClient.post(ApiVariables.getVersion(),data:  params),
      jsonConvert: getVersionResponseFromJson,
    );
  }
}
