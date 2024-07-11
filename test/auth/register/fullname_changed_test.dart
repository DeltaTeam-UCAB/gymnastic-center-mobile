import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymnastic_center/application/auth/register/register_bloc.dart';

import '../utils/mock_register_callback.dart';


void main() {
  blocTest(
      'Should emit RegisterState with fullname equal to fullname when fullnameChanged is called',
      build: () => RegisterBloc(mockRegisterCallBack),
      act: (bloc) => bloc.fullnameChanged('fullname'),
      expect: () => [
        isA<RegisterState>()
            .having((state) => state.fullname, 'fullname', 'fullname')
      ]);
}
