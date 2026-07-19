import '../../../../common/helper/src/typedef.dart';
import '../../data/models/auth_response.dart';

abstract class AuthRepositories {
  DataResponse<AuthResponse> logIn(BodyMap params);

  DataResponse<void> logOut();

  DataResponse<void> signUp(BodyMap params);

  DataResponse<AuthResponse> confirm(BodyMap params);

  DataResponse<void> forgetPassword(BodyMap params);
  DataResponse<void> forgetPasswordVerify(BodyMap params);
  DataResponse<void> forgetPasswordReset(BodyMap params);


}
