
class BannerModel {
  final int? id;
  final String? name;
  final String? description;
  final bool? isActive;
  final Images? images;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  BannerModel({
    this.id,
    this.name,
    this.description,
    this.isActive,
    this.images,
    this.createdAt,
    this.updatedAt,
  });

  BannerModel copyWith({
    int? id,
    String? name,
    String? description,
    bool? isActive,
    Images? images,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      BannerModel(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        isActive: isActive ?? this.isActive,
        images: images ?? this.images,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    isActive: json["is_active"],
    images: json["images"] == null ? null : Images.fromJson(json["images"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "is_active": isActive,
    "images": images?.toJson(),
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class Images {
  final String? original;
  final String? thumb;
  final String? medium;

  Images({
    this.original,
    this.thumb,
    this.medium,
  });

  Images copyWith({
    String? original,
    String? thumb,
    String? medium,
  }) =>
      Images(
        original: original ?? this.original,
        thumb: thumb ?? this.thumb,
        medium: medium ?? this.medium,
      );

  factory Images.fromJson(Map<String, dynamic> json) => Images(
    original: json["original"],
    thumb: json["thumb"],
    medium: json["medium"],
  );

  Map<String, dynamic> toJson() => {
    "original": original,
    "thumb": thumb,
    "medium": medium,
  };
}
