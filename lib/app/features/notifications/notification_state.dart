// notification_state.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_state.freezed.dart';

@freezed
class NotificationState with _$NotificationState {
  const factory NotificationState({
    @Default(false) bool isPermissionGranted,
    @Default([]) List<String> pendingNotifications,
  }) = _NotificationState;
}
