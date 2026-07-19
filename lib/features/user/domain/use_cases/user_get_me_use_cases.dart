import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/helper/src/typedef.dart';
import '../../../../common/models/user_model.dart';
import '../../../../core/use_case/use_case.dart';
import '../../../auth/data/models/auth_response.dart';
import '../../data/models/user_model.dart';
import '../repositories/user_repositories.dart';

@lazySingleton
class UserGetMeUseCases implements UseCase<UserResponse, NoParams> {
  final UserRepositories _repositories;

  UserGetMeUseCases({required UserRepositories repositories})
      : _repositories = repositories;

  @override
  DataResponse<UserResponse> call(NoParams params) async =>
      await
      _repositories.userGetMe();
}
