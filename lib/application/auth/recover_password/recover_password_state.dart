part of 'recover_password_bloc.dart';

enum RecoverPasswordFormStatus { invalid, valid, validating, posting }

class RecoverPasswordState extends Equatable {
  final String email;
  final String code;
  final String password;
  final String errorMessage;
  final RecoverPasswordFormStatus formStatus;

  const RecoverPasswordState({
    this.email = '',
    this.code = '',
    this.password = '',
    this.formStatus = RecoverPasswordFormStatus.invalid,
    this.errorMessage = '',
  });

  RecoverPasswordState copyWith(
          {String? email,
          String? code,
          String? password,
          String? errorMessage,
          RecoverPasswordFormStatus? formStatus}) =>
      RecoverPasswordState(
        email: email ?? this.email,
        code: code ?? this.code,
        password: password ?? this.password,
        errorMessage: errorMessage ?? this.errorMessage,
        formStatus: formStatus ?? this.formStatus,
      );

  @override
  List<Object> get props => [email, code, password, formStatus, errorMessage];
}
