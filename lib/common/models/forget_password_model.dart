import 'user_model.dart';

class ForgetPasswordModel {
  final UserModel? user; // ✅ لأنه ممكن user تكون null
  final String? token;   // ✅ لأنه ممكن token يكون null

  ForgetPasswordModel({
    this.user,
    this.token,
  });

  ForgetPasswordModel copyWith({
    UserModel? user,
    String? token,
  }) {
    return ForgetPasswordModel(
      user: user ?? this.user,
      token: token ?? this.token,
    );
  }

  factory ForgetPasswordModel.fromJson(Map<String, dynamic> json) => ForgetPasswordModel(
    user: json["user"] != null
        ? UserModel.fromJson(json["user"])
        : null,
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    if (user != null) "user": user!.toJson(),
    "token": token,
  };
}