import 'package:gymnastic_center/common/results.dart';
import 'package:gymnastic_center/domain/entities/client/client.dart';

abstract class ClientsRepository {
  Future<Result<Client>> getClientData();
  Future<Result<bool>> update(
      {String? email,
      String? name,
      String? phone,
      String? avatarImage,
      String? password});
  Future<Result<bool>> linkDevice(String deviceToken);
  Future<Result<bool>> checkDeviceLink(String deviceToken);
}
