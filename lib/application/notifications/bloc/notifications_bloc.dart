import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/notifications/notifications_manager.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';


class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {

  final NotificationsManager notifications;
  
  NotificationsBloc(this.notifications) : super(const NotificationsState()) {

    on<NotificationStatusChanged>(_notificationStatusChanged);

    // Verify the current status of the notifications
    _initialStatusCheck();

    // Listen for messages when the app is in the foreground
    _onForegroundMessage();
  }

  void _onForegroundMessage() {
    notifications.onForegroundMessage();
  }

  void _getToken() async {
    if (!state.status) return;

    final token = await notifications.getToken();
    print(token);
  }

  void requestPermission() async {
    final authorizationStatus = await notifications.requestPermission();
    add(NotificationStatusChanged(authorizationStatus));
  }

  void _initialStatusCheck() async {
    final authorizationStatus = await notifications.checkAuthorizationStatus();
    add(NotificationStatusChanged(authorizationStatus));
  }

  void _notificationStatusChanged( NotificationStatusChanged event, Emitter<NotificationsState> emit) {
    emit(state.copyWith(status: event.status));
    _getToken();
  }
}
