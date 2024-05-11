part of 'register_bloc.dart';

class RegisterEvent {
  const RegisterEvent();
}

class OnSubmitRegister extends RegisterEvent {
  final String fullname;
  final String email;
  final String password;
  final String phone;

  OnSubmitRegister({
    required this.fullname,
    required this.email,
    required this.password,
    required this.phone,
  });
}

class OnRegisterFormStatusChanged extends RegisterEvent {
  final RegisterFormStatus registerFormStatus;

  OnRegisterFormStatusChanged({
    required this.registerFormStatus,
  });
}

class FullNameChanged extends RegisterEvent {
  final String fullname;

  FullNameChanged({
    required this.fullname,
  });
}

class EmailChanged extends RegisterEvent {
  final String email;

  EmailChanged({
    required this.email,
  });
}

class PasswordChanged extends RegisterEvent {
  final String password;

  PasswordChanged({
    required this.password,
  });
}

class PhoneChanged extends RegisterEvent {
  final String phone;

  PhoneChanged({
    required this.phone,
  });
}

class FailRegister extends RegisterEvent {
  final String errorMessage;

  FailRegister({
    required this.errorMessage,
  });
}
