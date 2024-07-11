import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymnastic_center/application/auth/register/register_bloc.dart';

import '../utils/mock_register_callback.dart';


void main() {
  late String email;
  late String password;
  late String phone;
  late String fullname;
  setUp(() {
    email = 'email@gmail.com';
    password = 'password';
    phone = '+001112223344';
    fullname = 'testUser';

  });
  blocTest(
      'Should emit RegisterState with status posting, invalid and validating when obSubmitRegister is called',
      build: () => RegisterBloc(mockRegisterCallBackShouldFail),
      seed: () => RegisterState( 
        email: email,
        password: password,
        phone: phone,
        fullname: fullname
      ),
      act: (bloc) => bloc.obSubmitRegister(),
      expect: () => [
        isA<RegisterState>()
            .having((state) => state.registerFormStatus, 'status', RegisterFormStatus.posting),
        isA<RegisterState>()
            .having((state) => state.registerFormStatus, 'status', RegisterFormStatus.invalid),
        isA<RegisterState>()
            .having((state) => state.registerFormStatus, 'status', RegisterFormStatus.validating)
      ]);
}
