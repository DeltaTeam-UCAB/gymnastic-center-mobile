part of 'recover_password_bloc.dart';

sealed class RecoverPasswordEvent {
  const RecoverPasswordEvent();
}

class EmailChanged extends RecoverPasswordEvent {
  final String email;

  EmailChanged({required this.email});
}

class PasswordChanged extends RecoverPasswordEvent {
  final String password;

  PasswordChanged({required this.password});
}

class CodeChanged extends RecoverPasswordEvent {
  final String code;

  CodeChanged({required this.code});
}

class RecoverPasswordCodeSent extends RecoverPasswordEvent {}

class RecoverPasswordCodeResent extends RecoverPasswordEvent {}

class RecoverPasswordCodeRequested extends RecoverPasswordEvent {}

class RecoverPasswordCodeValidated extends RecoverPasswordEvent {}

class RecoverPasswordCodeValidationRequested extends RecoverPasswordEvent {}

class RecoverPasswordFormSubmitted extends RecoverPasswordEvent {}

class ErrorOccurred extends RecoverPasswordEvent {
  final String errorMessage;
  ErrorOccurred({required this.errorMessage});
}

class RecoverPasswordCompleted extends RecoverPasswordEvent {}
