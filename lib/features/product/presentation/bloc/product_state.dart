part of 'product_bloc.dart';

class ProductState {
  final CachedDataStateModel<GetAllProductResponse?> getAllProductData;
  final SuperCategoryModel? selectedSuperCategory;
  final SuperCategoryModel? selectedCategory;
  final List<ProductModel>? productList;
  final List<(SuperCategoryModel,List<ProductModel>?) > categoryProductList;

  const ProductState({
    this.getAllProductData =
    const CachedDataStateModel.setDefaultValue(defaultValue: null),

    this.productList = const [],
    this.categoryProductList = const [],

    this.selectedCategory,
    this.selectedSuperCategory,
  });

  ProductState copyWith({
    CachedDataStateModel<GetAllProductResponse?>? getAllProductData,
    Object? selectedSuperCategory = const _Unset(),
    Object? selectedCategory = const _Unset(),
    List<ProductModel>? productList,
    List<(SuperCategoryModel,List<ProductModel>?)>? categoryProductList,
  }) {
    return ProductState(
      getAllProductData: getAllProductData ?? this.getAllProductData,
      categoryProductList: categoryProductList ?? this.categoryProductList,

      selectedSuperCategory: selectedSuperCategory is _Unset
          ? this.selectedSuperCategory
          : selectedSuperCategory as SuperCategoryModel?,

      selectedCategory: selectedCategory is _Unset
          ? this.selectedCategory
          : selectedCategory as SuperCategoryModel?,

      productList: productList ?? this.productList,
    );
  }

  factory ProductState.fromJson(Map<String, dynamic> json) {
    final cached = json["getAllProductData"] == null
        ? null
        : GetAllProductResponse.fromJson(json["getAllProductData"]);

    return ProductState(
      getAllProductData: CachedDataStateModel.setDefaultValue(
        defaultValue: cached,
      ),

      // 🔥 مهم: استرجاع المنتجات مباشرة إلى productList
      productList: cached?.data?.products ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "getAllProductData": getAllProductData.data?.toJson(),
      "productList": productList?.map((e) => e.toJson()).toList(),
    };
  }
}

class _Unset {
  const _Unset();
}