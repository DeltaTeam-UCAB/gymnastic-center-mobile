import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/notifications/notifications_manager.dart';
import 'package:gymnastic_center/common/results.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

typedef SaveTokenCallBack = Future<Result<bool>> Function(String token);

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  final NotificationsManager notifications;
  final SaveTokenCallBack saveTokenCallBack;

  NotificationsBloc(this.notifications, this.saveTokenCallBack)
      : super(const NotificationsState()) {
    on<NotificationStatusChanged>(_notificationStatusChanged);
    on<RecoveryNotification>(_onRecoveryNotification);
    on<ResetRecoveredNotification>(_onResetRecoveredNotification);

    // Verify the current status of the notifications
    initialStatusCheck();

    // Listen for messages when the app is in the foreground
    _onForegroundMessage();
  }

  void _onResetRecoveredNotification(
      ResetRecoveredNotification event, Emitter<NotificationsState> emit) {
    emit(state.copyWith(recoveryCode: ''));
  }

  void _onRecoveryNotification(RecoveryNotification event, Emitter<NotificationsState> emit) {
    emit(state.copyWith(recoveryCode: event.recoveryCode));
  }

  void _onForegroundMessage() {
    notifications.onForegroundMessage(_handleRemoteMessage);
  }

  Future<String?> _getToken() async {
    final token = await notifications.getToken();
    return token;
  }

  void requestPermission() async {
    final authorizationStatus = await notifications.requestPermission();
    final token = await _saveToken(authorizationStatus);
    add(NotificationStatusChanged(authorizationStatus, token));
  }

  void initialStatusCheck() async {
    final authorizationStatus = await notifications.checkAuthorizationStatus();
    final token = await _saveToken(authorizationStatus);
    add(NotificationStatusChanged(authorizationStatus, token));
  }

  Future<String> _saveToken(bool authorizationStatus) async {
    if (authorizationStatus) {
      final token = await _getToken();
      if (token != null) {
        await saveTokenCallBack(token);
        return token;
      }
    }
    return '';
  }

  void _notificationStatusChanged(
      NotificationStatusChanged event, Emitter<NotificationsState> emit) {
    emit(state.copyWith(status: event.status, token: event.token));
  }

  void _handleRemoteMessage(String code) {
    add(RecoveryNotification(code));
  }

  void resetRecoveryCode() {
    add(ResetRecoveredNotification());
  }
}
