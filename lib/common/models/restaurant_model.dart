import 'dart:ui';

import '../extensions/src/context_extensions.dart';
import 'description_model.dart';

class RestaurantModel {
  final int? id;
  final int? userId;
  final String? name;
  final DescriptionModel? nameTranslations;
  final String? slug;
  final String? ownerName;
  final String? email;
  final String? phone;
  final String? description;
  final DescriptionModel? descriptionTranslations;
  final String? address;
  final DescriptionModel? addressTranslations;
  final String? workingHours;
  final String? facebookUrl;
  final String? instagramUrl;
  final String? telegramUrl;
  final String? whatsappNumber;
  final Color? primaryColor;
  final Color? secondaryColor;
  final Color? backgroundColor;
  final Color? hintColor;
  final Color? textColor;
  final int? subscriptionPrice;
  final DateTime? subscriptionStartedAt;
  final DateTime? subscriptionEndsAt;
  final String? subscriptionDuration;
  final String? status;
  final Media? media;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  RestaurantModel({
    this.id,
    this.userId,
    this.name,
    this.nameTranslations,
    this.slug,
    this.ownerName,
    this.email,
    this.phone,
    this.description,
    this.descriptionTranslations,
    this.address,
    this.addressTranslations,
    this.workingHours,
    this.facebookUrl,
    this.instagramUrl,
    this.telegramUrl,
    this.whatsappNumber,
    this.primaryColor,
    this.secondaryColor,
    this.hintColor,
    this.backgroundColor,
    this.textColor,
    this.subscriptionPrice,
    this.subscriptionStartedAt,
    this.subscriptionEndsAt,
    this.subscriptionDuration,
    this.status,
    this.media,
    this.createdAt,
    this.updatedAt,
  });

