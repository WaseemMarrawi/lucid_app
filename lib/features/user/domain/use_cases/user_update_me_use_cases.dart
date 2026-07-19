import 'package:injectable/injectable.dart';
import '../../../../common/helper/src/app_varibles.dart';
import '../../../../common/helper/src/typedef.dart';
import '../../../../core/use_case/use_case.dart';
import '../../data/models/user_model.dart';
import '../repositories/user_repositories.dart';

@lazySingleton
class UserUpdateMeUseCases
    implements UseCase<UserResponse, UserUpdateMeParams> {
  final UserRepositories _repositories;

  UserUpdateMeUseCases({required UserRepositories repositories})
    : _repositories = repositories;

  @override
  DataResponse<UserResponse> call(UserUpdateMeParams params) async =>
      await _repositories.userUpdateMe(params.getBody());
}

class UserUpdateMeParams with Params {
  final String firstName;
  final String lastName;
  final String? phone;


  UserUpdateMeParams({
    required this.firstName,
    required this.lastName,
    required this.phone,

  });

  @override
  QueryParams getBody() {
    var params = {
      "firstName": firstName,
      "lastName": lastName,
      "phone": phone,

    };

    // Remove entries where the value is null
    params.removeWhere(
      (key, value) => value == null || value == '' || value == 'null',
    );

    return params;
  }
}
