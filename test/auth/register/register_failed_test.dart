import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymnastic_center/application/auth/register/register_bloc.dart';
import 'package:gymnastic_center/domain/repositories/user/user_repository.dart';

import '../utils/mock_user_repository.dart';

void main() {
  late UserRepository mockUserRepository;

  setUp(() {
    mockUserRepository = MockUserRepository(shouldFail: true);
  });

  blocTest(
      'Should emit CourseDetailsState with status loading and loaded when getCourseById is called',
      build: () => RegisterBloc(mockUserRepository.register),
      seed: () => const RegisterState(
          email: 'juan@gmail.com',
          password: 'Juan123',
          fullname: 'Juan',
          phone: '1',
          registerFormStatus: RegisterFormStatus.validating),
      act: (bloc) => bloc.obSubmitRegister(),
      expect: () => [
            isA<RegisterState>().having((state) => state.registerFormStatus,
                'posting', RegisterFormStatus.posting),
            isA<RegisterState>().having((state) => state.registerFormStatus,
                'posting', RegisterFormStatus.invalid),
            isA<RegisterState>().having((state) => state.registerFormStatus,
                'posting', RegisterFormStatus.validating)
          ]);
}
