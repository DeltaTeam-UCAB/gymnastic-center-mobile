import 'package:gymnastic_center/common/results.dart';
import 'package:gymnastic_center/domain/entities/client/client.dart';
import 'package:gymnastic_center/domain/repositories/clients/clients_repository.dart';

class MockClientsRepository extends ClientsRepository {
  final Client client;
  final bool shouldFail;
  final bool isLinked;

  MockClientsRepository(
      {required this.client, this.shouldFail = false, this.isLinked = false});

  @override
  Future<Result<bool>> checkDeviceLink(String deviceToken) {
    if (shouldFail) {
      return Future.value(
          Result.fail(Exception('Failed to check device link.')));
    }
    return Future.value(Result.success(isLinked));
  }

  @override
  Future<Result<bool>> linkDevice(String deviceToken) {
    if (shouldFail) {
      return Future.value(Result.fail(Exception('Failed to link device')));
    }
    return Future.value(Result.success(true));
  }
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
    // TODO: implement update
    throw UnimplementedError();
  }
}
