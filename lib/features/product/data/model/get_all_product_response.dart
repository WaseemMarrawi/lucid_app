import 'dart:convert';
import '../../../../common/models/product_model.dart';
import '../../../../common/models/super_category_model.dart';

GetAllProductResponse getAllProductResponseFromJson(str) =>
    GetAllProductResponse.fromJson(str);

String getAllProductResponseToJson(GetAllProductResponse data) =>
    json.encode(data.toJson());

class GetAllProductResponse {
  final bool? success;
  final String? message;
  final Data? data;

  GetAllProductResponse({this.success, this.message, this.data});

  GetAllProductResponse copyWith({
    bool? success,
    String? message,
    Data? data,
  }) => GetAllProductResponse(
    success: success ?? this.success,
    message: message ?? this.message,
    data: data ?? this.data,
  );

  factory GetAllProductResponse.fromJson(Map<String, dynamic> json) =>
      GetAllProductResponse(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  final int? menuRevision;
  final List<SuperCategoryModel>? superCategories;
  final List<ProductModel>? products;

  Data({this.menuRevision, this.superCategories, this.products});

  Data copyWith({
    int? menuRevision,
    List<SuperCategoryModel>? superCategories,
    List<ProductModel>? products,
  }) => Data(
    menuRevision: menuRevision ?? this.menuRevision,
    superCategories: superCategories ?? this.superCategories,
    products: products ?? this.products,
  );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    menuRevision: json["menu_revision"],
    superCategories: json["superCategories"] == null
        ? []
        : List<SuperCategoryModel>.from(
            json["superCategories"]!.map((x) => SuperCategoryModel.fromJson(x)),
          ),
    products: json["dishes"] == null
        ? []
        :
    List<ProductModel>.from(json["dishes"]!.map((x) => ProductModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "menu_revision": menuRevision,
    "superCategories": superCategories == null
        ? []
        : List<dynamic>.from(superCategories!.map((x) => x.toJson())),
    "dishes": products == null
        ? []
        : List<dynamic>.from(products!.map((x) => x.toJson())),
  };
}


