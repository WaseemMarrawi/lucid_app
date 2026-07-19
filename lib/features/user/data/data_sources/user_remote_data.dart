import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../common/helper/src/typedef.dart';
import '../../../../common/models/user_model.dart';
import '../../../../core/unified_api/api_variables.dart';
import '../../../../core/unified_api/dio/api_client.dart';
import '../../../../core/unified_api/error/api_handeler_manager.dart';
import '../../../auth/data/models/auth_response.dart';
import '../models/user_model.dart';
import '../models/user_patch_model.dart';
import '../models/user_photos_model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UserRemoteData with HandlingApiManager {
  final ApiClient _apiClient;

  UserRemoteData({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<UserResponse> userGetMe() async => wrapHandlingApi(
    tryCall: () => _apiClient.get(ApiVariables.getMe()),
    jsonConvert: userResponseFromJson,
  );

  Future<UserResponse> userUpdateMe(BodyMap params) async => wrapHandlingApi(
    tryCall: () => _apiClient.put(ApiVariables.updateMe(), data: params),
    jsonConvert: userResponseFromJson,
  );

  Future<UserResponse> userUpdateProfileImage(FormData param) async =>
      wrapHandlingApi(
        tryCall: () =>
            _apiClient.post(ApiVariables.postProfileImage(), data: param),
        jsonConvert: userResponseFromJson,
      );

  Future<void> userDeleteMe() async => wrapHandlingApi(
    tryCall: () => _apiClient.get(ApiVariables.deleteMe()),
    jsonConvert: (_) {},
  );
}
