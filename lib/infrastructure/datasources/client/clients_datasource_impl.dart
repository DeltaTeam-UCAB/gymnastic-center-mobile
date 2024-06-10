import 'package:dio/dio.dart';
import 'package:gymnastic_center/application/key_value_storage/key_value_storage.dart';
import 'package:gymnastic_center/domain/datasources/clients/clients_datasource.dart';
import 'package:gymnastic_center/domain/entities/client/client.dart';
import 'package:gymnastic_center/infrastructure/core/constants/environment.dart';
import 'package:gymnastic_center/infrastructure/models/client/client_api.dart';

class ClientsDatasourceImpl extends ClientsDatasource {
  final KeyValueStorageService keyValueStorage;
  final dio = Dio(BaseOptions(baseUrl: Environment.backendApi));

  ClientsDatasourceImpl(this.keyValueStorage) {
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      options.headers['auth'] = await keyValueStorage.getValue<String>('token');
      return handler.next(options);
    }));
  }

  @override
  Future<Client> getClientData() async {
    final response = await dio.get('/auth/current',
        options: Options(headers: {
          'auth': await keyValueStorage.getValue<String>('token')
        }));
    final apiClient = ClientAPI.fromJson(response.data);
    return Client(
        email: apiClient.email,
        name: apiClient.name,
        id: apiClient.id,
        phone: apiClient.phone);
  }

  @override
  Future<bool> update(
      {String? email,
      String? name,
      String? phone,
      String? avatarImage,
      String? password}) async {
    final body = <String, String>{};
    if (email != null) body['email'] = email;
    if (name != null) body['name'] = name;
    if (phone != null) body['phone'] = phone;
    if (avatarImage != null) body['image'] = avatarImage; //Cambiar
    if (password != null) body['password'] = password;
    await dio.put('/user/update',
        data: body,
        options: Options(headers: {
          'auth': await keyValueStorage.getValue<String>('token')
        }));
    return true;
  }
}
