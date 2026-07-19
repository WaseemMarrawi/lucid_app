import 'image_model.dart';

class AccessoryModel {
  final int? id;
  final int? accessoryId;
  final String? name;
  final String? description;
  final String? benefits;
  final double? price;
  final double? discountPrice;
  final int? stock;
  final double? rating;
  final List<ImageModel>? images;
  final int? maxOrderQuantity;
  final int? ordersCount;
  final int? quantity;
  final DateTime? createdAt;
  final bool? attributesEnabled;
  final List<Variant>? variants;
  final Variant? variant;
  final int? availableStock;
  final int? requestedQuantity;
  final int? missingQuantity;

  AccessoryModel({
    this.id,
    this.accessoryId,
    this.name,
    this.availableStock,
    this.requestedQuantity,
    this.missingQuantity,
    this.description,
    this.benefits,
    this.price,
    this.discountPrice,
    this.stock,
    this.rating,
    this.images,
    this.maxOrderQuantity,
    this.ordersCount,
    this.createdAt,
    this.attributesEnabled,
    this.variants,
    this.variant,
    this.quantity,
  });

  AccessoryModel copyWith({
    int? id,
    int? accessoryId,
    String? name,
    String? description,
    String? benefits,
    double? price,
    double? discountPrice,
    int? stock,
    double? rating,
    List<ImageModel>? images,
    int? maxOrderQuantity,
    int? ordersCount,
    int? quantity,
    DateTime? createdAt,
    bool? attributesEnabled,
    List<Variant>? variants,
    Variant? variant,
     int? availableStock,
     int? requestedQuantity,
     int? missingQuantity,
  }) => AccessoryModel(
    id: id ?? this.id,
    accessoryId: accessoryId ?? this.accessoryId,
    availableStock: availableStock ?? this.availableStock,
    requestedQuantity: requestedQuantity ?? this.requestedQuantity,
    missingQuantity: missingQuantity ?? this.missingQuantity,
    name: name ?? this.name,
    quantity: quantity ?? this.quantity,
    description: description ?? this.description,
    benefits: benefits ?? this.benefits,
    price: price ?? this.price,
    discountPrice: discountPrice ?? this.discountPrice,
    stock: stock ?? this.stock,
    rating: rating ?? this.rating,
    images: images ?? this.images,
    maxOrderQuantity: maxOrderQuantity ?? this.maxOrderQuantity,
    ordersCount: ordersCount ?? this.ordersCount,
    createdAt: createdAt ?? this.createdAt,
    attributesEnabled: attributesEnabled ?? this.attributesEnabled,
    variants: variants ?? this.variants,
    variant: variant ?? this.variant,
  );

  factory AccessoryModel.fromJson(Map<String, dynamic> json) => AccessoryModel(
    id: json["id"],
    accessoryId: json["accessoryId"],
    name: json["name"],
    description: json["description"],
    benefits: json["benefits"],
    price: json["price"]?.toDouble(),
    discountPrice: json["discountPrice"]?.toDouble(),
    stock: json["stock"],
    rating: json["rating"]?.toDouble(),
    images:
        json["images"] == null
            ? null
            : List<ImageModel>.from(
              json["images"]!.map((e) => ImageModel.fromJson(e)),
            ).toList(),
    maxOrderQuantity: json["maxOrderQuantity"],
    quantity: json["quantity"],
    ordersCount: json["ordersCount"],
    createdAt:
        json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    attributesEnabled: json["attributesEnabled"],
    variant: json["variant"] == null ? null : Variant.fromJson(json["variant"]),
    variants:
        json["variants"] == null
            ? []
            : List<Variant>.from(
              json["variants"]!.map((x) => Variant.fromJson(x)),
            ),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "benefits": benefits,
    "price": price,
    "discountPrice": discountPrice,
    "stock": stock,
    "rating": rating,
    "images": images,
    "maxOrderQuantity": maxOrderQuantity,
    "ordersCount": ordersCount,
    "createdAt": createdAt?.toIso8601String(),
    "attributesEnabled": attributesEnabled,
    "variants":
        variants == null
            ? []
            : List<dynamic>.from(variants!.map((x) => x.toJson())),
  };
}

class Variant {
  final int? id;
  final int? quantity;
  final List<int>? optionIds;
  final List<Option>? options;

  Variant({this.id, this.quantity, this.optionIds, this.options});

  Variant copyWith({
    int? id,
    int? quantity,
    List<int>? optionIds,
    List<Option>? options,
  }) => Variant(
    id: id ?? this.id,
    quantity: quantity ?? this.quantity,
    optionIds: optionIds ?? this.optionIds,
    options: options ?? this.options,
  );

  factory Variant.fromJson(Map<String, dynamic> json) => Variant(
    id: json["id"],
    quantity: json["quantity"],
    optionIds:
        json["optionIds"] == null
            ? []
            : List<int>.from(json["optionIds"]!.map((x) => x)),
    options:
        json["options"] == null
            ? []
            : List<Option>.from(
              json["options"]!.map((x) => Option.fromJson(x)),
            ),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "quantity": quantity,
    "optionIds":
        optionIds == null ? [] : List<dynamic>.from(optionIds!.map((x) => x)),
    "options":
        options == null
            ? []
            : List<dynamic>.from(options!.map((x) => x.toJson())),
  };
}

class Option {
  final int? attributeId;
  final String? attribute;
  final String? value;
  final int? optionId;

  Option({this.attributeId, this.attribute, this.value, this.optionId});

  Option copyWith({
    int? attributeId,
    String? attribute,
    String? value,
    int? optionId,
  }) => Option(
    attributeId: attributeId ?? this.attributeId,
    attribute: attribute ?? this.attribute,
    value: value ?? this.value,
    optionId: optionId ?? this.optionId,
  );

  factory Option.fromJson(Map<String, dynamic> json) => Option(
    attributeId: json["attributeId"],
    attribute: json["attribute"],
    value: json["value"],
    optionId: json["optionId"],
  );

  Map<String, dynamic> toJson() => {
    "attributeId": attributeId,
    "attribute": attribute,
    "value": value,
    "optionId": optionId,
  };
}
