import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class ReminderService {
  static final _notifications = FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    tz.initializeTimeZones();

    const android = AndroidInitializationSettings('@mipmap/launcher_icon');
    const settings = InitializationSettings(android: android);

    await _notifications.initialize(settings);

    await _requestNotificationPermission();
  }

  static Future<void> _requestNotificationPermission() async {
    if (Platform.isAndroid) {
      final androidInfo = await Permission.notification.status;
      if (androidInfo.isDenied || androidInfo.isRestricted) {
        await Permission.notification.request();
      }
    }
  }

  static Future<void> scheduleReminder({
    required int id,
    required String title,
    required String body,
    required DateTime dateTime,
  }) async {
    await _notifications.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(dateTime, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'reminder_channel',
          'Rappels',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exact,
    );
  }
}
