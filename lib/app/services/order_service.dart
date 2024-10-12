part of 'service.dart';

@RestApi()
abstract class OrderService {
  factory OrderService(Dio dio, {String baseUrl}) = _OrderService;
  @POST('/wp-json/wc/v3/orders')
  Future<Order> newOrder(
    @Header('Authorization') String token,
    @Body() OrderBody? body, {
    @Header('Content-Type') String? contentType = 'application/json',
  });

  @PUT('/wp-json/wc/v3/orders/{id}')
  Future<Order> completePayment(@Header('Authorization') String token, @Path('id') int id,
      {@Body() Map<String, dynamic> body = const {'set_paid': true}});

  @GET('/wp-json/wc/v3/orders')
  Future<HttpResponse> getOrders();
}
