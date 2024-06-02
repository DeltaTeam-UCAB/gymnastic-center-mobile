import 'package:gymnastic_center/common/results.dart';
import 'package:gymnastic_center/domain/entities/client/client.dart';

abstract class ClientRepository {
  Future<Result<bool>> setInfo(
      {int? weight,
      int? height,
      DateTime? birthDate,
      String? gender,
      String? location});
  Future<Result<Client>> getInfo();
}
