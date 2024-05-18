import 'dart:async';

import 'package:dio/dio.dart';
import 'package:gymnastic_center/infrastructure/core/http/http_service.dart';
import 'package:gymnastic_center/application/core/results.dart';
import 'package:gymnastic_center/application/key_value_storage/key_value_storage.dart';
import 'package:gymnastic_center/domain/entities/user/user.dart';
import 'package:gymnastic_center/domain/repositories/user/user_repository.dart';
import 'package:gymnastic_center/infrastructure/models/user/login_api.dart';
import 'package:gymnastic_center/infrastructure/models/user/user_api.dart';

class UserHttpRepository extends UserRepository {
  final KeyValueStorageService keyValueStorage;
  final HttpHandler http;
  UserHttpRepository({required this.http, required this.keyValueStorage});
  @override
  Future<Result<bool>> register(
      String email, String password, String name) async {
    try {
      await http.post(url: '/user/create', body: {
        'email': email,
        'password': password,
        'name': name,
        'type': 'CLIENT'
      });
      return Result.success(true);
    } catch (e) {
      if (e is DioException && e.response?.statusCode != 500) {
        return Result.fail(Exception('wrong credendials'));
      }
      return Result.fail(Exception('Something went wrong'));
    }
  }

  @override
  Future<Result<bool>> login(String email, String password) async {
    try {
      final resp = await http.postParsed<LoginAPIResponse>(
          url: '/user/login',
          body: {
            'email': email,
            'password': password,
          },
          mapper: LoginAPIResponse.fromJson);
      final data = resp.bodyParsed;
      if (data.type == 'ADMIN') {
        return Result.fail(Exception('Wrong credentials'));
      }
      await keyValueStorage.setKeyValue('token', data.token);
      return Result.success(true);
    } catch (e) {
      if (e is DioException && e.response?.statusCode != 500)
        return Result.fail(Exception('wrong credendials'));
      rethrow;
    }
  }

  @override
  Future<Result<User>> current() async {
    try {
      final response = await http.getParsed<User>(
          url: 'user/current',
          headers: {'auth': await keyValueStorage.getValue<String>('token')},
          mapper: jsonToUser);
      return Result.success(response.bodyParsed);
    } catch (e) {
      if (e is DioException && e.response?.statusCode != 500) {
        Result.fail(Exception('Unathorized'));
      }
      rethrow;
    }
  }

  @override
  Future<Result<bool>> update(
      {String? email, String? password, String? name}) async {
    try {
      await http.put(url: '/user/update', body: {
        'email': email,
        'password': password,
        'name': name,
      }, headers: {
        'auth': await keyValueStorage.getValue<String>('token')
      });
      return Result.success(true);
    } catch (e) {
      if (e is DioException && e.response?.statusCode != 500) {
        Result.fail(Exception('Unathorized'));
      }
      rethrow;
    }
  }
}
