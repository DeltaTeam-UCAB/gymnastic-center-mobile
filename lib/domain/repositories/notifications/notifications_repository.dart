import 'package:gymnastic_center/common/results.dart';
import 'package:gymnastic_center/domain/entities/notifications/notification.dart';

abstract class NotificationsRepository {
  Future<Result<List<Notification>>> getNotificationsPaginated(
      {int page, int perPage});

  Future<Result<Notification>> getNotificationById(String id);

  Future<Result<bool>> markRead(String id);

  Future<Result<int>> getNotRead();

  Future<Result<bool>> deleteAll();
}
