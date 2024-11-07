part of 'service.dart';

@RestApi(baseUrl: 'https://staging.purpleplanetpackaging.co.uk')
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
      {@Body() required Map<String, dynamic> body});
  // {@Body() Map<String, dynamic> body
  // = const {
  //   'status': 'processing',
  //   'set_paid': true,
  //   'payment_method': 'stripe',
  // }});

  @GET('/wp-json/wc/v3/orders')
  Future<HttpResponse> getOrders();
}
