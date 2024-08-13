import 'package:purple_planet_packaging/app/features/auth/model/auth_user_model.dart';
import 'package:retrofit/dio.dart';

abstract class AuthRepository {
  Future<AuthUserModel> getUser({required String name, required String pass});

  Future<HttpResponse> lostPassword({required String userLogin});
}
