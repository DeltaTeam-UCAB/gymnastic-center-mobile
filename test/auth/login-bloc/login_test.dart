import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymnastic_center/application/auth/login/login_bloc.dart';
import 'package:gymnastic_center/domain/repositories/user/user_repository.dart';

import '../utils/mock_user_repository.dart';

void main() {
  late UserRepository mockUserRepository;

  setUp(() {
    mockUserRepository = MockUserRepository(shouldFail: false);
  });

  blocTest(
      'Should emit CourseDetailsState with status loading and loaded when getCourseById is called',
      build: () => LoginBloc(userRespository: mockUserRepository),
      seed: () =>
          const LoginState(email: 'juan@gmail.com', password: 'Juan123'),
      act: (bloc) => bloc.submit(),
      expect: () => [
            const LoginState(
                email: 'juan@gmail.com',
                password: 'Juan123',
                formStatus: LoginFormStatus.posting),
            const LoginState(
                email: 'juan@gmail.com',
                password: 'Juan123',
                formStatus: LoginFormStatus.valid,
                isClient: true)
          ]);
}
