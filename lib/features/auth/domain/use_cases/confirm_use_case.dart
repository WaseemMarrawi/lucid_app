import 'package:dio/dio.dart';
import '../../../../common/helper/src/typedef.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/use_case/use_case.dart';
import '../../data/models/auth_response.dart';
import '../repositories/auth_repositories.dart';

@lazySingleton
class ConfirmUseCase implements UseCase<AuthResponse, ConfirmParams> {
  final AuthRepositories _authRepositories;

  ConfirmUseCase({required AuthRepositories authRepositories})
    : _authRepositories = authRepositories;

  @override
  DataResponse<AuthResponse> call(ConfirmParams params) {
    return _authRepositories.confirm(params.getBody());
  }
}

class ConfirmParams with Params {
  final String email;
  final String code;

  ConfirmParams({required this.email, required this.code});

  @override
  BodyMap getBody() {
    // TODO: implement getBody
    return {"email": email, "code": code}
      ..removeWhere((key, value) => value == null);
  }
}
