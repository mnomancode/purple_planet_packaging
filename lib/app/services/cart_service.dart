part of 'service.dart';

@RestApi()
abstract class CartService {
  factory CartService(Dio dio, {String baseUrl}) = _CartService;

  @GET('/wp-json/wc/store/v1/cart')
  Future<NewCartModel> getCartFromServer(
    @Header('Authorization') String token,
  );

  @POST('/wp-json/wc/store/v1/cart/add-item?id={id}}&quantity={quantity}')
  Future<NewCartModel> addToCart(
    @Path('id') int productId, {
    @Path('quantity') int? quantity,
  });

  @GET('/wp-json/wc/store/v1/cart')
  Future<NewCartModel> getCart();

  @POST('/wp-json/wc/store/v1/cart/update-item?key={itemKey}&quantity={quantity}')
  Future<NewCartModel> updateItem(
    @Path('itemKey') String key, {
    @Path('quantity') int? quantity,
  });

  @POST('/wp-json/wc/store/v1/cart/remove-item?key={itemKey}')
  Future<NewCartModel> removeItem(@Path('itemKey') String key);

  @GET('/wp-json/wc/v3/shipping/zones/2/methods')
  Future<HttpResponse> getShippingMethod(
    @Header('Authorization') String token,
  );
}
