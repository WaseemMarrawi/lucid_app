// To parse this JSON data, do
//
//     final userUpdateModel = userUpdateModelFromJson(jsonString);

import 'dart:convert';


UserUpdateModel userUpdateModelFromJson( str) => UserUpdateModel.fromJson(str);

String userUpdateModelToJson(UserUpdateModel data) => json.encode(data.toJson());

class UserUpdateModel {
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final dynamic disactiveAt;
  final String? role;
  // final Wallet? wallet;
  // final Photo? photo;

  UserUpdateModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.firstName,
    this.lastName,
    this.phone,
    this.disactiveAt,
    this.role,
    // this.wallet,
    // this.photo,
  });

  UserUpdateModel copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? firstName,
    String? lastName,
    String? phone,
    dynamic disactiveAt,
    String? role,
    // Wallet? wallet,
    // Photo? photo,
  }) =>
      UserUpdateModel(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        phone: phone ?? this.phone,
        disactiveAt: disactiveAt ?? this.disactiveAt,
        role: role ?? this.role,
        // wallet: wallet ?? this.wallet,
        // photo: photo ?? this.photo,
      );

  factory UserUpdateModel.fromJson(Map<String, dynamic> json) => UserUpdateModel(
    id: json["id"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    firstName: json["firstName"],
    lastName: json["lastName"],
    phone: json["phone"],
    disactiveAt: json["disactiveAt"],
    role: json["role"],
    // wallet: json["wallet"] == null ? null : Wallet.fromJson(json["wallet"]),
    // photo: json["photo"] == null ? null : Photo.fromJson(json["photo"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "firstName": firstName,
    "lastName": lastName,
    "phone": phone,
    "disactiveAt": disactiveAt,
    "role": role,
    // "wallet": wallet?.toJson(),
    // "photo": photo?.toJson(),
  };
}

