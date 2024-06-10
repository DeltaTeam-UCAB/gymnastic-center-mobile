part of 'update_bloc.dart';

enum UpdateFormStatus { invalid, valid, validating, posting }

class UpdateState extends Equatable {
  final UpdateFormStatus updateFormStatus;
  final String fullname;
  final String email;
  final String phone;
  final String avatarImage;
  final String password;
  final String errorMessage;

  const UpdateState(
      {this.updateFormStatus = UpdateFormStatus.validating,
      this.fullname = '',
      this.email = '',
      this.password = '',
      this.phone = '',
      this.errorMessage = '',
      this.avatarImage = ''});

  @override
  List<Object> get props =>
      [fullname, email, password, phone, updateFormStatus, errorMessage];

  UpdateState copyWith(
      {UpdateFormStatus? updateFormStatus,
      String? fullname,
      String? email,
      String? password,
      String? phone,
      String? avatarImage,
      String? errorMessage}) {
    return UpdateState(
      updateFormStatus: updateFormStatus ?? this.updateFormStatus,
      fullname: fullname ?? this.fullname,
      email: email ?? this.email,
      password: password ?? this.password,
      phone: phone ?? this.phone,
      errorMessage: errorMessage ?? this.errorMessage,
      avatarImage: avatarImage ?? this.avatarImage,
    );
  }
}
