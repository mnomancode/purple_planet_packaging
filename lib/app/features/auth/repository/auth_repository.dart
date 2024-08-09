import 'package:purple_planet_packaging/app/models/auth_user_model.dart';

abstract class AuthRepository {
  Future<AuthUserModel> getUser({required String name, required String pass});
}
