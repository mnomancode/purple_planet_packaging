part of 'service.dart';

@RestApi()
abstract class CartService {
  factory CartService(Dio dio, {String baseUrl}) = _CartService;

  // @GET('/wp-json/cocart/v2/cart')
  // Future<Cart> getCartFromServer(
  //   @Header('Authorization') String token,
  // );

  @POST('/wp-json/cocart/v2/cart/add-item')
  Future<Cart> addToCart(@Body() AddCartBody body);

  @GET('/wp-json/cocart/v2/cart?cart_key={cartKey}')
  Future<Cart> getCart({@Path('cartKey') String? cartKey});

  @POST('/wp-json/cocart/v2/cart/item/{item_key}?quantity={quantity}')
  Future<Cart> updateItem(
    @Path('item_key') String key, {
    @Path('quantity') int? quantity,
  });

  @DELETE('/wp-json/cocart/v2/cart/item/{item_key}')
  Future<Cart> removeItem(@Path('item_key') String key);

  @GET('/wp-json/wc/v3/shipping/zones/2/methods')
  Future<List<ShippingMethod>> getShippingMethod(
    @Header('Authorization') String token,
  );

  @POST('/wp-json/cocart/v2/cart/apply-coupon/?code={code}')
  Future<Cart> applyCoupon(@Header('Authorization') String getAuthorizationHeader, @Path('code') String code);

  @POST('/wp-json/cocart/v2/cart/remove-item')
  Future<Cart> removeMultipleItems(@Query('key') List<String> keys);
}
