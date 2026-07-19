import 'dart:async';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:restaurants_menu/common/models/description_model.dart';
import 'package:restaurants_menu/core/use_case/use_case.dart';
import 'package:restaurants_menu/features/product/data/model/get_all_product_response.dart';
import '../../../../common/helper/src/cashed_data_state_model.dart';
import '../../../../common/models/product_model.dart';
import '../../../../common/models/super_category_model.dart';
import '../../domin/use_cases/get_all_product_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter/foundation.dart';

part 'product_event.dart';

part 'product_state.dart';

@injectable
class ProductBloc extends HydratedBloc<ProductEvent, ProductState> {
  final GetAllProductUseCase _getAllProductUseCase;

  ProductBloc(this._getAllProductUseCase) : super(const ProductState()) {
    on<GetAllProductEvent>(_getAllProduct);
    on<SelectSuperCategoryEvent>(_selectSuperCategory);
    on<SelectCategoryEvent>(_selectCategory);
    // on<GetProductImagesEvent>(_getProductImages);
    on<InitSelectedSuperCategoryEvent>(_initSelectedSuper);
  }

  FutureOr<void> _initSelectedSuper(
      InitSelectedSuperCategoryEvent event,
      Emitter<ProductState> emit,
      )
  async{
    final cache = state.getAllProductData.data;

    final superCategories = cache?.data?.superCategories;

    if (superCategories == null || superCategories.isEmpty) {
      return;
    }

    final selected = superCategories.first;

    final result = _buildCategorySelection(
      superCategory: selected,
    );

    emit(
      state.copyWith(
        selectedSuperCategory: selected,
        selectedCategory: result.selectedCategory,
        productList: result.products,
        categoryProductList: result.categoryProductList,
      ),
    );
  }

  // =========================
  // GET ALL PRODUCTS
  // =========================

  FutureOr<void> _getAllProduct(
    GetAllProductEvent event,
    Emitter<ProductState> emit,
  )
  async {
    final cache = state.getAllProductData.data;

    final hasCache =
        cache?.data?.products != null && cache!.data!.products!.isNotEmpty;

    final oldProducts = state.productList ?? [];
    final oldLevel = cache?.data?.menuRevision;

    // =========================
    // Loading only first time
    // =========================
    if (!hasCache) {
      emit(
        state.copyWith(getAllProductData: state.getAllProductData.setLoading()),
      );
    }

    final result = await _getAllProductUseCase(NoParams());

    await result.fold(
      (l) async {
        if (state.productList?.isNotEmpty == true) return;

        emit(
          state.copyWith(
            getAllProductData: state.getAllProductData.setFailed(
              errorMessage: l.message,
            ),
          ),
        );
      },

      (r) async {
        final newProducts = r.data?.products ?? [];
        final newLevel = r.data?.menuRevision;

        // =========================
        // VALIDATION
        // =========================
        if (newProducts.isEmpty) {
          return; // لا تحديث نهائياً
        }

        // =========================
        // PREFETCH (safe background)
        // =========================
        await _prefetchImages(newProducts, r.data?.superCategories);

        // =========================
        // FIRST LOAD
        // =========================
        if (!hasCache) {
          emit(
            state.copyWith(
              getAllProductData: state.getAllProductData.setSuccess(data: r),
              productList: newProducts,
            ),
          );

          add(InitSelectedSuperCategoryEvent());
          return;
        }

        // =========================
        // NO REVISION → NO UPDATE
        // =========================
        if (newLevel == null || oldLevel == null) {
          return;
        }

        // =========================
        // VERSION CHECK (IMPORTANT)
        // =========================
        if (newLevel <= oldLevel) {
          return;
        }

        // =========================
        // DIFF CHECK (FINAL SAFETY)
        // =========================
        final isSameList = listEquals(oldProducts, newProducts);

        if (isSameList) {
          return; // لا تحديث UI نهائياً
        }

        // =========================
        // REAL UPDATE ONLY
        // =========================
        emit(
          state.copyWith(
            getAllProductData: state.getAllProductData.setSuccess(data: r),
            productList: newProducts,
          ),
        );

        add(InitSelectedSuperCategoryEvent());
      },
    );
  }

