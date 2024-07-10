import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymnastic_center/application/notifications/notification_list_bloc.dart';
import 'package:gymnastic_center/domain/entities/notifications/notification.dart';
import 'package:gymnastic_center/domain/repositories/notifications/notifications_repository.dart';

import '../utils/mock_notifications_repository.dart';

void main() {
  late NotificationsRepository mockNotificationsRepository;
  late Notification notificationMock1;
  late Notification notificationMock2;
  late Notification notificationMock3;

  setUp(() {
    notificationMock1 = Notification(
        id: '1',
        title: 'Notification 1',
        body: 'Description 1',
        date: DateTime.parse('2024-07-06 16:27:51.305'),
        read: false);
    notificationMock2 = Notification(
        id: '2',
        title: 'Notification 2',
        body: 'Description 2',
        date: DateTime.parse('2024-07-06 16:27:51.305'),
        read: false);
    notificationMock3 = Notification(
        id: '3',
        title: 'Notification 3',
        body: 'Description 3',
        date: DateTime.parse('2024-07-06 16:27:51.305'),
        read: false);
    mockNotificationsRepository = MockNotificationsRepository(
        [notificationMock1, notificationMock2, notificationMock3]);
  });

  blocTest(
    'Should emit NotificationListState with state.notifications empty when deleteAllNotifications is called',
    build: () => NotificationListBloc(
        notificationsRepository: mockNotificationsRepository),
    seed: () => NotificationListState(notifications: [
      notificationMock1,
      notificationMock2,
      notificationMock3
    ]),
    act: (bloc) async {
      await bloc.markNotificationRead('2');
    },
    expect: () => [
      isA<NotificationListState>()
          .having(
              (state) => state.notifications[1].id, 'notification 2 id', '2')
          .having((state) => state.notifications[1].read, 'notification 2 read',
              true)
          .having((state) => state.notifications[0], 'notification 1 intect',
              notificationMock1)
          .having((state) => state.notifications[2], 'notification 3 intect',
              notificationMock3),
    ],
  );
}
