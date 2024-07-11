import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymnastic_center/application/auth/update/update_bloc.dart';
import 'package:gymnastic_center/domain/entities/client/client.dart';

import '../utils/mock_client_repository.dart';


void main() {
  late Client mockClient;
  late String newName;
  late String newEmail;
  late MockClientRepository mockClientRepository;

  setUp(() {
    newEmail = 'newemail@gmail.com';
    newName = 'newname';
    mockClient = Client(
      id: '1',
      name: 'user123456',
      email: 'test@gmail.com',
      phone: '+581112223344',
      avatarImage: 'someimagebase64',
    );
    mockClientRepository = MockClientRepository(mockClient);
  });
  blocTest(
      'Should emit UpdateState with status posting and valid when onSubmitUpdate is called',
      build: () => UpdateBloc(mockClientRepository),
      seed: () => UpdateState( 
        email: newEmail,
        fullname: newName
      ),
      verify: (bloc) {
        expect(mockClientRepository.client.email, newEmail);
        expect(mockClientRepository.client.name, newName);
      },
      act: (bloc) => bloc.onSubmitUpdate(),
      expect: () => [
        isA<UpdateState>()
            .having((state) => state.updateFormStatus, 'status', UpdateFormStatus.posting),
        isA<UpdateState>()
            .having((state) => state.updateFormStatus, 'status', UpdateFormStatus.valid)
      ]);
}
