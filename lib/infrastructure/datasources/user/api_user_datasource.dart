import 'package:dio/dio.dart';
import 'package:gymnastic_center/application/key_value_storage/key_value_storage.dart';
import 'package:gymnastic_center/domain/datasources/user/user_datasource.dart';
import 'package:gymnastic_center/domain/entities/user/user.dart';
import 'package:gymnastic_center/infrastructure/core/constants/environment.dart';
import 'package:gymnastic_center/infrastructure/models/user/login_api.dart';
import 'package:gymnastic_center/infrastructure/models/user/user_api.dart';

class APIUserDatasource extends UserDatasource {
  final KeyValueStorageService keyValueStorage;

  final dio = Dio(BaseOptions(baseUrl: Environment.backendApi));
  APIUserDatasource(KeyValueStorageService keyValueStorageI)
      : keyValueStorage = keyValueStorageI;

  @override
  Future<bool> register({
    required String email,
    required String password,
    required String name,
    required String phone}
  ) async {
    await dio.post('/auth/register', data: {
      'email': email,
      'password': password,
      'name': name,
      'phone': phone,
      'type': 'CLIENT'
    });
    return true;
  }

  @override
  Future<LoginResponse> login(String email, String password) async {
    final response = await dio.post('/auth/login', data: {
      'email': email,
      'password': password,
    });
    final apiData = LoginAPIResponse.fromJson(response.data);
    return LoginResponse(type: apiData.type, token: apiData.token);
  }

  @override
  Future<User> current() async {
    final response = await dio.get('/auth/current',
        options: Options(headers: {
          'auth': await keyValueStorage.getValue<String>('token')
        }));
    final apiUser = UserAPI.fromJson(response.data);
    return User(
        type: apiUser.type,
        email: apiUser.email,
        name: apiUser.name,
        id: apiUser.id);
  }

  @override
  Future<bool> update(
      {String? email, String? password, String? name, String? phone}) async {
    final body = <String, String>{};
    if (email != null) body['email'] = email;
    if (password != null) body['password'] = password;
    if (name != null) body['name'] = name;
    await dio.put('/user/update',
        data: body,
        options: Options(headers: {
          'auth': await keyValueStorage.getValue<String>('token')
        }));
    return true;
  }
}
