import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/core/bloc/safe_bloc.dart';
import 'package:gymnastic_center/domain/repositories/user/user_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends SafeBloc<LoginEvent, LoginState> {
  final UserRepository userRespository;

  LoginBloc({required this.userRespository}) : super(const LoginState()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<ErrorOccurred>(_onErrorOcurred);
    on<LoginFormSubmited>(_onFormSubmited);
    on<LoginCompleted>(_onLoginCompleted);
  }

  void _onLoginCompleted(LoginCompleted event, Emitter<LoginState> emit) {
    emit(state.copyWith(
      formStatus: LoginFormStatus.valid,
      isClient: event.isClient,
    ));
  }

  void _onFormSubmited(LoginFormSubmited event, Emitter<LoginState> emit) {
    emit(state.copyWith(
      formStatus: LoginFormStatus.posting,
    ));
  }

  void _onEmailChanged(EmailChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(password: event.password));
  }

  void _onErrorOcurred(ErrorOccurred event, Emitter<LoginState> emit) {
    emit(state.copyWith(
        formStatus: LoginFormStatus.invalid, errorMessage: event.errorMessage));
  }

  void changeEmail(String email) {
    add(EmailChanged(email: email));
  }

  void changePassword(String password) {
    add(PasswordChanged(password: password));
  }

  Future<void> submit() async {
    add(LoginFormSubmited());
    if (state.email == '' || state.password == '') {
      add(ErrorOccurred(
          errorMessage: 'Invalid fields. You must enter your credentials'));
      return;
    }
    final isLoggedResult =
        await userRespository.login(state.email, state.password);

    if (isLoggedResult.isSuccessful()) {
      final isLogged = isLoggedResult.getValue();

      add(LoginCompleted(isLogged));
      return;
    }
    add(ErrorOccurred(errorMessage: isLoggedResult.getError().toString()));
  }
}
