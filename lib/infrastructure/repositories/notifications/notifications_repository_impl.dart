import 'package:gymnastic_center/common/results.dart';
import 'package:gymnastic_center/domain/datasources/notifications/notifications_datasource.dart';
import 'package:gymnastic_center/domain/entities/notifications/notification.dart';
import 'package:gymnastic_center/domain/repositories/notifications/notifications_repository.dart';

class NotificationRespositoryImpl implements NotificationsRepository {
  final NotificationsDatasource notificationsDatasource;

  NotificationRespositoryImpl({required this.notificationsDatasource});

  @override
  Future<Result<bool>> deleteAll() async {
    try {
      await notificationsDatasource.deleteAll();
      return Result.success(true);
    } catch (error, _) {
      return Result<bool>.fail(error as Exception);
    }
  }

  @override
  Future<Result<int>> getNotRead() async {
    try {
      final count = await notificationsDatasource.getNotRead();
      return Result<int>.success(count);
    } catch (error, _) {
      return Result.fail(error as Exception);
    }
  }

  @override
  Future<Result<Notification>> getNotificationById(String id) async {
    try {
      final notification =
          await notificationsDatasource.getNotificationById(id);
      return Result<Notification>.success(notification);
    } catch (error, _) {
      return Result.fail(error as Exception);
    }
  }

  @override
  Future<Result<List<Notification>>> getNotificationsPaginated(
      {int page = 1, int perPage = 10}) async {
    try {
      final notifications = await notificationsDatasource
          .getNotificationsPaginated(page: page, perPage: perPage);
      return Result<List<Notification>>.success(notifications);
    } catch (error, _) {
      return Result<List<Notification>>.fail(error as Exception);
    }
  }

  @override
  Future<Result<bool>> markRead(String id) async {
    try {
      await notificationsDatasource.markRead(id);
      return Result.success(true);
    } catch (error, _) {
      return Result<bool>.fail(error as Exception);
    }
  }
}
