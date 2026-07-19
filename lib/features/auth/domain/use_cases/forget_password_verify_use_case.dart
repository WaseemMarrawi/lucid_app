import '../../../../common/helper/src/typedef.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/use_case/use_case.dart';
import '../repositories/auth_repositories.dart';

@lazySingleton
class ForgetPasswordVerifyUseCase
    implements UseCase<void, ForgetPasswordVerifyParams> {
  final AuthRepositories _authRepositories;

  ForgetPasswordVerifyUseCase({required AuthRepositories authRepositories})
    : _authRepositories = authRepositories;

  @override
  DataResponse<void> call(
    ForgetPasswordVerifyParams params,
  ) async {
    return _authRepositories.forgetPasswordVerify(params.getBody());
  }
}

class ForgetPasswordVerifyParams with Params {
  final String email;
  final String code;

  ForgetPasswordVerifyParams({required this.email, required this.code});


  @override
  BodyMap getBody() {
    // TODO: implement getBody
    return {
      "email": email,
      "code":code
    }..removeWhere((key, value) => value == null || value == '');
  }
}
