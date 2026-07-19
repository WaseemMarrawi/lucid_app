// // To parse this JSON data, do
// //
// //     final userResponse = userResponseFromJson(jsonString);
//
// import 'dart:convert';
//
// import 'package:deal/common/models/user_model.dart';
//
// import '../../../user/data/models/user_model.dart';
//
// UserResponse userResponseFromJson( str) => UserResponse.fromJson(str);
//
// String userResponseToJson(UserResponse data) => json.encode(data.toJson());
//
// class UserResponse {
//   final String? token;
//   final UserModel? user;
//
//   UserResponse({
//     this.token,
//     this.user,
//   });
//
//   UserResponse copyWith({
//     String? token,
//     UserModel? user,
//   }) =>
//       UserResponse(
//         token: token ?? this.token,
//         user: user ?? this.user,
//       );
//
//   factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
//     token: json["token"],
//     user: json["user"] == null ? null : UserModel.fromJson(json["user"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "token": token,
//     "user": user?.toJson(),
//   };
// }
//
//
