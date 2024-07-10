import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymnastic_center/application/notifications/notification_list_bloc.dart';
import 'package:gymnastic_center/domain/repositories/notifications/notifications_repository.dart';
import '../utils/mock_notifications_repository.dart';

void main() {
  late NotificationsRepository mockNotificationRepository;

  setUp(() {
    mockNotificationRepository = MockNotificationsRepository([], true);
  });

  blocTest(
    'Should emit NotificationListState with isLoading true and isError true when loadNextPage is called and an error occurs',
    build: () => NotificationListBloc(
        notificationsRepository: mockNotificationRepository),
    act: (bloc) => bloc.loadNextPage(),
    expect: () => [
      const NotificationListState(notifications: [], isLoading: true),
      const NotificationListState(
          notifications: [], isLoading: false, isError: true)
    ],
  );
}
