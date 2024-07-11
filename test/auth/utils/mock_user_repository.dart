import 'package:gymnastic_center/common/results.dart';
import 'package:gymnastic_center/domain/repositories/user/user_repository.dart';

class MockUserRepository extends UserRepository {
  final bool shouldFail;

  MockUserRepository({required this.shouldFail});
  @override
  Future<Result<bool>> changePassword(
      String email, String code, String password) {
    if (shouldFail) {
      return Future.value(Result.fail(Exception('Error')));
    }
    return Future.value(Result.success(true));
  }

  @override
  Future<Result<bool>> login(String email, String password) {
    if (shouldFail) {
      return Future.value(Result.fail(Exception('Error')));
    }
    return Future.value(Result.success(true));
  }

  @override
  Future<Result<bool>> register(
      {required String email,
      required String password,
      required String name,
      required String phone}) {
    if (shouldFail) {
      return Future.value(Result.fail(Exception('Error')));
    }
    return Future.value(Result.success(true));
  }

  @override
  Future<Result<bool>> sendRecoveryCode(String email) {
    if (shouldFail) {
      return Future.value(Result.fail(Exception('Error')));
    }
    return Future.value(Result.success(true));
  }

  @override
  Future<Result<bool>> validateRecoveryCode(String email, String code) {
    if (shouldFail) {
      return Future.value(Result.fail(Exception('Error validating code')));
    }
    return Future.value(Result.success(true));
  }
}
