import 'package:gymnastic_center/common/results.dart';
import 'package:gymnastic_center/domain/entities/notifications/notification.dart';
import 'package:gymnastic_center/domain/repositories/notifications/notifications_repository.dart';

class MockNotificationsRepository implements NotificationsRepository {
  final List<Notification> notifications;
  final bool shouldFail;

  MockNotificationsRepository(this.notifications, [this.shouldFail = false]);

  @override
  Future<Result<bool>> deleteAll() {
    if (shouldFail) {
      return Future.value(Result.fail(Exception('An error occurred')));
    }
    if (notifications.isEmpty) {
      return Future.value(Result.fail(Exception('No notifications found')));
    }
    notifications.clear();
    return Future.value(Result.success(true));
  }

  @override
  Future<Result<int>> getNotRead() {
    throw UnimplementedError();
  }

  @override
  Future<Result<Notification>> getNotificationById(String id) {
    if (notifications.isEmpty) {
      return Future.value(Result.fail(Exception('No notifications found')));
    }
    final notification =
        notifications.firstWhere((element) => element.id == id);
    return Future.value(Result.success(notification));
  }

  @override
  Future<Result<List<Notification>>> getNotificationsPaginated(
      {int page = 1, int perPage = 5}) {
    if (shouldFail) {
      return Future.value(Result.fail(Exception('An error occurred')));
    }
    return Future.value(Result.success(notifications));
  }

  @override
  Future<Result<bool>> markRead(String id) {
    throw UnimplementedError();
  }
}
