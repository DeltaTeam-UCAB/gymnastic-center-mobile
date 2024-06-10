import 'package:dio/dio.dart';
import 'package:gymnastic_center/domain/datasources/user/user_datasource.dart';
import 'package:gymnastic_center/infrastructure/core/constants/environment.dart';
import 'package:gymnastic_center/infrastructure/models/user/login_api.dart';

class APIUserDatasource extends UserDatasource {
  final dio = Dio(BaseOptions(baseUrl: Environment.backendApi));

  @override
  Future<bool> register(
      {required String email,
      required String password,
      required String name,
      required String phone}) async {
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
}
