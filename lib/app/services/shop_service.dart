part of 'service.dart';

@RestApi()
abstract class ShopService {
  factory ShopService(Dio dio, {String baseUrl}) = _ShopService;

  @GET('/wp-json/wc/store/v1/products/categories')
  Future<List<CategoryModel>> getCategories();

  @GET('/wp-json/wc/store/v1/products?category={categoryId} & per_page=100')
  Future<List<ProductsModel>> getProducts(@Path('categoryId') int? categoryId);

  // /wp-json/wc/store/v1/products/categories?category=535

  // search products
  // /wp-json/wc/store/v1/products?search=red
  @GET('/wp-json/wc/store/v1/products?search={search}&offset={offset}')
  Future<List<ProductsModel>> searchProducts(@Path('search') String search, {@Path('offset') int offset = 0});
}
