import 'dart:convert';

import '../../../../common/models/user_model.dart';
import '../../../auth/data/models/auth_response.dart';

UserResponse userResponseFromJson(str) => UserResponse.fromJson(str);

userResponseToJson(UserResponse data) => data.toJson();



class UserResponse {
  final bool? success;
  final String? message;
  final Data? data;

  UserResponse({
    this.success,
    this.message,
    this.data,
  });

  UserResponse copyWith({
    bool? success,
    String? message,
    Data? data,
  }) =>
      UserResponse(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  final String? token;
  final UserModel? user;

  Data({
    this.token,
    this.user,
  });

  Data copyWith({
    String? token,
    UserModel? user,
  }) =>
      Data(
        token: token ?? this.token,
        user: user ?? this.user,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    token: json["token"],
    user: json["user"] == null ? null : UserModel.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "user": user?.toJson(),
  };
}

