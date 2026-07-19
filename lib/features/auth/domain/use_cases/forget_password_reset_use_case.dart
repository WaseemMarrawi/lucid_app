import '../../../../common/helper/src/typedef.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/use_case/use_case.dart';
import '../repositories/auth_repositories.dart';

@lazySingleton
class ForgetPasswordResetUseCase
    implements UseCase<void, ForgetPasswordResetParams> {
  final AuthRepositories _authRepositories;

  ForgetPasswordResetUseCase({required AuthRepositories authRepositories})
    : _authRepositories = authRepositories;

  @override
  DataResponse<void> call(
    ForgetPasswordResetParams params,
  ) async {
    return _authRepositories.forgetPasswordReset(params.getBody());
  }
}

class ForgetPasswordResetParams with Params {
  final String email;
  final String pin;
  final String password;

  ForgetPasswordResetParams({
    required this.email,
    required this.pin,
    required this.password,
  });

  @override
  BodyMap getBody() {
    // TODO: implement getBody
    return {
      "email": email,
      "code": pin,
      "password": password,
      "password_confirmation": password,
    }..removeWhere((key, value) => value == null || value == '');
  }
}
