import 'package:gymnastic_center/application/core/results.dart';
import 'package:gymnastic_center/domain/entities/forms/user_register_form.dart';

abstract class RegisterRepository {
  Future<Result<void>> registerUser(UserRegisterForm form);
}
