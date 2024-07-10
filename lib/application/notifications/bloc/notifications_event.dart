part of 'notifications_bloc.dart';

sealed class NotificationsEvent {
  const NotificationsEvent();
}

class NotificationStatusChanged extends NotificationsEvent {
  final bool status;
  final String? token;

  const NotificationStatusChanged(this.status, this.token);
}

class RecoveryNotification extends NotificationsEvent {
  final String recoveryCode;
  const RecoveryNotification(this.recoveryCode);
}

class ResetRecoveredNotification extends NotificationsEvent {}
