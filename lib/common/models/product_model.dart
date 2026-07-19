import 'package:restaurants_menu/common/models/super_category_model.dart';

import 'addon_model.dart';
import 'description_model.dart';
import 'ingredient_model.dart';
import 'media_model.dart';

class ProductModel {
  final int? id;
  final int? restaurantId;
  final int? categoryId;
  final int? superCategoryId;
  final DescriptionModel? name;
  final DescriptionModel? description;
  final double? internalPrice;
  final double? externalPrice;
  final String? currency;
  final String? dishType;
  final String? dishTypeLabel;
  final String? note;
  final int? calories;
  final int? preparationTime;
  final bool? isAvailable;
  final bool? isFeatured;
  final int? sortOrder;
  final MediaModel? media;
  final IngredientsModel? ingredientsModel;
  final List<AddonModel>? addons;
  final List<AddonModel>? selectedAddons;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? count;

  ProductModel({
    this.id,
    this.restaurantId,
    this.ingredientsModel,
    this.categoryId,
    this.superCategoryId,
    this.name,
    this.description,
    this.internalPrice,
    this.externalPrice,
    this.currency,
    this.dishType,
    this.dishTypeLabel,
    this.calories,
    this.preparationTime,
    this.isAvailable,
    this.isFeatured,
    this.sortOrder,
    this.media,
    this.addons,
    this.createdAt,
    this.updatedAt,
    this.note,
    this.selectedAddons,
    this.count = 0,
  });

  ProductModel copyWith({
    int? id,
    int? restaurantId,
    int? categoryId,
    int? superCategoryId,
    IngredientsModel? ingredientsModel,
    DescriptionModel? name,
    DescriptionModel? description,
    double? internalPrice,
    double? externalPrice,
    String? currency,
    String? dishType,
    String? dishTypeLabel,
    int? calories,
    int? preparationTime,
    bool? isAvailable,
    bool? isFeatured,
    int? sortOrder,
    MediaModel? media,
    List<AddonModel>? addons,
    List<AddonModel>? selectedAddons,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? note,
    int? count,
  }) => ProductModel(
    id: id ?? this.id,
    note: note ?? this.note,
    ingredientsModel: ingredientsModel ?? this.ingredientsModel,
    restaurantId: restaurantId ?? this.restaurantId,
    categoryId: categoryId ?? this.categoryId,
    superCategoryId: superCategoryId ?? this.superCategoryId,
    name: name ?? this.name,
    description: description ?? this.description,
    internalPrice: internalPrice ?? this.internalPrice,
    externalPrice: externalPrice ?? this.externalPrice,
    currency: currency ?? this.currency,
    dishType: dishType ?? this.dishType,
    dishTypeLabel: dishTypeLabel ?? this.dishTypeLabel,
    calories: calories ?? this.calories,
    preparationTime: preparationTime ?? this.preparationTime,
    isAvailable: isAvailable ?? this.isAvailable,
    isFeatured: isFeatured ?? this.isFeatured,
    sortOrder: sortOrder ?? this.sortOrder,
    media: media ?? this.media,
    addons: addons ?? this.addons,
    selectedAddons: selectedAddons ?? this.selectedAddons,
    count: count ?? this.count,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json["id"],
    note: json["note"],
    count: json["count"],
    selectedAddons: json["selectedAddons"] == null
        ? []
        : List<AddonModel>.from(
            json["selectedAddons"]!.map((x) => AddonModel.fromJson(x)),
          ),
    ingredientsModel: json["ingredients"] == null
        ? null
        : IngredientsModel.fromJson(
      json["ingredients"],
    ),
    restaurantId: json["restaurant_id"],
    categoryId: json["category_id"],
    superCategoryId: json["super_category_id"],
    name: json["name"] == null ? null : DescriptionModel.fromJson(json["name"]),
    description: json["description"] == null
        ? null
        : DescriptionModel.fromJson(json["description"]),
    internalPrice: json["internal_price"]?.toDouble(),
    externalPrice: json["external_price"]?.toDouble(),

    currency: json["currency"],
    dishType: json["dish_type"],
    dishTypeLabel: json["dish_type_label"],
    calories: json["calories"],
    preparationTime: json["preparation_time"],
    isAvailable: json["is_available"],
    isFeatured: json["is_featured"],
    sortOrder: json["sort_order"],
    media: json["media"] == null ? null : MediaModel.fromJson(json["media"]),
    addons: json["addons"] == null
        ? []
        : List<AddonModel>.from(
            json["addons"]!.map((x) => AddonModel.fromJson(x)),
          ),
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "restaurant_id": restaurantId,
    "ingredients": ingredientsModel?.toJson(),
    "category_id": categoryId,
    "super_category_id": superCategoryId,
    "name": name?.toJson(),
    "description": description?.toJson(),
    "internal_price": internalPrice,
    "external_price": externalPrice,
    "currency": currency,
    "dish_type": dishType,
    "dish_type_label": dishTypeLabel,
    "calories": calories,
    "preparation_time": preparationTime,
    "is_available": isAvailable,
    "is_featured": isFeatured,
    "sort_order": sortOrder,
    "count": count,
    "media": media?.toJson(),
    "addons": addons == null
        ? []
        : List<dynamic>.from(addons!.map((x) => x.toJson())),
    "selectedAddons": selectedAddons == null
        ? []
        : List<dynamic>.from(selectedAddons!.map((x) => x.toJson())),
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };

  Map<String, dynamic> toApi() {
    return {
      'dish_id': id,
      'quantity': count,
      'notes': note,
      'name': name?.toJson(),
      'addons': selectedAddons == null
          ? []
          : List<dynamic>.from(selectedAddons!.map((x) => x.toApi())),
    };
  }
}



