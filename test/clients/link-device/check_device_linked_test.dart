import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymnastic_center/application/clients/link-device/link_device_bloc.dart';
import 'package:gymnastic_center/domain/entities/client/client.dart';
import 'package:gymnastic_center/domain/repositories/clients/clients_repository.dart';

import '../utils/mock_clients_repository.dart';

void main() {
  late ClientsRepository mockClientsRepository;
  late Client mockClient;

  setUp(() {
    mockClient = Client(
      id: 'id',
      name: 'name',
      email: 'email',
      phone: 'phone',
      avatarImage: 'avatarImage',
    );
    mockClientsRepository = MockClientsRepository(client: mockClient, isLinked: true);
  });

  blocTest(
    'Should emit LinkDeviceState with status [LinkDeviceStatus.deviceCheked] and isLinked true when checkDeviceLink is successful and device is linked',  
    seed: () => const LinkDeviceState(isLinked: false),
    build: () => LinkDeviceBloc(mockClientsRepository),
    act: (bloc) => bloc.checkDeviceLink('token'),
    expect: () => [
      const LinkDeviceState(status: LinkDeviceStatus.deviceCheked, isLinked: true),
    ],
  );
}
