import 'package:gymnastic_center/common/results.dart';

abstract class UserRepository {
  Future<Result<bool>> register(
      {required String email,
      required String password,
      required String name,
      required String phone});
  Future<Result<bool>> login(String email, String password);

  // ! ESTO ES MIENTRAS TANTO!!! NO CREO QUE VAYAN AQUÍ
  Future<Result<bool>> sendRecoveryCode(String email);
  Future<Result<bool>> validateRecoveryCode(String email, String code);
  Future<Result<bool>> changePassword(
      String email, String code, String password);
}
