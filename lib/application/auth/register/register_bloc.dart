import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/domain/repositories/user/user_repository.dart';

part 'register_event.dart';
part 'register_state.dart';


class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {

  final UserRepository userRepository;

  RegisterBloc(this.userRepository) : super(const RegisterState()) {
    on<OnSubmitRegister>(_onSubmitRegister);
    on<OnRegisterFormStatusChanged>(_onRegisterFormStatusChanged);
    on<FullNameChanged>(_onFullNameChanged);
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<PhoneChanged>(_onPhoneChanged);
    on<FailRegister>(_failRegister);
  }

  void _failRegister(FailRegister event, Emitter<RegisterState> emit) {
    emit(state.copyWith(errorMessage: event.errorMessage));
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

  void _onRegisterFormStatusChanged(OnRegisterFormStatusChanged event, Emitter<RegisterState> emit) {
    emit(state.copyWith(registerFormStatus: event.registerFormStatus));
  }

  void _onSubmitRegister(OnSubmitRegister event, Emitter<RegisterState> emit) {
    emit(state.copyWith(registerFormStatus: RegisterFormStatus.posting));
  }

  Future<void> obSubmitRegister() async {
    add(OnRegisterFormStatusChanged(registerFormStatus: RegisterFormStatus.posting));
    final result = await userRepository.register(state.email, state.password, state.fullname);
    if (result.isSuccess) {
      add(OnRegisterFormStatusChanged(registerFormStatus: RegisterFormStatus.valid));
    } else {
      final error = result.getError();
      add(FailRegister(errorMessage: error.toString().replaceAll('Exception: ', '')));
      add(OnRegisterFormStatusChanged(registerFormStatus: RegisterFormStatus.invalid));
      add(OnRegisterFormStatusChanged(registerFormStatus: RegisterFormStatus.validating)); 
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
