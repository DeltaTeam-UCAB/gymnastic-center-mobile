part of 'notifications_bloc.dart';

class NotificationsState extends Equatable {
  final bool status;
  final String token;

  const NotificationsState({
    this.token = '',
    this.status = false,
  });

  NotificationsState copyWith({
    bool? status,
    String? token,
  }) {
    return NotificationsState(
      status: status ?? this.status,
      token: token ?? this.token,
    );
  }

  @override
  List<Object> get props => [status, token];
}
