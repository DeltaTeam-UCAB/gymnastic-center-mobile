abstract class NotificationsManager {
  Future<bool> requestPermission();

  Future<bool> checkAuthorizationStatus();

  void onForegroundMessage(Function(String event) handlerEvent);

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
