import 'package:gymnastic_center/common/results.dart';
import 'package:gymnastic_center/domain/entities/user/user.dart';

abstract class UserRepository {
  Future<Result<bool>> register({
    required String email,
    required String password,
    required String name,
    required String phone
  });
  Future<Result<bool>> login(String email, String password);
  Future<Result<User>> current();
  Future<Result<bool>> update({String? email, String? password, String? name});
}
