part of 'service.dart';

@RestApi()
abstract class CartService {
  factory CartService(Dio dio, {String baseUrl}) = _CartService;

  @GET('/wc/store/v1/cart')
  Future<HttpResponse> getCart();

  @POST('/wc/store/v1/cart/add-item?id={id}}&quantity={quantity}')
  Future<HttpResponse> addToCart({@Path('id') int? productId, @Path('quantity') int quantity});
}
