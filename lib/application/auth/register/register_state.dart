part of 'register_bloc.dart';

enum RegisterFormStatus { invalid, valid, validating, posting }

class RegisterState extends Equatable {

  final RegisterFormStatus registerFormStatus;
  final String fullname;
  final String email;
  final String password;
  final String phone;
  final String errorMessage;

  const RegisterState({
    this.registerFormStatus = RegisterFormStatus.validating,
    this.fullname = '', 
    this.email = '', 
    this.password= '', 
    this.phone = '',
    this.errorMessage = ''
  });

  RegisterState copyWith({
    RegisterFormStatus? registerFormStatus,
    String? fullname,
    String? email,
    String? password,
    String? phone,
    String? errorMessage
  }) {
    return RegisterState(
      registerFormStatus: registerFormStatus ?? this.registerFormStatus,
      fullname: fullname ?? this.fullname,
      email: email ?? this.email,
      password: password ?? this.password,
      phone: phone ?? this.phone,
      errorMessage: errorMessage ?? this.errorMessage
    );
  }
  
  @override
  List<Object> get props => [ fullname, email, password, phone, registerFormStatus, errorMessage];
}