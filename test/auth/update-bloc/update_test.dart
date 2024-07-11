import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymnastic_center/application/auth/update/update_bloc.dart';
import 'package:gymnastic_center/domain/entities/client/client.dart';
import 'package:gymnastic_center/domain/repositories/clients/clients_repository.dart';

import '../../clients/utils/mock_clients_repository.dart';

void main() {
  late ClientsRepository mockClientRepository;
  late Client mockClient;
  setUp(() {
    mockClient =
        Client(id: '1', name: 'Juan', phone: '5', email: 'juan@gmail.com');
    mockClientRepository = MockClientsRepository(client: mockClient);
  });

  blocTest(
      'Should emit CourseDetailsState with status loading and loaded when getCourseById is called',
      build: () => UpdateBloc(mockClientRepository),
      seed: () => UpdateState(
          email: mockClient.email,
          fullname: mockClient.name,
          phone: mockClient.phone,
          updateFormStatus: UpdateFormStatus.validating),
      act: (bloc) => bloc.onSubmitUpdate(),
      expect: () => [
            isA<UpdateState>().having((state) => state.updateFormStatus,
                'status', UpdateFormStatus.posting),
            isA<UpdateState>().having((state) => state.updateFormStatus,
                'status', UpdateFormStatus.valid)
          ]);
}
