import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/domain/repositories/user/user_repository.dart';

part 'update_event.dart';
part 'update_state.dart';

class UpdateBloc extends Bloc<UpdateEvent, UpdateState> {
  final UserRepository userRepository;

  UpdateBloc(this.userRepository) : super(const UpdateState()) {
    on<OnSubmitUpdate>(_onSubmitUpdate);
    on<OnUpdateFormStatusChanged>(_onUpdateFormStatusChanged);
    on<FullNameChanged>(_onFullNameChanged);
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<PhoneChanged>(_onPhoneChanged);
    on<FailRegister>(_onFailRegister);
  }

  void _onSubmitUpdate(OnSubmitUpdate event, Emitter<UpdateState> emit) {
    emit(state.copyWith(updateFormStatus: UpdateFormStatus.posting));
  }

  void _onUpdateFormStatusChanged(
      OnUpdateFormStatusChanged event, Emitter<UpdateState> emit) {
    emit(state.copyWith(updateFormStatus: event.updateFormStatus));
  }

  void _onFullNameChanged(FullNameChanged event, Emitter<UpdateState> emit) {
    emit(state.copyWith(fullname: event.fullname));
  }

  void _onEmailChanged(EmailChanged event, Emitter<UpdateState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<UpdateState> emit) {
    emit(state.copyWith(password: event.password));
  }

  void _onPhoneChanged(PhoneChanged event, Emitter<UpdateState> emit) {
    emit(state.copyWith(phone: event.phone));
  }

  void _onFailRegister(FailRegister event, Emitter<UpdateState> emit) {
    emit(state.copyWith(errorMessage: event.errorMessage));
  }

  Future<void> onSubmitUpdate() async {
    add(OnUpdateFormStatusChanged(updateFormStatus: UpdateFormStatus.posting));
    final result = await userRepository.update(
        email: state.email.isEmpty ? null : state.email,
        name: state.fullname.isEmpty ? null : state.fullname,
        password: state.password.isEmpty ? null : state.password);
    if (result.isSuccess) {
      add(OnUpdateFormStatusChanged(updateFormStatus: UpdateFormStatus.valid));
    } else {
      final error = result.getError();
      add(FailRegister(
          errorMessage: error.toString().replaceAll('Exception: ', '')));
      add(OnUpdateFormStatusChanged(
          updateFormStatus: UpdateFormStatus.invalid));
      add(OnUpdateFormStatusChanged(
          updateFormStatus: UpdateFormStatus.validating));
    }
  }

  void fullnameChanged(String fullname) {
    add(FullNameChanged(fullname: fullname));
  }

  void emailChanged(String email) {
    add(EmailChanged(email: email));
  }

  void passwordChanged(String password) {
    add(PasswordChanged(password: password));
  }

  void phoneChanged(String phone) {
    add(PhoneChanged(phone: phone));
  }
}
