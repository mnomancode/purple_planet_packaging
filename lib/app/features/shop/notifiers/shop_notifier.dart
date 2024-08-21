import 'package:purple_planet_packaging/app/models/categories/category.dart';
import 'package:purple_planet_packaging/app/models/products/products.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../repository/shop_repository_impl.dart';

part 'shop_notifier.g.dart';

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
    // ref.keepAlive();

    return products;
  }
}
