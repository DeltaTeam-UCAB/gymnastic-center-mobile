part of 'notification_list_bloc.dart';

class NotificationListState extends Equatable {
  final List<Notification> notifications;
  final bool isLoading;
  final int page;
  final int perPage;
  final bool isLastPage;
  final bool isError;

  const NotificationListState(
      {this.notifications = const [],
      this.isLoading = false,
      this.page = 1,
      this.perPage = 10,
      this.isLastPage = false,
      this.isError = false});

  NotificationListState copyWith(
      {List<Notification>? notifications,
      bool? isLoading,
      int? page,
      int? perPage,
      bool? isLastPage,
      bool? isError}) {
    return NotificationListState(
      notifications: notifications ?? this.notifications,
      isLoading: isLoading ?? this.isLoading,
      page: page ?? this.page,
      perPage: perPage ?? this.perPage,
      isLastPage: isLastPage ?? this.isLastPage,
      isError: isError ?? this.isError,
    );
  }

  @override
  List<Object> get props =>
      [notifications, isLoading, page, perPage, isLastPage, isError];
}
