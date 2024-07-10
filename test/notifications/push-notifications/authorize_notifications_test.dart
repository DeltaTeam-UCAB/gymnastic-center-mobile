import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymnastic_center/application/notifications/bloc/notifications_bloc.dart';
import 'package:gymnastic_center/application/notifications/notifications_manager.dart';
import 'package:gymnastic_center/domain/repositories/notifications/notifications_repository.dart';

import '../utils/mock_notifications_manager.dart';
import '../utils/mock_notifications_repository.dart';

void main() {
  late NotificationsManager mockNotificationsManager;
  late NotificationsRepository mockNotificationsRepository;

  setUp(() {
    mockNotificationsManager = MockNotificationsManager(
      isAuthorized: true,
    );
    mockNotificationsRepository = MockNotificationsRepository(
      [],
    );
  });

  blocTest(
    'Should emit NotificationState with state [true] when requestPermission is called and the user authorized the notifications', 
    build: () => NotificationsBloc(mockNotificationsManager, mockNotificationsRepository.saveToken),
    act: (bloc) => bloc.requestPermission(),
    expect: () => [
      const NotificationsState(status: true, token: 'token'),
    ],
  );
}
