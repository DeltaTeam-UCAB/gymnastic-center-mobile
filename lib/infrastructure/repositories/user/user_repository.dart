import 'dart:async';

import 'package:dio/dio.dart';
import 'package:gymnastic_center/application/key_value_storage/key_value_storage.dart';
import 'package:gymnastic_center/common/results.dart';
import 'package:gymnastic_center/domain/datasources/user/user_datasource.dart';
import 'package:gymnastic_center/domain/entities/user/user.dart';
import 'package:gymnastic_center/domain/repositories/user/user_repository.dart';

class UserHttpRepository extends UserRepository {
  final KeyValueStorageService keyValueStorage;
  final UserDatasource userDatasource;
  UserHttpRepository(
      {required this.userDatasource, required this.keyValueStorage});
  @override
  Future<Result<bool>> register({
    required String email,
    required String password,
    required String name,
    required String phone
  }) async {
    try {
      await userDatasource.register(email: email, password: password, name: name, phone: phone);
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
      final resp = await userDatasource.login(email, password);
      if (resp.type == 'ADMIN') {
        return Result.fail(Exception('Wrong credentials'));
      }
      await keyValueStorage.setKeyValue('token', resp.token);
      return Result.success(true);
    } catch (e) {
      if (e is DioException && e.response?.statusCode != 500) {
        return Result.fail(Exception('wrong credendials'));
      }
      rethrow;
    }
  }

  @override
  Future<Result<User>> current() async {
    try {
      final resp = await userDatasource.current();
      return Result.success(resp);
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
      await userDatasource.update(email: email, password: password, name: name);
      return Result.success(true);
    } catch (e) {
      if (e is DioException && e.response?.statusCode != 500) {
        Result.fail(Exception('Unathorized'));
      }
      rethrow;
    }
  }
}
