import '../../../../common/helper/src/typedef.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/use_case/use_case.dart';
import '../repositories/auth_repositories.dart';

@lazySingleton
class SignupUseCase implements UseCase<void, SignUpParams> {
  final AuthRepositories _authRepositories;

  SignupUseCase({required AuthRepositories authRepositories})
    : _authRepositories = authRepositories;

  @override
  DataResponse<void> call(SignUpParams params) async =>
      await _authRepositories.signUp(params.getBody());
}

class SignUpParams with Params {
  final String name;
  final String email;
  final String password;
  final String passwordConfirmation;

  SignUpParams({
    required this.name,
    required this.password,
    required this.email,
    required this.passwordConfirmation,
  });


  @override
  BodyMap getBody() {
    // TODO: implement getBody
    return {
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation,

    }..removeWhere(
          (key, value) => value == null || value == '' || value == 'null',
    );
  }
}
