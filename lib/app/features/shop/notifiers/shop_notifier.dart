import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:purple_planet_packaging/app/models/categories/category.dart';
import 'package:purple_planet_packaging/app/models/products/products.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../repository/shop_repository_impl.dart';

part 'shop_notifier.g.dart';
part 'shop_notifier.freezed.dart';

@riverpod
class ShopNotifier extends _$ShopNotifier {
  @override
  FutureOr<List<CategoryModel>> build() async {
    final categories = ref.watch(shopRepositoryProvider).getShopCategories();

    ref.keepAlive();

    return categories;
  }

  // // get products
  // FutureOr<List<ProductsModel>> getProducts([int? categoryId]) =>
  //     ref.watch(shopRepositoryProvider).getProducts(categoryId);
}

@riverpod
class ProductsNotifier extends _$ProductsNotifier {
  @override
  FutureOr<List<ProductsModel>> build({int? categoryId}) async {
    final products = ref.watch(shopRepositoryProvider).getProducts(categoryId);
    ref.keepAlive();

    return products;
  }

  // get feature products
  FutureOr<List<ProductsModel>> getFeatureProducts() {
    final featured = ref.watch(shopRepositoryProvider).getFeatureProducts();
    ref.keepAlive();

    return featured;
  }
}

@freezed
class ProductSearchSate with _$ProductSearchSate {
  const factory ProductSearchSate({
    @Default(0) int offset,
    @Default(false) bool isLoading,
    @Default(false) bool isLoadMoreError,
    @Default([]) List<ProductsModel> products,
  }) = _ProductSearchSate;
}

@riverpod
class SearchProductsNotifier extends _$SearchProductsNotifier {
  @override
  Future<ProductSearchSate> build(String? query) {
    return _loadProducts(query: query);
  }

  Future<ProductSearchSate> _loadProducts({String? query, int offset = 0}) async {
    final products = await ref.watch(shopRepositoryProvider).searchProducts(query ?? '', offset: offset);

    return ProductSearchSate(products: products, offset: offset);
  }

  loadMore({String? query}) {
    update((p) async {
      final newState = p.copyWith(isLoading: true);

      return newState;
    });

    update((p) async {
      final products = await ref.watch(shopRepositoryProvider).searchProducts(query ?? '', offset: p.offset + 10);
      final newState = p.copyWith(isLoading: false, products: [...p.products, ...products], offset: p.offset + 10);
      ref.keepAlive();

      return newState;
    });
  }
}
