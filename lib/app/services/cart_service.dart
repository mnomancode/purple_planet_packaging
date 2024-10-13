part of 'service.dart';

@RestApi()
abstract class CartService {
  factory CartService(Dio dio, {String baseUrl}) = _CartService;

  @GET('/wp-json/wc/store/v1/cart')
  Future<Cart> getCartFromServer(
    @Header('Authorization') String token,
  );

  @POST('/wp-json/wc/store/v1/cart/add-item?id={id}}&quantity={quantity}')
  Future<Cart> addToCart(
    @Path('id') int productId, {
    @Path('quantity') int? quantity,
  });

  @GET('/wp-json/wc/store/v1/cart')
  Future<Cart> getCart();

  @POST('/wp-json/wc/store/v1/cart/update-item?key={itemKey}&quantity={quantity}')
  Future<Cart> updateItem(
    @Path('itemKey') String key, {
    @Path('quantity') int? quantity,
  });

  @POST('/wp-json/wc/store/v1/cart/remove-item?key={itemKey}')
  Future<Cart> removeItem(@Path('itemKey') String key);

  @GET('/wp-json/wc/v3/shipping/zones/2/methods')
  Future<List<ShippingMethod>> getShippingMethod(
    @Header('Authorization') String token,
  );

  @POST('/wp-json/wc/store/v1/cart/apply-coupon/?code={code}')
  Future<Cart> applyCoupon(@Header('Authorization') String getAuthorizationHeader, @Path('code') String code);
}
