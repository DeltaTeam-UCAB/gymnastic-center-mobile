import 'package:dio/dio.dart';
import 'package:gymnastic_center/application/key_value_storage/key_value_storage.dart';
import 'package:gymnastic_center/domain/datasources/notifications/notifications_datasource.dart';
import 'package:gymnastic_center/domain/entities/notifications/notification.dart';
import 'package:gymnastic_center/infrastructure/core/constants/environment.dart';
import 'package:gymnastic_center/infrastructure/mappers/notification_mapper.dart';
import 'package:gymnastic_center/infrastructure/models/notifications/notification_response.dart';

class NotificationsDatasourceImpl implements NotificationsDatasource {
  final KeyValueStorageService keyValueStorage;
  final dio = Dio(BaseOptions(baseUrl: Environment.backendApi));

  NotificationsDatasourceImpl(this.keyValueStorage) {
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      final token = await keyValueStorage.getValue<String>('token');
      options.headers['Authorization'] = 'Bearer $token';
      return handler.next(options);
    }));
  }

  @override
  Future<bool> deleteAll() async {
    await dio.delete('/notifications/delete/all');
    return true;
  }

  @override
  Future<int> getNotRead() async {
    final response = await dio.get('/notifications/count/not-readed');
    return response.data["count"];
  }

  @override
  Future<Notification> getNotificationById(String id) async {
    final response = await dio.get('/notifications/one/$id');
    final notificationResponse = NotificationResponse.fromJson(response.data);
    return NotificationMapper.notificationToEntity(notificationResponse);
  }

  @override
  Future<List<Notification>> getNotificationsPaginated(
      {int page = 1, int perPage = 10}) async {
    final queryParameters = {'page': page, 'perPage': perPage};
    final response =
        await dio.get('/notifications/many', queryParameters: queryParameters);
    final List<Notification> notifications = [];

    for (final noti in response.data ?? []) {
      final notificationResponse = NotificationResponse.fromJson(noti);
      notifications
          .add(NotificationMapper.notificationToEntity(notificationResponse));
    }
    return notifications;
  }

  @override
  Future<bool> markRead(String id) async {
    await dio.put('/notifications/mark/$id');
    return true;
  }

  @override
  Future<bool> saveToken(String token) async {
    await dio.post('/notifications/savetoken', data: {'token': token});
    return true;
  }
}
