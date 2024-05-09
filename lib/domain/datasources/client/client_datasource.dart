import 'package:gymnastic_center/domain/entities/client/client.dart';

abstract class ClientDataSource {
  Future<bool> setInfo(
      {int? weight,
      int? height,
      DateTime? birthDate,
      String? gender,
      String? location});
  Future<Client> getInfo();
}
