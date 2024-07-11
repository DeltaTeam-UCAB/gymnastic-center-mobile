import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymnastic_center/application/auth/register/register_bloc.dart';

import '../utils/mock_register_callback.dart';


void main() {
  blocTest(
      'Should emit RegisterState with password equal to test_123456 when passwordChanged is called',
      build: () => RegisterBloc(mockRegisterCallBack),
      act: (bloc) => bloc.passwordChanged('test_123456'),
      expect: () => [
        isA<RegisterState>()
            .having((state) => state.password, 'password', 'test_123456')
      ]);
}
