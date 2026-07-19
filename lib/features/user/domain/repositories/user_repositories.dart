import 'package:dio/dio.dart';
import '../../../../common/helper/src/typedef.dart';
import '../../data/models/user_model.dart';


abstract class UserRepositories {

  DataResponse<UserResponse> userGetMe();
  DataResponse<UserResponse> userUpdateMe(BodyMap param);
  DataResponse<UserResponse> userUpdateProfileImage(FormData param);
  DataResponse<void> userDeleteMe();


}