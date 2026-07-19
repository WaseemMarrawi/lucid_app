import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/helper/src/typedef.dart';
import '../../../../core/use_case/use_case.dart';
import '../repositories/user_repositories.dart';

@lazySingleton
class UserDeleteMeUseCases implements UseCase<void, NoParams> {
  final UserRepositories _repositories;

  UserDeleteMeUseCases({required UserRepositories repositories})
      : _repositories = repositories;

  @override
  DataResponse<void> call(NoParams params) async =>
      await _repositories.userDeleteMe();
}
