import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin _plugin =
  FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    // Initialize timezone
    tz.initializeTimeZones();

    const androidSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    await _plugin.initialize(
      const InitializationSettings(android: androidSettings),
    );

    await _plugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  static Future<void> scheduleDailyReminder() async {
    await _plugin.zonedSchedule(
      1001, // fixed ID (important)
      'Habit Wallet',
      'You have not added any transaction today',
      _next8PM(),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_reminder',
          'Daily Reminder',
          channelDescription: 'Daily 8 PM transaction reminder',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time, // 🔁 DAILY
    );
  }

  static Future<void> cancelDailyReminder() async {
    await _plugin.cancel(1001);
  }

  static tz.TZDateTime _next8PM() {
    final now = tz.TZDateTime.now(tz.local);
    final today8PM =
    tz.TZDateTime(tz.local, now.year, now.month, now.day, 20);

    // If already past 8 PM → tomorrow
    if (now.isAfter(today8PM)) {
      return today8PM.add(const Duration(days: 1));
    }

    // Else today at 8 PM
    return today8PM;
  }
}

// static Future<void> showTestNotification() async {
  //   await _plugin.show(
  //     999,
  //     'Test Notification',
  //     'If you see this, notifications work ✅',
  //     const NotificationDetails(
  //       android: AndroidNotificationDetails(
  //         'daily_reminder',
  //         'Daily Reminder',
  //         importance: Importance.high,
  //         priority: Priority.high,
  //       ),
  //     ),
  //   );
  // }

