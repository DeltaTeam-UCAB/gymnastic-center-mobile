import 'package:gymnastic_center/application/core/results.dart';
import 'package:gymnastic_center/domain/entities/user/user.dart';

abstract class UserRepository {
  Future<Result<bool>> register(String email, String password, String name);
  Future<Result<bool>> login(String email, String password);
  Future<Result<User>> current();
  Future<Result<bool>> update({String? email, String? password, String? name});
}
