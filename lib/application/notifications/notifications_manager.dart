abstract class NotificationsManager {
  Future<bool> requestPermission();

  Future<bool> checkAuthorizationStatus();

  void onForegroundMessage();

  Future<String?> getToken();
}

abstract class LocalNotificationsManager {
  void showLocalNotification({
    required int id,
    String? title,
    String? body,
    String? data,
  });
}
