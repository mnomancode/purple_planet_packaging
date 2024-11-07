// notification_controller.dart
import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'notification_service.dart';
import 'notification_state.dart';

part 'notification_controller.g.dart';

@riverpod
class NotificationController extends _$NotificationController {
  @override
  NotificationState build() {
    return const NotificationState();
  }

  Future<void> checkPermission() async {
    final notificationService = ref.read(notificationServiceProvider.notifier);
    // Add permission check logic here
    state = state.copyWith(isPermissionGranted: true);
  }

  Future<void> sendNotification(String title, String body) async {
    final notificationService = ref.read(notificationServiceProvider.notifier);
    await notificationService.showNotification(
      title: title,
      body: body,
    );

    state = state.copyWith(
      pendingNotifications: [...state.pendingNotifications, title],
    );
  }

  Future<void> scheduleNotification(String title, String body, DateTime scheduledDate, {String? payload}) async {
    final notificationService = ref.read(notificationServiceProvider.notifier);
    await notificationService.scheduleNotification(
      title: title,
      body: body,
      scheduledDate: scheduledDate,
      payload: payload,
    );
  }

  Future<void> cancelAllNotifications() async {
    final notificationService = ref.read(notificationServiceProvider.notifier);
    await notificationService.cancelAllNotifications();
  }
}
