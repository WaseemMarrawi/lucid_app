import 'package:dartz/dartz.dart';
import 'package:dio/src/form_data.dart';
import '../../../../common/helper/src/typedef.dart';
import '../../../../common/models/user_model.dart';
import '../../../../core/unified_api/error/error_handeler.dart';
import '../../../auth/data/models/auth_response.dart';
import '../../domain/repositories/user_repositories.dart';
import '../data_sources/user_remote_data.dart';
import '../models/user_model.dart';
import '../models/user_patch_model.dart';
import '../models/user_photos_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: UserRepositories)
class UserRepositoriesImp with HandlingException implements UserRepositories {
  final UserRemoteData _remoteData;

  UserRepositoriesImp({required UserRemoteData remoteData})
    : _remoteData = remoteData;

  @override
  DataResponse<void> userDeleteMe() async =>
      await wrapHandlingException(tryCall: () => _remoteData.userDeleteMe());

  @override
  DataResponse<UserResponse> userGetMe() async =>
      await wrapHandlingException(tryCall: () => _remoteData.userGetMe());

  @override
  DataResponse<UserResponse> userUpdateMe(BodyMap param) async =>
      await wrapHandlingException(
        tryCall: () => _remoteData.userUpdateMe(param),
      );

  @override
  DataResponse<UserResponse> userUpdateProfileImage(FormData param) async =>
      await wrapHandlingException(
        tryCall: () => _remoteData.userUpdateProfileImage(param),
      );
}
