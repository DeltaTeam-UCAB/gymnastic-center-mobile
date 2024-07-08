import 'package:gymnastic_center/domain/entities/notifications/notification.dart';

abstract class NotificationsDatasource {
  Future<List<Notification>> getNotificationsPaginated({int page, int perPage});

  Future<Notification> getNotificationById(String id);

  Future<bool> markRead(String id);

  Future<int> getNotRead();

  Future<bool> deleteAll();

  Future<bool> saveToken(String token);
}
