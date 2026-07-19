
import 'description_model.dart';

class AddonModel {
  final int? id;
  final int? restaurantId;
  final int? dishId;
  final DescriptionModel? name;
  final double? price;
  final bool? isActive;
  final int? sortOrder;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  AddonModel({
    this.id,
    this.restaurantId,
    this.dishId,
    this.name,
    this.price,
    this.isActive,
    this.sortOrder,
    this.createdAt,
    this.updatedAt,
  });

  AddonModel copyWith({
    int? id,
    int? restaurantId,
    int? dishId,
    DescriptionModel? name,
    double? price,
    bool? isActive,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => AddonModel(
    id: id ?? this.id,
    restaurantId: restaurantId ?? this.restaurantId,
    dishId: dishId ?? this.dishId,
    name: name ?? this.name,
    price: price ?? this.price,
    isActive: isActive ?? this.isActive,
    sortOrder: sortOrder ?? this.sortOrder,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  factory AddonModel.fromJson(Map<String, dynamic> json) => AddonModel(
    id: json["id"],
    restaurantId: json["restaurant_id"],
    dishId: json["dish_id"],
    name: json["name"] == null ? null : DescriptionModel.fromJson(json["name"]),
    price: json["price"]!.toDouble(),
    isActive: json["is_active"],
    sortOrder: json["sort_order"],
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
    "dish_id": dishId,
    "name": name?.toJson(),
    "price": price,
    "is_active": isActive,
    "sort_order": sortOrder,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };

  Map<String, dynamic> toApi() => {
    "dish_addon_id": id,
    "quantity": restaurantId,
  };
}
