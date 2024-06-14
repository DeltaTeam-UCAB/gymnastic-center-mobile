import 'package:gymnastic_center/common/results.dart';

abstract class UserRepository {
  Future<Result<bool>> register(
      {required String email,
      required String password,
      required String name,
      required String phone});
  Future<Result<bool>> login(String email, String password);
}
