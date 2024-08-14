// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
part 'auth_user_model.freezed.dart';
part 'auth_user_model.g.dart';

@freezed
class AuthUserModel with _$AuthUserModel {
  const factory AuthUserModel({
    required String? token,
    required int? id,
    @JsonKey(name: 'email') required String? userEmail,
    @JsonKey(name: 'nicename') required String? userNicename,
    @JsonKey(name: 'displayName') required String? userDisplayName,
  }) = _AuthUserModel;

  factory AuthUserModel.fromJson(Map<String, dynamic> json) => _$AuthUserModelFromJson(json);
}
