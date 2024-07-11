import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymnastic_center/application/auth/update/update_bloc.dart';
import 'package:gymnastic_center/domain/entities/client/client.dart';

import '../utils/mock_client_repository.dart';


void main() {
  late Client mockClient;
  late String newEmail;
  late MockClientRepository mockClientRepository;

  setUp(() {
    newEmail = 'newemail@gmail.com';
    mockClient = Client(
      id: '1',
      name: 'user123456',
      email: 'test@gmail.com',
      phone: '+581112223344',
      avatarImage: 'someimagebase64',
    );
    mockClientRepository = MockClientRepository(mockClient, true);
  });
  blocTest(
      'Should emit UpdateState with status posting and valid when onSubmitUpdate is called',
      build: () => UpdateBloc(mockClientRepository),
      seed: () => UpdateState( 
        email: newEmail,
      ),
      act: (bloc) => bloc.onSubmitUpdate(),
      expect: () => [
        isA<UpdateState>()
            .having((state) => state.updateFormStatus, 'status', UpdateFormStatus.posting),
        isA<UpdateState>()
            .having((state) => state.errorMessage, 'status', 'failed'),
        isA<UpdateState>()
            .having((state) => state.updateFormStatus, 'status', UpdateFormStatus.invalid),
        isA<UpdateState>()
            .having((state) => state.updateFormStatus, 'status', UpdateFormStatus.validating)
      ]);
}
