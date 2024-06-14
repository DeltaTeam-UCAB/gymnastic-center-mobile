import 'dart:developer';

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
    log(Environment.backendApi);
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
  Future<bool> sendRecoveryCode(String email) async {
    await dio.post('/auth/forget/password', data: {
      'email': email,
    });
    return true;
  }

  @override
  Future<bool> changePassword(
      String email, String code, String password) async {
    await dio.put('/auth/change/password', data: {
      'email': email,
      'code': code,
      'password': password,
    });
    return true;
  }

  @override
  Future<bool> validateRecoveryCode(String email, String code) async {
    await dio.post('/auth/code/validate', data: {
      'email': email,
      'code': code,
    });
    return true;
  }
}
