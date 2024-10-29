part of 'service.dart';

@RestApi()
abstract class ShopService {
  factory ShopService(Dio dio, {String baseUrl}) = _ShopService;

  @GET('/wp-json/wc/v3/products/categories?per_page=100')
  Future<List<CategoryModel>> getCategories(@Header('Authorization') String token);

  @GET('/wp-json/wc/v3/products?category={categoryId} & per_page=100')
  Future<List<Product>> getProducts(@Header('Authorization') String token, @Path('categoryId') int? categoryId);

  @GET('/wp-json/wc/v3/products?search={search}&offset={offset}')
  Future<List<Product>> searchProducts(@Header('Authorization') String token, @Path('search') String search,
      {@Path('offset') int offset = 0});

  @GET('/wp-json/wc/v3/products/{id}')
  Future<Product> getProductById(@Header('Authorization') String token, @Path('id') int id);

  @GET('/wp-json/wc/v3/products?featured=true&offset={offset}')
  Future<List<Product>> getFeatureProducts(@Header('Authorization') String token, {@Path('offset') int offset = 0});

  @GET('/wp-json/wc/v3/products/attributes/2/terms')
  Future<List<Term>> getFoodType(@Header('Authorization') String token);

  @GET('/wp-json/wc/v3/products?attribute=2&attribute_term={term}')
  Future<List<Product>> getProductsByTerm(@Header('Authorization') String token, @Path('term') String term);
}
