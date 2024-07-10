part of 'notifications_bloc.dart';

class NotificationsState extends Equatable {
  final bool status;
  final String token;
  final String recoveryCode;

  const NotificationsState({
    this.token = '',
    this.status = false,
    this.recoveryCode = '',
  });

  NotificationsState copyWith({
    bool? status,
    String? token,
    String? recoveryCode,
  }) {
    return NotificationsState(
      status: status ?? this.status,
      token: token ?? this.token,
      recoveryCode: recoveryCode ?? this.recoveryCode,
    );
  }

  @override
  List<Object> get props => [status, token, recoveryCode];
}
