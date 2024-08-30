import 'dart:developer';

import 'package:purple_planet_packaging/app/models/categories/category.dart';
import 'package:purple_planet_packaging/app/services/service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../models/products/products.dart';
import '../../../provider/http_provider.dart';
import 'shop_repository.dart';

part 'shop_repository_impl.g.dart';

class ShopRepositoryImpl extends ShopRepository {
  ShopRepositoryImpl({required ShopService categoryService}) : _categoryService = categoryService;
  final ShopService _categoryService;
  @override
  FutureOr<List<CategoryModel>> getShopCategories() => _categoryService.getCategories();

  @override
  FutureOr<List<ProductsModel>> getProducts(int? categoryId) => _categoryService.getProducts(categoryId);

  @override
  FutureOr<List<ProductsModel>> searchProducts(String query, {int offset = 0}) {
    return _categoryService.searchProducts(query, offset: offset);
  }

  @override
  FutureOr<List<ProductsModel>> getFeatureProducts({int offset = 0}) =>
      _categoryService.getFeatureProducts(offset: offset);
}

@riverpod
ShopRepository shopRepository(ShopRepositoryRef ref) {
  final http = ref.watch(httpProvider);

  return ShopRepositoryImpl(categoryService: ShopService(http));
}
