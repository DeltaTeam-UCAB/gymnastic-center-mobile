import 'package:gymnastic_center/domain/entities/client/client.dart';

abstract class ClientsDatasource {
  Future<Client> getClientData();
  Future<bool> update(
      {String? email,
      String? name,
      String? phone,
      String? avatarImage,
      String? password});
  Future<bool> linkDevice(String deviceToken);
  Future<bool> checkDeviceLink(String deviceToken);
}
