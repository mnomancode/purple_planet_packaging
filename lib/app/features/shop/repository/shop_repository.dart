import 'package:purple_planet_packaging/app/models/categories/category.dart';
import 'package:purple_planet_packaging/app/models/products/products.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

abstract class ShopRepository {
  FutureOr<List<CategoryModel>> getShopCategories();

  FutureOr<List<ProductsModel>> getProducts(int? categoryId);

  FutureOr<List<ProductsModel>> searchProducts(String query, {int offset = 0});

  FutureOr<List<ProductsModel>> getFeatureProducts({int offset = 0});
}
