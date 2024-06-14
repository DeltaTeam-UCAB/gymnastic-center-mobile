import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/domain/repositories/user/user_repository.dart';

part 'recover_password_event.dart';
part 'recover_password_state.dart';

class RecoverPasswordBloc
    extends Bloc<RecoverPasswordEvent, RecoverPasswordState> {
  final UserRepository userRespository;

  RecoverPasswordBloc({required this.userRespository})
      : super(const RecoverPasswordState()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<CodeChanged>(_onCodeChanged);
    on<ErrorOccurred>(_onErrorOcurred);
    on<RecoverPasswordCodeSent>(_onCodeSent);
    on<RecoverPasswordCodeResent>(_onCodeResent);
    on<RecoverPasswordCodeRequested>(_onCodeRequested);
    on<RecoverPasswordCodeValidated>(_onCodeValidated);
    on<RecoverPasswordCodeValidationRequested>(_onCodeValidationRequested);
    on<RecoverPasswordFormSubmitted>(_onFormSubmitted);
    on<RecoverPasswordCompleted>(_onRecoverCompleted);
  }

  void _onRecoverCompleted(
      RecoverPasswordCompleted event, Emitter<RecoverPasswordState> emit) {
    emit(state.copyWith(
      formStatus: RecoverPasswordFormStatus.finished,
    ));
  }

  void _onFormSubmitted(
      RecoverPasswordFormSubmitted event, Emitter<RecoverPasswordState> emit) {
    emit(state.copyWith(
      formStatus: RecoverPasswordFormStatus.posting,
    ));
  }

  void _onCodeSent(
      RecoverPasswordCodeSent event, Emitter<RecoverPasswordState> emit) {
    emit(state.copyWith(formStatus: RecoverPasswordFormStatus.sent));
  }

  void _onCodeResent(
      RecoverPasswordCodeResent event, Emitter<RecoverPasswordState> emit) {
    emit(state.copyWith(formStatus: RecoverPasswordFormStatus.resent));
  }

  void _onCodeRequested(
      RecoverPasswordCodeRequested event, Emitter<RecoverPasswordState> emit) {
    emit(state.copyWith(formStatus: RecoverPasswordFormStatus.posting));
  }

  void _onCodeValidated(
      RecoverPasswordCodeValidated event, Emitter<RecoverPasswordState> emit) {
    emit(state.copyWith(formStatus: RecoverPasswordFormStatus.validated));
  }

  void _onCodeValidationRequested(RecoverPasswordCodeValidationRequested event,
      Emitter<RecoverPasswordState> emit) {
    emit(state.copyWith(formStatus: RecoverPasswordFormStatus.posting));
  }

  void _onEmailChanged(EmailChanged event, Emitter<RecoverPasswordState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _onPasswordChanged(
      PasswordChanged event, Emitter<RecoverPasswordState> emit) {
    emit(state.copyWith(password: event.password));
  }

  void _onCodeChanged(CodeChanged event, Emitter<RecoverPasswordState> emit) {
    emit(state.copyWith(code: event.code));
  }

  void _onErrorOcurred(
      ErrorOccurred event, Emitter<RecoverPasswordState> emit) {
    emit(state.copyWith(
        formStatus: RecoverPasswordFormStatus.invalid,
        errorMessage: event.errorMessage));
  }

  void changeEmail(String email) {
    add(EmailChanged(email: email));
  }

  void changePassword(String password) {
    add(PasswordChanged(password: password));
  }

  void changeCode(String code) {
    add(CodeChanged(code: code));
  }

  Future<void> sendCode({bool resend = false}) async {
    add(RecoverPasswordCodeRequested());
    if (state.email == '') {
      add(ErrorOccurred(errorMessage: 'You must enter your email'));
      return;
    }
    final sendRecoveryCodeResult =
        await userRespository.sendRecoveryCode(state.email);

    if (sendRecoveryCodeResult.isSuccessful()) {
      final sentRecoveryCode = sendRecoveryCodeResult.getValue();

      if (sentRecoveryCode) {
        add(resend ? RecoverPasswordCodeResent() : RecoverPasswordCodeSent());
        return;
      }
    }
    add(ErrorOccurred(
        errorMessage: sendRecoveryCodeResult.getError().toString()));
  }

  Future<void> validateCode() async {
    add(RecoverPasswordCodeValidationRequested());
    if (state.code == '') {
      add(ErrorOccurred(errorMessage: 'You must enter the code'));
      return;
    }

    if (state.code.length < 4) {
      add(ErrorOccurred(
          errorMessage:
              'You must enter all of the code\'s digits (entered code ${state.code})'));
      return;
    }

    final codeValidationResult =
        await userRespository.validateRecoveryCode(state.email, state.code);

    if (codeValidationResult.isSuccessful()) {
      final codeValid = codeValidationResult.getValue();

      if (codeValid) {
        add(RecoverPasswordCodeValidated());
        return;
      }
    }
    add(ErrorOccurred(
        errorMessage: codeValidationResult.getError().toString()));
  }

  Future<void> submitPasswordChange() async {
    add(RecoverPasswordFormSubmitted());
    if (state.password == '') {
      add(ErrorOccurred(errorMessage: 'You must enter a password'));
      return;
    }
    final passwordChangeResult = await userRespository.changePassword(
        state.email, state.code, state.password);

    if (passwordChangeResult.isSuccessful()) {
      final passwordChanged = passwordChangeResult.getValue();

      if (passwordChanged) {
        add(RecoverPasswordCompleted());
        return;
      }
    }
    add(ErrorOccurred(
        errorMessage: passwordChangeResult.getError().toString()));
  }
}
