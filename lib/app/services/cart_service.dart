part of 'service.dart';

@RestApi()
abstract class CartService {
  factory CartService(Dio dio, {String baseUrl}) = _CartService;

  @POST('/wp-json/cocart/v2/login')
  Future<HttpResponse> login();

  @GET('/wp-json/cocart/v2/cart')
  Future<Cart> getCartGuestFirstTime();

  @GET('/wp-json/cocart/v2/cart')
  Future<Cart> getCart({@Header('Authorization') String? token});

  @GET('/wp-json/cocart/v2/cart?cart_key={cartKey}')
  Future<Cart> getCartWithKey(@Path('cartKey') String cartKey);

  @POST('/wp-json/cocart/v2/cart/add-item')
  Future<Cart> addToCart(@Body() AddCartBody body, {@Header('Authorization') String? token});
  @POST('/wp-json/cocart/v2/cart/add-item?cart_key={cartKey}')
  Future<Cart> addToCartWithKey(@Body() AddCartBody body, @Path('cartKey') String cartKey);

  @POST('/wp-json/cocart/v2/cart/item/{item_key}')
  Future<Cart> updateItem(
    @Path('item_key') String key, {
    @Query('quantity') int? quantity,
    @Query('cart_key') String? cartKey,
    @Header('Authorization') String? token,
  });

  @DELETE('/wp-json/cocart/v2/cart/item/{item_key}')
  Future<Cart> removeItem(@Path('item_key') String key,
      {@Header('Authorization') String? token, @Query('cart_key') String? cartKey});

  @GET('/wp-json/wc/v3/shipping/zones/2/methods')
  Future<List<ShippingMethod>> getShippingMethod(
    @Header('Authorization') String token,
  );

  @POST('/wp-json/cocart/v2/cart/apply-coupon/?code={code}')
  Future<Cart> applyCoupon(@Header('Authorization') String getAuthorizationHeader, @Path('code') String code);

  @POST('/wp-json/cocart/v2/cart/remove-item')
  Future<Cart> removeMultipleItems(@Query('key') List<String> keys);
}
