// notification_service.dart
import 'dart:async';
import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_timezone/flutter_timezone.dart';

import 'package:timezone/data/latest.dart' as tzl;
import 'package:timezone/timezone.dart' as tz;

part 'notification_service.g.dart';

@riverpod
class NotificationService extends _$NotificationService {
  final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

  final _navigationStreamController = StreamController<String?>.broadcast();
  Stream<String?> get navigationStream => _navigationStreamController.stream;

  @override
  Future<void> build() async {
    // Initialize settings
    const initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await _configureLocalTimeZone();

    await _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _handleNotificationResponse,
    );
  }

  void _handleNotificationResponse(NotificationResponse response) {
    if (response.payload != null) {
      log('Notification payload: ${response.payload}');
    }
  }

  Future<void> showNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'default_channel',
      'Default Channel',
      channelDescription: 'Default notification channel',
      importance: Importance.max,
      priority: Priority.high,
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notificationsPlugin.show(
      0, // notification id
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }

  Future<void> scheduleNotification({
    required String title,
    required String body,
    required DateTime scheduledDate,
    String? payload,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'scheduled_channel',
      'Scheduled Channel',
      channelDescription: 'Channel for scheduled notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );
    await _configureLocalTimeZone();
    await _notificationsPlugin.zonedSchedule(
      1,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.inexact,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: payload,
    );
    listAllNotifications();
  }

  Future<void> cancelAllNotifications() async {
    await _notificationsPlugin.cancelAll();
  }

  Future<void> _configureLocalTimeZone() async {
    tzl.initializeTimeZones();

    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();

    tz.setLocalLocation(tz.getLocation(currentTimeZone));
  }

  void listAllNotifications() {
    _notificationsPlugin.getActiveNotifications().then((value) => log('Active notifications: $value'));
  }
}

// // example_usage.dart
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class NotificationExample extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final notificationState = ref.watch(notificationControllerProvider);

//     return Column(
//       children: [
//         ElevatedButton(
//           onPressed: () {
//             ref.read(notificationControllerProvider.notifier).sendNotification(
//                   'Test Notification',
//                   'This is a test notification',
//                 );
//           },
//           child: const Text('Send Notification'),
//         ),
//         ElevatedButton(
//           onPressed: () {
//             final scheduledDate = DateTime.now().add(const Duration(seconds: 5));
//             ref.read(notificationServiceProvider.notifier).scheduleNotification(
//                   title: 'Scheduled Notification',
//                   body: 'This notification was scheduled',
//                   scheduledDate: scheduledDate,
//                 );
//           },
//           child: const Text('Schedule Notification'),
//         ),
//         if (notificationState.pendingNotifications.isNotEmpty)
//           ListView.builder(
//             shrinkWrap: true,
//             itemCount: notificationState.pendingNotifications.length,
//             itemBuilder: (context, index) {
//               return ListTile(
//                 title: Text(notificationState.pendingNotifications[index]),
//               );
//             },
//           ),
//       ],
//     );
//   }
// }
