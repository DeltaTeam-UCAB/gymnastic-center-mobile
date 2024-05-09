import 'package:gymnastic_center/domain/entities/forms/user_register_form.dart';

abstract class RegisterDatasource {
  Future<void> registerUser(UserRegisterForm form);
}
