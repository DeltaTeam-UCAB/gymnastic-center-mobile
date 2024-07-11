import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymnastic_center/application/auth/register/register_bloc.dart';

import '../utils/mock_register_callback.dart';


void main() {
  blocTest(
      'Should emit RegisterState with email equal to test@gmail.com when emailChanged is called',
      build: () => RegisterBloc(mockRegisterCallBack),
      act: (bloc) => bloc.emailChanged('test@gmail.com'),
      expect: () => [
        isA<RegisterState>()
            .having((state) => state.email, 'email', 'test@gmail.com')
      ]);
}
