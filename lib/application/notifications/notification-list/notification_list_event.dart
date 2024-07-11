part of 'notification_list_bloc.dart';

sealed class NotificationListEvent {
  const NotificationListEvent();
}

class NotificationListLoaded extends NotificationListEvent {
  final List<Notification> notifications;
  const NotificationListLoaded(this.notifications);
}

class NotificationListLoading extends NotificationListEvent {
  const NotificationListLoading();
}

class NotificationListIsEmpty extends NotificationListEvent {
  const NotificationListIsEmpty();
}

class NotificationListError extends NotificationListEvent {
  const NotificationListError();
}

class NotificationListDeleted extends NotificationListEvent {
  const NotificationListDeleted();
}

class NotificationRead extends NotificationListEvent {
  final Notification notification;
  const NotificationRead(this.notification);
}
