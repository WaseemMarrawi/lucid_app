
import 'user_model.dart';

class ReviewModel {
  final int? id;
  final int? rating;
  final String? comment;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final UserModel? user;

  ReviewModel({
    this.id,
    this.rating,
    this.comment,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  ReviewModel copyWith({
    int? id,
    int? rating,
    String? comment,
    DateTime? createdAt,
    DateTime? updatedAt,
    UserModel? user,
  }) => ReviewModel(
    id: id ?? this.id,
    rating: rating ?? this.rating,
    comment: comment ?? this.comment,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    user: user ?? this.user,
  );

  factory ReviewModel.fromJson(Map<String, dynamic> json) => ReviewModel(
    id: json["id"],
    rating: json["rating"],
    comment: json["comment"],
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null
        ? null
        : DateTime.parse(json["updatedAt"]),
    user: json["user"] == null ? null : UserModel.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "rating": rating,
    "comment": comment,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "user": user?.toJson(),
  };
}
