import 'dart:ui';

import 'package:restaurants_menu/common/models/restaurant_model.dart';

import '../extensions/src/context_extensions.dart';
import 'description_model.dart';


class UserModel {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final dynamic avatar;
  final dynamic avatarUrl;
  final String? status;
  final DateTime? lastLoginAt;
  final RestaurantModel? restaurant;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.avatar,
    this.avatarUrl,
    this.status,
    this.lastLoginAt,
    this.restaurant,
    this.createdAt,
    this.updatedAt,
  });

  UserModel copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
    dynamic avatar,
    dynamic avatarUrl,
    String? status,
    DateTime? lastLoginAt,
    RestaurantModel? restaurant,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      UserModel(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        avatar: avatar ?? this.avatar,
        avatarUrl: avatarUrl ?? this.avatarUrl,
        status: status ?? this.status,
        lastLoginAt: lastLoginAt ?? this.lastLoginAt,
        restaurant: restaurant ?? this.restaurant,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    avatar: json["avatar"],
    avatarUrl: json["avatar_url"],
    status: json["status"],
    lastLoginAt: json["last_login_at"] == null ? null : DateTime.parse(json["last_login_at"]),
    restaurant: json["restaurant"] == null ? null : RestaurantModel.fromJson(json["restaurant"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "avatar": avatar,
    "avatar_url": avatarUrl,
    "status": status,
    "last_login_at": lastLoginAt?.toIso8601String(),
    "restaurant": restaurant?.toJson(),
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}






