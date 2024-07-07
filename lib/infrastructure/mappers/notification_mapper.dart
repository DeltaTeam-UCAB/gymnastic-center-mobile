import 'package:gymnastic_center/domain/entities/notifications/notification.dart';
import 'package:gymnastic_center/infrastructure/models/notifications/notification_response.dart';

class NotificationMapper {
  static Notification notificationToEntity(NotificationResponse resp) {
    return Notification(
        id: resp.id,
        title: resp.title,
        body: resp.body,
        date: DateTime.parse(resp.date),
        read: resp.read);
  }
}
