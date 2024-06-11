part of 'update_bloc.dart';

abstract class UpdateEvent {
  const UpdateEvent();
}

class OnSubmitUpdate extends UpdateEvent {
  final String fullname;
  final String email;
  final String password;
  final String phone;
  final String avatarImage;

  OnSubmitUpdate({
    required this.fullname,
    required this.email,
    required this.password,
    required this.phone,
    required this.avatarImage,
  });
}

class OnUpdateFormStatusChanged extends UpdateEvent {
  final UpdateFormStatus updateFormStatus;

  OnUpdateFormStatusChanged({
    required this.updateFormStatus,
  });
}

class FullNameChanged extends UpdateEvent {
  final String fullname;

  FullNameChanged({
    required this.fullname,
  });
}

class EmailChanged extends UpdateEvent {
  final String email;

  EmailChanged({
    required this.email,
  });
}

class PasswordChanged extends UpdateEvent {
  final String password;

  PasswordChanged({
    required this.password,
  });
}

class PhoneChanged extends UpdateEvent {
  final String phone;

  PhoneChanged({
    required this.phone,
  });
}

class AvatarImageChanged extends UpdateEvent {
  final String avatarImage;

  AvatarImageChanged({required this.avatarImage});
}

class FailRegister extends UpdateEvent {
  final String errorMessage;

  FailRegister({
    required this.errorMessage,
  });
}
