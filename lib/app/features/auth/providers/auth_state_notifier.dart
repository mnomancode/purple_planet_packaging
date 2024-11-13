import 'dart:developer';

import 'package:purple_planet_packaging/app/core/utils/http_utils.dart';
import 'package:purple_planet_packaging/app/features/auth/repository/auth_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../provider/shared_preferences_storage_service_provider.dart';
import '../model/auth_result.dart';
import '../model/auth_state.dart';

part 'auth_state_notifier.g.dart';

@riverpod
class AuthStateNotifier extends _$AuthStateNotifier {
  @override
  AuthState build() {
    return const AuthState.unknown();
  }

  void toggleIsNewUser() {
    state = state.copiedWithIsNewUser(!state.isNewUser);
  }

  FutureOr<AuthState> login(String name, String pass) async {
    state = state.copiedWithIsLoading(true);

    final response = await ref.read(authRepositoryProvider).getUser(name: name, pass: pass);

    if (response != null && response.statusCode == 200) {
      state = AuthState(
        result: AuthResult.success,
        isLoading: false,
        message: response.message,
        authUserModel: response.data!.first,
      );
      ref.read(storageServiceProvider).saveToken(response.data!.first.token!);
      ref
          .read(storageServiceProvider)
          .putString('name', response.data!.first.userDisplayName ?? response.data!.first.userNicename ?? '');
      ref.read(storageServiceProvider).putString('email', response.data!.first.userEmail ?? '');
    } else {
      state = AuthState(
        result: AuthResult.failure,
        isLoading: false,
        message: response?.message,
        authUserModel: null,
      );
    }

    return state;
  }

  Future<String> forgotPassword(String username) async {
    final response = await ref.read(authRepositoryProvider).lostPassword(userLogin: username);

    HttpUtils.getForgetMessage(response.response.data.toString());

    if (response.response.statusCode == 200) {
      return HttpUtils.getForgetMessage(response.response.data.toString());
    }

    return 'Please check your email to reset your password';
  }
}
