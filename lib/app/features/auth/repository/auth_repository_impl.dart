import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/utils/app_utils.dart';
import '../../../provider/http_provider.dart';
import '../../../services/service.dart';
import '../../cart/repository/cart_repository_impl.dart';
import '../model/auth_response.dart';
import 'auth_repository.dart';

part 'auth_repository_impl.g.dart';

class AuthRepositoryImpl extends AuthRepository {
  AuthRepositoryImpl({required AuthService authService}) : _authService = authService;
  final AuthService _authService;

  @override
  FutureOr<AuthResponse?> getUser({required String name, required String pass}) async {
    final AuthResponse response = await _authService.getUserDetail(userLogin: name, password: pass);

    if (response.statusCode == 200) {
      log(response.data.toString(), name: 'createCustomer');

      return response;
    } else {
      return AuthResponse.failure(message: response.message);
    }
  }

  @override
  Future<HttpResponse> lostPassword({required String userLogin}) => _authService.lostPassword(userLogin).onError(
        (error, stackTrace) {
          if (error is DioException && error.response?.statusCode == 302) {
            return HttpResponse('It is Html response',
                Response(requestOptions: RequestOptions(validateStatus: (_) => true), statusCode: 200));
          }
          return HttpResponse(
              'Error', Response(requestOptions: RequestOptions(validateStatus: (_) => false), statusCode: 500));
        },
      );

  @override
  FutureOr<HttpResponse?> createCustomer(
      {required String email, required String password, required String firstName, required String lastName}) async {
    Map<String, dynamic> body = {"email": email, "password": password, "first_name": firstName, "last_name": lastName};

    final HttpResponse response = await _authService.createCustomer(AppUtils.getAuthorizationHeader, body);

    return response;
  }

  @override
  Future<AuthResponse> deleteCustomer({required String name, required String pass}) async {
    final AuthResponse response = await _authService.getUserDetail(userLogin: name, password: pass);

    if (response.statusCode == 200) {
      await _authService.deleteCustomer(AppUtils.getAuthorizationHeader, response.data!.first.id!);
    }

    return response;
  }
}

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  final http = ref.watch(httpProvider).value;

  if (http == null) {
    throw Exception('HTTP client is not initialized yet');
  }

  return AuthRepositoryImpl(authService: AuthService(http));
}
