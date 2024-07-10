import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/core/bloc/safe_bloc.dart';
import 'package:gymnastic_center/domain/entities/notifications/notification.dart';
import 'package:gymnastic_center/domain/repositories/notifications/notifications_repository.dart';

part 'notification_list_event.dart';
part 'notification_list_state.dart';

class NotificationListBloc
    extends SafeBloc<NotificationListEvent, NotificationListState> {
  final NotificationsRepository notificationsRepository;

  NotificationListBloc({required this.notificationsRepository})
      : super(const NotificationListState()) {
    on<NotificationListLoaded>(_onNotificationListLoaded);
    on<NotificationListLoading>(_onNotificationListLoading);
    on<NotificationListIsEmpty>(_onNotificationListIsEmpty);
    on<NotificationListError>(_onNotificationListError);
    on<NotificationListDeleted>(_onNotificationListDeleted);
    on<NotificationRead>(_onNotificationRead);
  }

  void _onNotificationListError(
      NotificationListError event, Emitter<NotificationListState> emit) {
    emit(state.copyWith(isError: true, isLoading: false));
  }

  void _onNotificationListIsEmpty(
      NotificationListIsEmpty event, Emitter<NotificationListState> emit) {
    emit(state.copyWith(isLastPage: true, isLoading: false));
  }

  void _onNotificationListLoading(
      NotificationListLoading event, Emitter<NotificationListState> emit) {
    emit(state.copyWith(isLoading: true, isError: false));
  }

  void _onNotificationListLoaded(
      NotificationListLoaded event, Emitter<NotificationListState> emit) {
    emit(state.copyWith(
        notifications: [...state.notifications, ...event.notifications],
        isLoading: false,
        page: state.page + 1));
  }

  Future<void> loadNextPage() async {
    if (state.isLastPage || state.isLoading || state.isError) return;
    add(const NotificationListLoading());

    final notificationsResponse = await notificationsRepository
        .getNotificationsPaginated(page: state.page, perPage: state.perPage);

    if (notificationsResponse.isSuccessful()) {
      final notifications = notificationsResponse.getValue();
      if (notifications.isEmpty) {
        add(const NotificationListIsEmpty());
        return;
      }
      add(NotificationListLoaded(notifications));
      return;
    }
    add(const NotificationListError());
  }

  void _onNotificationListDeleted(
      NotificationListDeleted event, Emitter<NotificationListState> emit) {
    emit(state.copyWith(notifications: [], page: 1, isLastPage: true));
  }

  Future<void> deleteAllNotifications() async {
    if (state.isLoading || state.isError) return;
    await notificationsRepository.deleteAll();
    add(const NotificationListDeleted());
  }

  Future<void> markNotificationRead(String id) async {
    if (state.isLoading || state.isError) return;
    await notificationsRepository.markRead(id);
    final notification = state.notifications.firstWhere((n) => n.id == id);
    final readNotification = Notification(
        id: notification.id,
        title: notification.title,
        body: notification.body,
        date: notification.date,
        read: true);
    add(NotificationRead(readNotification));
  }

  void _onNotificationRead(
      NotificationRead event, Emitter<NotificationListState> emit) {
    final notifications = [...state.notifications];

    final index =
        notifications.indexWhere((n) => n.id == event.notification.id);
    notifications.replaceRange(index, index + 1, [event.notification]);

    emit(state.copyWith(notifications: notifications));
  }
}
