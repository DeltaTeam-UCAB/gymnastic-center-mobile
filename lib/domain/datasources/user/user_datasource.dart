import 'package:gymnastic_center/domain/entities/user/user.dart';

class LoginResponse {
  final String token;
  final String type;
  LoginResponse({required this.token, required this.type});
}

abstract class UserDatasource {
  Future<bool> register(String email, String password, String name);
  Future<LoginResponse> login(String email, String password);
  Future<User> current();
  Future<bool> update({String? email, String? password, String? name});
}
