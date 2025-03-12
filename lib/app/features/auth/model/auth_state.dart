import 'package:flutter/foundation.dart' show immutable;
import 'package:freezed_annotation/freezed_annotation.dart';

import 'auth_result.dart';
import 'auth_user_model.dart';

@immutable
class AuthState {
  final AuthResult? result;
  final bool isLoading;
  final bool isNewUser;
  final String? message;
  final AuthUserModel? authUserModel;

  const AuthState({
    required this.result,
    required this.isLoading,
    this.isNewUser = false,
    required this.message,
    required this.authUserModel,
  });

  const AuthState.unknown()
      : result = null,
        isLoading = false,
        isNewUser = false,
        message = null,
        authUserModel = null;

  AuthState copiedWithIsLoading(bool isLoading) => AuthState(
        result: result,
        isLoading: isLoading,
        isNewUser: isNewUser,
        message: message,
        authUserModel: authUserModel,
      );

  AuthState copiedWithIsNewUser(bool isNewUser) => AuthState(
        result: result,
        isLoading: isLoading,
        isNewUser: isNewUser,
        message: message,
        authUserModel: authUserModel,
      );

  @override
  bool operator ==(covariant AuthState other) =>
      identical(this, other) ||
      (result == other.result &&
          isLoading == other.isLoading &&
          authUserModel == other.authUserModel &&
          message == other.message);

  @override
  int get hashCode => Object.hash(
        result,
        isLoading,
        message,
        authUserModel,
      );
}
