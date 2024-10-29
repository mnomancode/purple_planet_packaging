import 'package:purple_planet_packaging/app/models/categories/term.dart';
import 'package:purple_planet_packaging/app/models/categories/category.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../models/products/product.dart';

abstract class ShopRepository {
  FutureOr<List<CategoryModel>> getShopCategories();

  FutureOr<List<Product>> getProducts(int? categoryId);

  FutureOr<List<Product>> searchProducts(String query, {int offset = 0});

  FutureOr<List<Product>> getFeatureProducts({int offset = 0});

  FutureOr<Product> getProduct(int id);

  FutureOr<List<Term>> getFoodTypes();
  Future<List<Product>> getProductsByTerm(String term);
}
