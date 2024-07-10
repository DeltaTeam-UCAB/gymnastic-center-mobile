import 'package:gymnastic_center/application/notifications/notifications_manager.dart';


class MockNotificationsManager extends NotificationsManager {

  final bool isAuthorized;

  MockNotificationsManager({required this.isAuthorized});
  

  @override
  Future<bool> checkAuthorizationStatus() {
    return Future.value(isAuthorized);
  }

  @override
  Future<String?> getToken() {
    return Future.value('token');
  }

  @override
  void onForegroundMessage(Function(String event) handlerEvent) {}

  @override
  Future<bool> requestPermission() {
    return Future.value(isAuthorized);
  }
   
}