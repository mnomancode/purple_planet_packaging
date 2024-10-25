import 'package:purple_planet_packaging/app/core/utils/app_utils.dart';
import 'package:purple_planet_packaging/app/models/categories/category.dart';
import 'package:purple_planet_packaging/app/services/service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../models/products/product.dart';
import '../../../provider/http_provider.dart';
import 'shop_repository.dart';

part 'shop_repository_impl.g.dart';

class ShopRepositoryImpl extends ShopRepository {
  ShopRepositoryImpl({required ShopService categoryService}) : _categoryService = categoryService;
  final ShopService _categoryService;
  @override
  FutureOr<List<CategoryModel>> getShopCategories() => _categoryService.getCategories(AppUtils.getAuthorizationHeader);

  @override
  FutureOr<List<Product>> getProducts(int? categoryId) =>
      _categoryService.getProducts(AppUtils.getAuthorizationHeader, categoryId);

  @override
  FutureOr<List<Product>> searchProducts(String query, {int offset = 0}) {
    return _categoryService.searchProducts(AppUtils.getAuthorizationHeader, query, offset: offset);
  }

  @override
  FutureOr<List<Product>> getFeatureProducts({int offset = 0}) =>
      _categoryService.getFeatureProducts(AppUtils.getAuthorizationHeader, offset: offset);
}

@riverpod
ShopRepository shopRepository(ShopRepositoryRef ref) {
  final http = ref.watch(httpProvider);

  return ShopRepositoryImpl(categoryService: ShopService(http));
}
