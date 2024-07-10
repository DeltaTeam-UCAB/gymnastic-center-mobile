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
      isAuthorized: false,
    );
    mockNotificationsRepository = MockNotificationsRepository(
      [],
    );
  });

  blocTest(
    'Should emit NotificationState with state [false] when the bloc is created and the user did not authorize the notifications', 
    build: () => NotificationsBloc(mockNotificationsManager, mockNotificationsRepository.saveToken),
    expect: () => [
      const NotificationsState(status: false, token: ''),
    ],
  );
}
