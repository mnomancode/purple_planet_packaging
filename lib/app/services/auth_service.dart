part of 'service.dart';

@RestApi()
abstract class AuthService {
  factory AuthService(Dio dio, {String baseUrl}) = _AuthService;

  @POST('/wp-json/jwt-auth/v1/token?username={user_login}&password={password}')
  Future<AuthUserModel> getUserDetail({
    @Path('user_login') required String userLogin,
    @Path('password') required String password,
  });

  @POST('/wp-login.php?action=lostpassword')
  @FormUrlEncoded()
  Future<HttpResponse> lostPassword(@Field('user_login') String userLogin);
}
