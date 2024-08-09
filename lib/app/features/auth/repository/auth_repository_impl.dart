import 'package:purple_planet_packaging/app/models/auth_user_model.dart';
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
}

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  final http = ref.watch(httpProvider);

  return AuthRepositoryImpl(authService: AuthService(http));
}
