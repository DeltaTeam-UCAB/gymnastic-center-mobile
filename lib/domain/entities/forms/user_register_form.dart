class UserRegisterForm {
  final String fullName;
  final String password;
  final String email;
  final String phoneNumber;
  final bool acceptedTermsAndConditions;

  const UserRegisterForm({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.acceptedTermsAndConditions,
  });
}