  RestaurantModel copyWith({
    int? id,
    int? userId,
    String? name,
    DescriptionModel? nameTranslations,
    String? slug,
    String? ownerName,
    String? email,
    String? phone,
    String? description,
    DescriptionModel? descriptionTranslations,
    String? address,
    DescriptionModel? addressTranslations,
    String? workingHours,
    String? facebookUrl,
    String? instagramUrl,
    String? telegramUrl,
    String? whatsappNumber,
    Color? primaryColor,
    Color? secondaryColor,
    Color? backgroundColor,
    Color? hintColor,
    Color? textColor,
    int? subscriptionPrice,
    DateTime? subscriptionStartedAt,
    DateTime? subscriptionEndsAt,
    String? subscriptionDuration,
    String? status,
    Media? media,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => RestaurantModel(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    name: name ?? this.name,
    nameTranslations: nameTranslations ?? this.nameTranslations,
    slug: slug ?? this.slug,
    ownerName: ownerName ?? this.ownerName,
    email: email ?? this.email,
    phone: phone ?? this.phone,
    description: description ?? this.description,
    descriptionTranslations:
        descriptionTranslations ?? this.descriptionTranslations,
    address: address ?? this.address,
    addressTranslations: addressTranslations ?? this.addressTranslations,
    workingHours: workingHours ?? this.workingHours,
    facebookUrl: facebookUrl ?? this.facebookUrl,
    instagramUrl: instagramUrl ?? this.instagramUrl,
    telegramUrl: telegramUrl ?? this.telegramUrl,
    whatsappNumber: whatsappNumber ?? this.whatsappNumber,
    primaryColor: primaryColor ?? this.primaryColor,
    secondaryColor: secondaryColor ?? this.secondaryColor,
    backgroundColor: backgroundColor ?? this.backgroundColor,
    hintColor: hintColor ?? this.hintColor,
    textColor: textColor ?? this.textColor,
    subscriptionPrice: subscriptionPrice ?? this.subscriptionPrice,
    subscriptionStartedAt: subscriptionStartedAt ?? this.subscriptionStartedAt,
    subscriptionEndsAt: subscriptionEndsAt ?? this.subscriptionEndsAt,
    subscriptionDuration: subscriptionDuration ?? this.subscriptionDuration,
    status: status ?? this.status,
    media: media ?? this.media,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      RestaurantModel(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        nameTranslations: json["name_translations"] == null
            ? null
            : DescriptionModel.fromJson(json["name_translations"]),
        slug: json["slug"],
        ownerName: json["owner_name"],
        email: json["email"],
        phone: json["phone"],
        description: json["description"],
        descriptionTranslations: json["description_translations"] == null
            ? null
            : DescriptionModel.fromJson(json["description_translations"]),
        address: json["address"],
        addressTranslations: json["address_translations"] == null
            ? null
            : DescriptionModel.fromJson(json["address_translations"]),
        workingHours: json["working_hours"],
        facebookUrl: json["facebook_url"],
        instagramUrl: json["instagram_url"],
        telegramUrl: json["telegram_url"],
        whatsappNumber: json["whatsapp_number"],
        primaryColor: (json["primary_color"] as String?)?.toColor(),
        secondaryColor: (json["secondary_color"] as String?)?.toColor(),
        backgroundColor: (json["background_color"] as String?)?.toColor(),
        hintColor: (json["hint_color"] as String?)?.toColor(),
        textColor: (json["text_color"] as String?)?.toColor(),

        subscriptionPrice: json["subscription_price"],
        subscriptionStartedAt: json["subscription_started_at"] == null
            ? null
            : DateTime.parse(json["subscription_started_at"]),
        subscriptionEndsAt: json["subscription_ends_at"] == null
            ? null
            : DateTime.parse(json["subscription_ends_at"]),
        subscriptionDuration: json["subscription_duration"],
        status: json["status"],
        media: json["media"] == null ? null : Media.fromJson(json["media"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "name": name,
    "name_translations": nameTranslations?.toJson(),
    "slug": slug,
    "owner_name": ownerName,
    "email": email,
    "phone": phone,
    "description": description,
    "description_translations": descriptionTranslations?.toJson(),
    "address": address,
    "address_translations": addressTranslations?.toJson(),
    "working_hours": workingHours,
    "facebook_url": facebookUrl,
    "instagram_url": instagramUrl,
    "telegram_url": telegramUrl,
    "whatsapp_number": whatsappNumber,
    "primary_color": primaryColor == null
        ? null
        : '#${primaryColor!.value.toRadixString(16).substring(2).toUpperCase()}',

    "secondary_color": secondaryColor == null
        ? null
        : '#${secondaryColor!.value.toRadixString(16).substring(2).toUpperCase()}',

    "background_color": backgroundColor == null
        ? null
        : '#${backgroundColor!.value.toRadixString(16).substring(2).toUpperCase()}',
    "hintColor": hintColor == null
        ? null
        : '#${hintColor!.value.toRadixString(16).substring(2).toUpperCase()}',

    "text_color": textColor == null
        ? null
        : '#${textColor!.value.toRadixString(16).substring(2).toUpperCase()}',
    "subscription_price": subscriptionPrice,
    "subscription_started_at": subscriptionStartedAt?.toIso8601String(),
    "subscription_ends_at": subscriptionEndsAt?.toIso8601String(),
    "subscription_duration": subscriptionDuration,
    "status": status,
    "media": media?.toJson(),
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class Media {
  final String? logo;
  final String? profileImage;
  final String? profileVideo;
  final String? coverImage;
  final String? qrCode;

  Media({this.logo, this.profileImage, this.coverImage, this.qrCode, this.profileVideo});

  Media copyWith({
    String? logo,
    String? profileImage,
    String? coverImage,
    String? qrCode,
    String? profileVideo,
  }) => Media(
    logo: logo ?? this.logo,
    profileImage: profileImage ?? this.profileImage,
    coverImage: coverImage ?? this.coverImage,
    qrCode: qrCode ?? this.qrCode,
    profileVideo: profileVideo ?? this.profileVideo,
  );

  factory Media.fromJson(Map<String, dynamic> json) => Media(
    logo: json["logo"],
    profileImage: json["profile_image"],
    coverImage: json["cover_image"],
    qrCode: json["qr_code"],
    profileVideo: json["profile_video"],
  );

  Map<String, dynamic> toJson() => {
    "logo": logo,
    "profile_image": profileImage,
    "cover_image": coverImage,
    "qr_code": qrCode,
    "profile_video": profileVideo,
  };
}
