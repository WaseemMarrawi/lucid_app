import 'dart:convert';

List<UserPhotosModel> userPhotosFromJson( str) => List<UserPhotosModel>.from(str.map((x) => UserPhotosModel.fromJson(x)));

String userPhotosToJson(List<UserPhotosModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserPhotosModel {
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? blurHash;
  final String? profileUrl;
  final String? mobileUrl;
  final String? webUrl;

  UserPhotosModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.blurHash,
    this.profileUrl,
    this.mobileUrl,
    this.webUrl,
  });

  UserPhotosModel copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? blurHash,
    String? profileUrl,
    String? mobileUrl,
    String? webUrl,
  }) =>
      UserPhotosModel(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        blurHash: blurHash ?? this.blurHash,
        profileUrl: profileUrl ?? this.profileUrl,
        mobileUrl: mobileUrl ?? this.mobileUrl,
        webUrl: webUrl ?? this.webUrl,
      );

  factory UserPhotosModel.fromJson(Map<String, dynamic> json) => UserPhotosModel(
    id: json["id"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    blurHash: json["blurHash"],
    profileUrl: json["profileUrl"],
    mobileUrl: json["mobileUrl"],
    webUrl: json["webUrl"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "blurHash": blurHash,
    "profileUrl": profileUrl,
    "mobileUrl": mobileUrl,
    "webUrl": webUrl,
  };
}
