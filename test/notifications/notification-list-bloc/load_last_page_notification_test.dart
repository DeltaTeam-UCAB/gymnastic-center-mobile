import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymnastic_center/application/notifications/notification-list/notification_list_bloc.dart';
import 'package:gymnastic_center/domain/repositories/notifications/notifications_repository.dart';

import '../utils/mock_notifications_repository.dart';

void main() {
  late NotificationsRepository mockNotificationRepository;

  setUp(() {
    mockNotificationRepository = MockNotificationsRepository([]);
  });

  blocTest(
    'Should emit CoursesState with isLoading false and isLastPage true when loadNextPage is called and no courses are found',
    build: () => NotificationListBloc(
        notificationsRepository: mockNotificationRepository),
    act: (bloc) => bloc.loadNextPage(),
    expect: () => [
      const NotificationListState(notifications: [], isLoading: true),
      const NotificationListState(
          notifications: [], isLoading: false, isLastPage: true)
    ],
  );
}
