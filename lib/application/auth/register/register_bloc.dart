import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/common/results.dart';

part 'register_event.dart';
part 'register_state.dart';

typedef RegisterCallBack = Future<Result<bool>> Function({
  required String email,
  required String password,
  required String name,
  required String phone,
});

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterCallBack registerCallBack;

  RegisterBloc(this.registerCallBack) : super(const RegisterState()) {
    on<OnRegisterFormStatusChanged>(_onRegisterFormStatusChanged);
    on<FullNameChanged>(_onFullNameChanged);
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<PhoneChanged>(_onPhoneChanged);
    on<FailRegister>(_failRegister);
  }

  void _failRegister(FailRegister event, Emitter<RegisterState> emit) {
    emit(state.copyWith(errorMessage: event.errorMessage, registerFormStatus: RegisterFormStatus.invalid));
  }

  void _onPhoneChanged(PhoneChanged event, Emitter<RegisterState> emit) {
    emit(state.copyWith(phone: event.phone));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<RegisterState> emit) {
    emit(state.copyWith(password: event.password));
  }

  void _onEmailChanged(EmailChanged event, Emitter<RegisterState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _onFullNameChanged(FullNameChanged event, Emitter<RegisterState> emit) {
    emit(state.copyWith(fullname: event.fullname));
  }

  void _onRegisterFormStatusChanged(
      OnRegisterFormStatusChanged event, Emitter<RegisterState> emit) {
    emit(state.copyWith(registerFormStatus: event.registerFormStatus));
  }

  Future<void> obSubmitRegister() async {
    add(OnRegisterFormStatusChanged(
        registerFormStatus: RegisterFormStatus.posting));
    final result = await registerCallBack(
        email: state.email,
        password: state.password,
        name: state.fullname,
        phone: state.phone
      );
    if (result.isSuccess) {
      add(OnRegisterFormStatusChanged(
          registerFormStatus: RegisterFormStatus.valid));
    } else {
      final error = result.getError();
      add(FailRegister(
          errorMessage: error.toString().replaceAll('Exception: ', '')));
      add(OnRegisterFormStatusChanged(
          registerFormStatus: RegisterFormStatus.validating));
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