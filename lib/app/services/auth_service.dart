part of 'service.dart';

@RestApi()
abstract class AuthService {
  factory AuthService(Dio dio, {String baseUrl}) = _AuthService;

  @POST('/wp-json/jwt-auth/v1/token?username={user_login}&password={password}')
  Future<AuthResponse> getUserDetail({
    @Path('user_login') required String userLogin,
    @Path('password') required String password,
  });

  // @POST('/wp-json/jwt-auth/v1/token/refresh')
  // Future<HttpResponse> refreshToken(@Header('Authorization') String token);

  @POST('/wp-login.php?action=lostpassword')
  @FormUrlEncoded()
  Future<HttpResponse> lostPassword(@Field('user_login') String userLogin);

  @POST('/wp-json/wc/v3/customers')
  Future<HttpResponse> createCustomer(@Header('Authorization') String token, @Body() Map<String, dynamic> body);

  @DELETE('wp-json/wc/v3/customers/{customer_id}?force=true')
  Future<HttpResponse> deleteCustomer(@Header('Authorization') String token, @Path('customer_id') int customerId);
}
