import '../../../../common/models/forget_password_model.dart';
import '../../../../common/models/user_model.dart';

ForgetPasswordResponse forgetPasswordResponseFromJson( str) =>
    ForgetPasswordResponse.fromJson(str);

forgetPasswordResponseToJson(ForgetPasswordResponse data) => data.toJson();

class ForgetPasswordResponse {
  final bool success;
  final String message;
  final ForgetPasswordModel? data; // ✅ لأنه قد تكون data مفقودة أو null

  ForgetPasswordResponse({
    required this.success,
    required this.message,
    this.data,
  });

  ForgetPasswordResponse copyWith({
    bool? success,
    String? message,
    ForgetPasswordModel? data,
  }) {
    return ForgetPasswordResponse(
      success: success ?? this.success,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  factory ForgetPasswordResponse.fromJson(Map<String, dynamic> json) => ForgetPasswordResponse(
    success: json["success"] ?? false,
    message: json["message"] ?? '',
    data: json["data"] != null
        ? ForgetPasswordModel.fromJson(json["data"])
        : null,
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    if (data != null) "data": data!.toJson(),
  };
}


