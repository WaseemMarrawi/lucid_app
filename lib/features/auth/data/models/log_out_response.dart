
import 'dart:convert';

LogOutResponse logOutResponseFromJson( str) => LogOutResponse.fromJson(str);

String logOutResponseToJson(LogOutResponse data) => json.encode(data.toJson());

class LogOutResponse {
  final bool? success;
  final String? message;

  LogOutResponse({
    this.success,
    this.message,
  });

  LogOutResponse copyWith({
    bool? success,
    String? message,
  }) =>
      LogOutResponse(
        success: success ?? this.success,
        message: message ?? this.message,
      );

  factory LogOutResponse.fromJson(Map<String, dynamic> json) => LogOutResponse(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}
