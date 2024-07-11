part of 'login_bloc.dart';

enum LoginFormStatus { invalid, valid, validating, posting }

class LoginState extends Equatable {
  final String password;
  final String email;
  final String errorMessage;
  final LoginFormStatus formStatus;
  final bool isClient;

  const LoginState({
    this.password = '',
    this.email = '',
    this.formStatus = LoginFormStatus.invalid,
    this.errorMessage = '',
    this.isClient = false,
  });

  LoginState copyWith(
          {String? email,
          String? password,
          String? errorMessage,
          bool? isClient,
          LoginFormStatus? formStatus}) =>
      LoginState(
        email: email ?? this.email,
        password: password ?? this.password,
        errorMessage: errorMessage ?? this.errorMessage,
        formStatus: formStatus ?? this.formStatus,
        isClient: isClient ?? this.isClient,
      );

  @override
  List<Object> get props => [email, password, formStatus, errorMessage, isClient];
}
