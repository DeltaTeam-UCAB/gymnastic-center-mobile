import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymnastic_center/application/auth/update/update_bloc.dart';
import 'package:gymnastic_center/domain/entities/client/client.dart';

import '../utils/mock_client_repository.dart';


void main() {

  late MockClientRepository mockClientRepository;
  late Client mockClient;
  setUp(() {
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
      'Should emit UpdateState with avatarImage equal to someimagebase64 when phoneChanged is called',
      build: () => UpdateBloc(mockClientRepository),
      act: (bloc) => bloc.avatarImageChanged('someimagebase64'),
      expect: () => [
        isA<UpdateState>()
            .having((state) => state.avatarImage, 'avatarImage', 'someimagebase64')
      ]);
}
