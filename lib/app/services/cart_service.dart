part of 'service.dart';

@RestApi()
abstract class CartService {
  factory CartService(Dio dio, {String baseUrl}) = _CartService;

  @GET('/wp-json/wc/store/v1/cart')
  Future<HttpResponse> getCartFromServer(
    @Header('Authorization') String token,
  );

  @POST('/wp-json/wc/store/v1/cart/add-item?id={id}}&quantity={quantity}')
  Future<HttpResponse> addToCart(
    @Path('id') int productId, {
    @Path('quantity') int? quantity,
  });

  @GET('/wp-json/wc/store/v1/cart')
  Future<HttpResponse> getCart();
}
