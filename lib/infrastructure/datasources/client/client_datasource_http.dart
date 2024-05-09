import 'package:dio/dio.dart';
import 'package:gymnastic_center/application/key_value_storage/key_value_storage.dart';
import 'package:gymnastic_center/domain/datasources/client/client_datasource.dart';
import 'package:gymnastic_center/domain/entities/client/client.dart';
import 'package:gymnastic_center/infrastructure/core/constants/environment.dart';
import 'package:gymnastic_center/infrastructure/models/client/client_dto.dart';

class ClientHttpDataSource extends ClientDataSource {
  final KeyValueStorageService keyValueStorage;
  final dio = Dio(BaseOptions(baseUrl: Environment.backendApi));
  ClientHttpDataSource(KeyValueStorageService keyValueStorageI)
      : keyValueStorage = keyValueStorageI;
  @override
  Future<bool> setInfo(
      {int? weight,
      int? height,
      DateTime? birthDate,
      String? gender,
      String? location}) async {
    await dio.post('/client/set-info',
        data: {
          'weight': weight,
          'height': height,
          'birthDate': birthDate?.toIso8601String(),
          'gender': gender,
          'location': location
        },
        options: Options(headers: {
          'auth': await keyValueStorage.getValue<String>('token')
        }));
    return true;
  }

  @override
  Future<Client> getInfo() async {
    final resp = await dio.post('/client/current',
        options: Options(headers: {
          'auth': await keyValueStorage.getValue<String>('token')
        }));
    final clientApi = ClientDTO.fromJson(resp.data);
    return Client(
        id: clientApi.id,
        weight: clientApi.weight,
        height: clientApi.height,
        location: clientApi.location,
        gender: clientApi.gender,
        birthDate: clientApi.birthDate);
  }
}
