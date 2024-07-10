import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymnastic_center/application/clients/bloc/clients_bloc.dart';
import 'package:gymnastic_center/domain/entities/client/client.dart';
import 'package:gymnastic_center/domain/repositories/clients/clients_repository.dart';

import '../utils/mock_clients_repository.dart';

void main() {
  late ClientsRepository mockClientRepository;
  late Client clientMock;

  setUp(() {
    clientMock = Client(
        id: '1', name: 'John', phone: '7777777', email: 'john@gmail.com');
    mockClientRepository = MockClientsRepository(clientMock);
  });

  blocTest(
    'Should emit ClientState with isLoading true and client when getClientDate() is called',
    build: () => ClientsBloc(mockClientRepository),
    act: (bloc) => bloc.getClientData(),
    expect: () => [
      isA<ClientsState>()
          .having((state) => state.client, 'client', initialClient)
          .having((state) => state.isLoading, 'isLoading', true),
      ClientsState(client: clientMock, isLoading: false, isEmpty: false),
    ],
  );
}
