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
  FutureOr<List<ProductsModel>> getProducts(int? categoryId) =>
      _categoryService.getProducts(categoryId).then((value) => value).onError((error, stackTrace) {
        log(error.toString());
        log(stackTrace.toString());

        return [];
      });
}

@riverpod
ShopRepository shopRepository(ShopRepositoryRef ref) {
  final http = ref.watch(httpProvider);

  return ShopRepositoryImpl(categoryService: ShopService(http));
}
