import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymnastic_center/application/auth/register/register_bloc.dart';

import '../utils/mock_register_callback.dart';


void main() {
  blocTest(
      'Should emit RegisterState with phone equal to +001112223344 when phone is called',
      build: () => RegisterBloc(mockRegisterCallBack),
      act: (bloc) => bloc.phoneChanged('+001112223344'),
      expect: () => [
        isA<RegisterState>()
            .having((state) => state.phone, 'phone', '+001112223344')
      ]);
}
