import 'dart:io' show Platform;

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:gymnastic_center/application/notifications/notifications_manager.dart';
import 'package:gymnastic_center/infrastructure/models/push_message_model.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

class FirebaseNotificationsManager extends NotificationsManager {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final LocalNotificationsManager? localNotifications;

  FirebaseNotificationsManager(this.localNotifications);

  static onBackgroundMessage(
      Future<void> Function(RemoteMessage message) handler) {
    FirebaseMessaging.onBackgroundMessage(handler);
  }

  @override
  Future<bool> requestPermission() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );

    return settings.authorizationStatus == AuthorizationStatus.authorized;
  }

  @override
  Future<bool> checkAuthorizationStatus() async {
    final settings = await _firebaseMessaging.getNotificationSettings();
    return settings.authorizationStatus == AuthorizationStatus.authorized;
  }

  @override
  void onForegroundMessage() {
    FirebaseMessaging.onMessage.listen(_handleRemoteMessage);
  }

  void _handleRemoteMessage(RemoteMessage message) {
    if (message.notification == null) return;

    final notification = PushMessageModel(
        messageId:
            message.messageId?.replaceAll(':', '').replaceAll('%', '') ?? '',
        title: message.notification!.title ?? '',
        body: message.notification!.body ?? '',
        sentDate: message.sentTime ?? DateTime.now(),
        data: message.data,
        imageUrl: Platform.isAndroid
            ? message.notification!.android?.imageUrl
            : message.notification!.apple?.imageUrl);

    if (localNotifications != null &&
        localNotifications?.showLocalNotification != null) {
      localNotifications?.showLocalNotification(
        id: 1,
        title: notification.title,
        body: notification.body,
        data: notification.data.toString(),
      );
    }
  }

  @override
  Future<String?> getToken() {
    return _firebaseMessaging.getToken();
  }
}
