import 'package:freezed_annotation/freezed_annotation.dart';

import 'auth_user_model.dart';

part 'auth_response.freezed.dart';
part 'auth_response.g.dart';

@freezed
class AuthResponse with _$AuthResponse {
  const factory AuthResponse({
    bool? success,
    int? statusCode,
    String? code,
    String? message,
    List<AuthUserModel>? data,
  }) = _AuthResponse;

  factory AuthResponse.failure({
    int? statusCode,
    String? code,
    String? message,
  }) =>
      AuthResponse(
        success: false,
        statusCode: statusCode,
        code: code,
        message: message,
      );

  factory AuthResponse.fromJson(Map<String, dynamic> json) => _$AuthResponseFromJson(json);
}
