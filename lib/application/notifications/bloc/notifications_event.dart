part of 'notifications_bloc.dart';

sealed class NotificationsEvent {
  const NotificationsEvent();
}

class NotificationStatusChanged extends NotificationsEvent {
  final bool status;

  const NotificationStatusChanged(this.status);
}


class GetToken extends NotificationsEvent {
  final String token;
  const GetToken(this.token);
}
