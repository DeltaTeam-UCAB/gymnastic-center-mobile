class LoginResponse {
  final String token;
  final String type;
  LoginResponse({required this.token, required this.type});
}

abstract class UserDatasource {
  Future<bool> register(
      {required String email,
      required String password,
      required String name,
      required String phone});
  Future<LoginResponse> login(String email, String password);

  // ! ESTO ES MIENTRAS TANTO!!! NO CREO QUE VAYAN AQUÍ
  Future<bool> sendRecoveryCode(String email);
  Future<bool> validateRecoveryCode(String email, String code);
  Future<bool> changePassword(String email, String code, String password);
}
