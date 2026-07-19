import 'dart:io';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../../common/helper/src/typedef.dart';
import '../../../../common/models/user_model.dart';
import '../../../../core/use_case/use_case.dart';

import '../../data/models/user_model.dart';
import '../repositories/user_repositories.dart';

@lazySingleton
class UserUpdateProfileImageUseCases
    implements UseCase<UserResponse, UserUpdateProfileImageParams> {
  final UserRepositories _repositories;

  UserUpdateProfileImageUseCases({required UserRepositories repositories})
    : _repositories = repositories;

  @override
  DataResponse<UserResponse> call(UserUpdateProfileImageParams params) async =>
      await _repositories.userUpdateProfileImage(params.getFormData());
}

class UserUpdateProfileImageParams with Params {
  final File image;

  UserUpdateProfileImageParams({required this.image});

  FormData getFormData() {
    return FormData.fromMap({
      'profileImage': MultipartFile.fromFileSync(
        image.path,
        contentType: DioMediaType('image', 'jpeg'),
      ),
    });
  }
}