  Future<void> _prefetchImages(
    List<ProductModel> products,
    List<SuperCategoryModel>? superCategories,
  )
  async {
    final cacheManager = DefaultCacheManager();

    final urls = <String>{};

    // =========================
    // 1. PRODUCTS IMAGES
    // =========================
    for (final product in products) {
      final image = product.media?.image;

      if (image != null && image.isNotEmpty) {
        urls.add(image);
      }

      final gallery = product.media?.gallery ?? [];
      for (final g in gallery) {
        if (g.isNotEmpty) {
          urls.add(g);
        }
      }
    }

    // =========================
    // 2. SUPER CATEGORIES (ONLY IMAGE)
    // =========================
    void extractImages(List<SuperCategoryModel>? categories) {
      if (categories == null) return;

      for (final cat in categories) {
        // ONLY IMAGE (NO ICON)
        final image = cat.media?.image;

        if (image != null && image.isNotEmpty) {
          urls.add(image);
        }

        // recurse children
        extractImages(cat.categories);
      }
    }

    extractImages(superCategories);

    // =========================
    // 3. CACHE DOWNLOAD
    // =========================
    await Future.wait(
      urls.map((url) async {
        try {
          final file = await cacheManager.getFileFromCache(url);

          if (file != null) return;

          await cacheManager.downloadFile(url);
        } catch (_) {
          // ignore errors
        }
      }),
    );
  }

  // =========================
  // SELECT SUPER CATEGORY
  // =========================
  FutureOr<void> _selectSuperCategory(
      SelectSuperCategoryEvent event,
      Emitter<ProductState> emit,
      )
  async {
    if (event.params == null) {
      emit(
        state.copyWith(
          selectedSuperCategory: null,
          selectedCategory: null,
          productList: state.getAllProductData.data?.data?.products ?? [],
          categoryProductList: [],
        ),
      );
      return;
    }

    final result = _buildCategorySelection(
      superCategory: event.params!,
    );

    emit(
      state.copyWith(
        selectedSuperCategory: event.params,
        selectedCategory: result.selectedCategory,
        productList: result.products,
        categoryProductList: result.categoryProductList,
      ),
    );
  }

  // =========================
  // SELECT CATEGORY
  // =========================
  FutureOr<void> _selectCategory(
      SelectCategoryEvent event,
      Emitter<ProductState> emit,
      )
  {
    emit(
      state.copyWith(
        selectedCategory: event.params,
      ),
    );
  }

  @override
  ProductState? fromJson(Map<String, dynamic> json) {
    try {
      return ProductState.fromJson(json);
    } catch (_) {
      return const ProductState();
    }
  }

  @override
  Map<String, dynamic>? toJson(ProductState state) {
    return state.toJson();
  }

  _CategorySelectionResult _buildCategorySelection({
    required SuperCategoryModel superCategory,
  })
  {
    final baseList = state.getAllProductData.data?.data?.products ?? [];

    final filtered = baseList
        .where((e) => e.superCategoryId == superCategory.id)
        .toList();

    final categoryProductList = <(SuperCategoryModel, List<ProductModel>)>[];

    final hasCategories = superCategory.categories?.isNotEmpty == true;

    // سنحتفظ بأول Category يحتوي منتجات ليصبح هو المختار
    SuperCategoryModel? selectedCategory;
    List<ProductModel> selectedProducts = [];

    if (hasCategories) {
      for (final category in superCategory.categories!) {
        final products = filtered
            .where((p) => p.categoryId == category.id)
            .toList();

        // اعرض جميع الـ Categories حتى لو كانت فارغة
        categoryProductList.add((category, products));

        // أول Category يحتوي منتجات يصبح هو المختار
        if (selectedCategory == null && products.isNotEmpty) {
          selectedCategory = category;
          selectedProducts = products;
        }
      }
    }

    // منتجات "أخرى"
    final anotherProducts = hasCategories
        ? filtered.where((p) => p.categoryId == null).toList()
        : filtered;

    if (anotherProducts.isNotEmpty || !hasCategories) {
      final anotherCategory = SuperCategoryModel(
        id: -1,
        name:  DescriptionModel(
          ar: 'أخرى',
          en: 'Another',
        ),
      );

      categoryProductList.add(
        (
        anotherCategory,
        anotherProducts,
        ),
      );

      // إذا لم نجد أي Category فيها منتجات، اختر "أخرى"
      if (selectedCategory == null && anotherProducts.isNotEmpty) {
        selectedCategory = anotherCategory;
        selectedProducts = anotherProducts;
      }
    }

    return _CategorySelectionResult(
      selectedCategory: selectedCategory,
      products: selectedProducts,
      categoryProductList: categoryProductList,
    );
  }
}

class _CategorySelectionResult {
  final SuperCategoryModel? selectedCategory;
  final List<ProductModel> products;
  final List<(SuperCategoryModel, List<ProductModel>)> categoryProductList;

  const _CategorySelectionResult({
    required this.selectedCategory,
    required this.products,
    required this.categoryProductList,
  });
}
