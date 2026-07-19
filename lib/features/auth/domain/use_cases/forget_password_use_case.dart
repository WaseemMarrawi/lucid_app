import '../../../../common/helper/src/typedef.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/use_case/use_case.dart';
import '../../data/models/forget_password_response.dart';
import '../repositories/auth_repositories.dart';

@lazySingleton
class ForgetPasswordUseCase
    implements UseCase<void, ForgetPasswordParams> {
  final AuthRepositories _authRepositories;

  ForgetPasswordUseCase({required AuthRepositories authRepositories})
    : _authRepositories = authRepositories;

  @override
  DataResponse<void> call(ForgetPasswordParams params) async {
    return _authRepositories.forgetPassword(params.getBody());
  }
}

class ForgetPasswordParams with Params {
  final String email;

  ForgetPasswordParams({required this.email});

  @override
  BodyMap getBody() {
    // TODO: implement getBody
    return {
      "email": email,


    }
      ..removeWhere(
    (key, value)
          => value == null || value == '');
  }
}
