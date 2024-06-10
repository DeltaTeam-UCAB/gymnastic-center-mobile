import 'package:gymnastic_center/domain/entities/client/client.dart';

abstract class ClientsDatasource {
  Future<Client> getClientData();
  Future<bool> update(
      {String? email,
      String? name,
      String? phone,
      String? avatarImage,
      String? password});
}
