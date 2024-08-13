import 'package:dio/dio.dart';
import 'package:purple_planet_packaging/app/features/auth/model/auth_user_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../provider/http_provider.dart';
import '../../../services/service.dart';
import 'auth_repository.dart';

part 'auth_repository_impl.g.dart';

class AuthRepositoryImpl extends AuthRepository {
  AuthRepositoryImpl({required AuthService authService}) : _authService = authService;
  final AuthService _authService;

  @override
  Future<AuthUserModel> getUser({required String name, required String pass}) =>
      _authService.getUserDetail(userLogin: name, password: pass);

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
}

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  final http = ref.watch(httpProvider);

  return AuthRepositoryImpl(authService: AuthService(http));
}
