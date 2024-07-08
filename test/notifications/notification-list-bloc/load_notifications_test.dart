import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymnastic_center/application/notifications/notification_list_bloc.dart';
import 'package:gymnastic_center/domain/entities/notifications/notification.dart';
import 'package:gymnastic_center/domain/repositories/notifications/notifications_repository.dart';

import '../utils/mock_notifications_repository.dart';

void main() {
  late NotificationsRepository mockNotificationsRepository;
  late Notification notificationMock;

  setUp(() {
    notificationMock = Notification(
        id: '1',
        title: 'Notification 1',
        body: 'Description 1',
        date: DateTime.parse('2024-07-06 16:27:51.305'),
        read: false);
    mockNotificationsRepository =
        MockNotificationsRepository([notificationMock]);
  });

  blocTest(
    'Should emit NotificationListState with isLoading true and notifications [notification] when loadNextPage is called',
    build: () => NotificationListBloc(
        notificationsRepository: mockNotificationsRepository),
    act: (bloc) => bloc.loadNextPage(),
    expect: () => [
      const NotificationListState(notifications: [], isLoading: true),
      NotificationListState(
          notifications: [notificationMock], isLoading: false, page: 2),
    ],
  );
}
