import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gymnastic_center/application/notifications/notifications_manager.dart';

class LocalNotifications extends LocalNotificationsManager {
  @override
  void showLocalNotification({
    required int id,
    String? title,
    String? body,
    String? data,
  }) {
    const androidDetails = AndroidNotificationDetails(
      'channelId',
      'channelName',
      playSound: true,
      importance: Importance.max,
      priority: Priority.high,
    );

    const notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(
        presentSound: true,
      )
    );

    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    flutterLocalNotificationsPlugin.show(id, title, body, notificationDetails,
        payload: data);
  }

  Future<void> initializeLocalNotifications() async {
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    const initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    final initializationSettingsDarwin = DarwinInitializationSettings(
      onDidReceiveLocalNotification: iosShowNotification,
    );

    final initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
    );
  }

  void iosShowNotification(int id, String? title, String? body, String? data){
    showLocalNotification(id: id, title: title, body: body, data: data);
  }

  void onDidReceiveNotificationResponse(NotificationResponse response) {
    // Handle the notification response
  }
}
