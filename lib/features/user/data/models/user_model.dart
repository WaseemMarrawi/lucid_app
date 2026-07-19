import 'dart:convert';

import '../../../../common/models/user_model.dart';
import '../../../auth/data/models/auth_response.dart';

UserResponse userResponseFromJson(str) => UserResponse.fromJson(str);

userResponseToJson(UserResponse data) => data.toJson();

class UserResponse {
  final UserModel? data;

  UserResponse({this.data});

  UserResponse copyWith({UserModel? data}) =>
      UserResponse(data: data ?? this.data);

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
    data: json["data"] == null ? null : UserModel.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {"data": data?.toJson()};
}
