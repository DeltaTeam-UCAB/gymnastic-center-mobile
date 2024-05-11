part of 'login_bloc.dart';

enum LoginFormStatus { invalid, valid, validating, posting }

class LoginState extends Equatable {
  final String password;
  final String email;
  final String errorMessage;
  final LoginFormStatus formStatus;

  const LoginState({
    this.password = '',
    this.email = '',
    this.formStatus = LoginFormStatus.invalid,
    this.errorMessage = '',
  });

  LoginState copyWith(
          {String? email,
          String? password,
          String? errorMessage,
          LoginFormStatus? formStatus}) =>
      LoginState(
        email: email ?? this.email,
        password: password ?? this.password,
        errorMessage: errorMessage ?? this.errorMessage,
        formStatus: formStatus ?? this.formStatus,
      );

  @override
  List<Object> get props => [email, password, formStatus, errorMessage];
}
