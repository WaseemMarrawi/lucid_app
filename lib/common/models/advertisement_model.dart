class AdvertisementModel {
  final int? id;
  final String? name;
  final String? description;
  final String? link;
  final bool? isActive;
  final Images? images;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Contact? contact;

  AdvertisementModel({
    this.id,
    this.name,
    this.description,
    this.link,
    this.isActive,
    this.images,
    this.createdAt,
    this.updatedAt,
    this.contact,
  });

  AdvertisementModel copyWith({
    int? id,
    String? name,
    String? description,
    String? link,
    bool? isActive,
    Images? images,
    DateTime? createdAt,
    DateTime? updatedAt,
    Contact? contact,
  }) =>
      AdvertisementModel(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        link: link ?? this.link,
        isActive: isActive ?? this.isActive,
        images: images ?? this.images,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        contact: contact ?? this.contact,
      );

  factory AdvertisementModel.fromJson(Map<String, dynamic> json) => AdvertisementModel(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    link: json["link"],
    isActive: json["is_active"],
    images: json["images"] == null ? null : Images.fromJson(json["images"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    contact: Contact.fromJson(json["contact"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "link": link,
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

class Contact {
  final String? name;
  final String? phone;
  final String? email;

  Contact({
    this.name,
    this.phone,
    this.email,
  });

  Contact copyWith({
    String? name,
    String? phone,
    String? email,
  }) =>
      Contact(
        name: name ?? this.name,
        phone: phone ?? this.phone,
        email: email ?? this.email,
      );

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
    name: json["name"],
    phone: json["phone"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "phone": phone,
    "email": email,
  };
}
