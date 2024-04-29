part of 'notifications_bloc.dart';

class NotificationsState extends Equatable {
  final bool status;

  const NotificationsState({
    this.status = false,
  });

  NotificationsState copyWith({
    bool? status,
  }) => NotificationsState(
    status: status ?? this.status,
  );

  @override
  List<Object> get props => [status];
}
