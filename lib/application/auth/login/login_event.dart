part of 'login_bloc.dart';

sealed class LoginEvent {
  const LoginEvent();
}

class EmailChanged extends LoginEvent {
  final String email;

  EmailChanged({required this.email});
}

class PasswordChanged extends LoginEvent {
  final String password;

  PasswordChanged({required this.password});
}

class LoginFormSubmited extends LoginEvent {}

class ErrorOccurred extends LoginEvent {
  final String errorMessage;
  ErrorOccurred({required this.errorMessage});
}

class LoginCompleted extends LoginEvent {}
