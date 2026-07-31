  import 'package:flutter_local_notifications/flutter_local_notifications.dart';
  import 'package:timezone/timezone.dart' as tz;
  import 'package:timezone/data/latest.dart' as tz_data;

  class NotificationService {
    static final FlutterLocalNotificationsPlugin _plugin =
        FlutterLocalNotificationsPlugin();

    static Future<void> init() async {
      tz_data.initializeTimeZones();

      const androidSettings =
          AndroidInitializationSettings('@mipmap/ic_launcher');

      const iosSettings = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      );

      const settings = InitializationSettings(
        android: androidSettings,
        iOS: iosSettings,
      );

      await _plugin.initialize(settings);
    }

    // Programmer notif
    static Future<void> scheduleNotification({
      required int id,
      required String title,
      required String body,
      required DateTime scheduledDate,
    }) async {
      final scheduled = tz.TZDateTime.from(scheduledDate, tz.local);
      final now = tz.TZDateTime.now(tz.local);

      await _plugin.zonedSchedule(
        id,
        title,
        body,
        scheduled,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'tasky_channel',
            'Rappels de tâches',
            channelDescription: 'Notifications pour rappeler vos tâches',
            importance: Importance.max,
            priority: Priority.high,
          ),
          iOS: DarwinNotificationDetails(),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    }

    // static Future<void> showNow() async {
    //   print('showNow() APPELÉE');
    //   await _plugin.show(
    //     999,
    //     'Test Tasky',
    //     ' Notifications marchent !',
    //     const NotificationDetails(
    //       android: AndroidNotificationDetails(
    //         'tasky_channel',
    //         'Rappels de tâches',
    //         importance: Importance.max,
    //         priority: Priority.high,
    //       ),
    //       iOS: DarwinNotificationDetails(),
    //     ),
    //   );
    // }
  } 