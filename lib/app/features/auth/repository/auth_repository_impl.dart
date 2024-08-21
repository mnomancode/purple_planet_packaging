import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../provider/http_provider.dart';
import '../../../services/service.dart';
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
  Future<HttpResponse> getCart(token) => _authService.getCart(token);
}

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  final http = ref.watch(httpProvider);

  return AuthRepositoryImpl(authService: AuthService(http));
}
