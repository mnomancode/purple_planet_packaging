import 'dart:async';

import 'package:retrofit/dio.dart';

import '../model/auth_response.dart';

abstract class AuthRepository {
  FutureOr<AuthResponse?> getUser({required String name, required String pass});

  Future<HttpResponse> lostPassword({required String userLogin});

  FutureOr<HttpResponse?> createCustomer(
      {required String email, required String password, required String firstName, required String lastName});

  FutureOr<AuthResponse?> deleteCustomer({required String name, required String pass});
}
