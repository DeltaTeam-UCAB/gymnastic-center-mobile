  import 'package:gymnastic_center/common/results.dart';
import 'package:gymnastic_center/domain/entities/client/client.dart';
import 'package:gymnastic_center/domain/repositories/clients/clients_repository.dart';

class MockClientRepository extends ClientsRepository {

  Client client;
  final bool shouldFail;
  MockClientRepository(this.client, [this.shouldFail = false]);
  

  @override
  Future<Result<bool>> checkDeviceLink(String deviceToken) {
    // TODO: implement checkDeviceLink
    throw UnimplementedError();
  }

  @override
  Future<Result<Client>> getClientData() {
    // TODO: implement getClientData
    throw UnimplementedError();
  }

  @override
  Future<Result<bool>> linkDevice(String deviceToken) {
    // TODO: implement linkDevice
    throw UnimplementedError();
  }

  @override
  Future<Result<bool>> update({String? email, String? name, String? phone, String? avatarImage, String? password}) {
    if ( shouldFail ) return Future.value(Result.fail(Exception('failed')));
    client = Client(
      id: client.id,
      name: name ?? client.name,
      email: email ?? client.email,
      phone: phone ?? client.phone,
      avatarImage: avatarImage ?? client.avatarImage,
    );
    return Future.value(Result.success(true));
  }
}