import 'package:gymnastic_center/common/results.dart';
import 'package:gymnastic_center/domain/entities/client/client.dart';
import 'package:gymnastic_center/domain/repositories/clients/clients_repository.dart';

class MockClientsRepository extends ClientsRepository {
  final Client client;
  final bool shouldFail;

  MockClientsRepository(this.client, [this.shouldFail = false]);

  @override
  Future<Result<Client>> getClientData() {
    if (shouldFail) {
      return Future.value(Result.fail(Exception('An error occurred')));
    }
    return Future.value(Result.success(client));
  }

  @override
  Future<Result<bool>> update(
      {String? email,
      String? name,
      String? phone,
      String? avatarImage,
      String? password}) {
    throw UnimplementedError();
  }
}
