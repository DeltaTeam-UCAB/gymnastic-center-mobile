import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/core/bloc/safe_bloc.dart';
import 'package:gymnastic_center/domain/repositories/clients/clients_repository.dart';

part 'update_event.dart';
part 'update_state.dart';

class UpdateBloc extends SafeBloc<UpdateEvent, UpdateState> {
  final ClientsRepository clientRepository;

  UpdateBloc(this.clientRepository) : super(const UpdateState()) {
    on<OnSubmitUpdate>(_onSubmitUpdate);
    on<OnUpdateFormStatusChanged>(_onUpdateFormStatusChanged);
    on<FullNameChanged>(_onFullNameChanged);
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<PhoneChanged>(_onPhoneChanged);
    on<AvatarImageChanged>(_onAvatarImageChanged);
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

  void _onAvatarImageChanged(
      AvatarImageChanged event, Emitter<UpdateState> emit) {
    emit(state.copyWith(avatarImage: event.avatarImage));
  }

  Future<void> onSubmitUpdate() async {
    add(OnUpdateFormStatusChanged(updateFormStatus: UpdateFormStatus.posting));
    final result = await clientRepository.update(
        email: state.email.isEmpty ? null : state.email,
        name: state.fullname.isEmpty ? null : state.fullname,
        password: state.password.isEmpty ? null : state.password,
        phone: state.phone.isEmpty ? null : state.phone,
        avatarImage: state.avatarImage.isEmpty ? null : state.avatarImage);
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

  void avatarImageChanged(String avatarImage) {
    add(AvatarImageChanged(avatarImage: avatarImage));
  }
}
