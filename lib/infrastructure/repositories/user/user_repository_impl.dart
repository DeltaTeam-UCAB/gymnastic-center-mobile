import 'dart:async';

import 'package:dio/dio.dart';
import 'package:gymnastic_center/application/key_value_storage/key_value_storage.dart';
import 'package:gymnastic_center/common/results.dart';
import 'package:gymnastic_center/domain/datasources/user/user_datasource.dart';
import 'package:gymnastic_center/domain/repositories/user/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final KeyValueStorageService keyValueStorage;
  final UserDatasource userDatasource;
  UserRepositoryImpl(
      {required this.userDatasource, required this.keyValueStorage});
  @override
  Future<Result<bool>> register(
      {required String email,
      required String password,
      required String name,
      required String phone}) async {
    try {
      await userDatasource.register(
          email: email, password: password, name: name, phone: phone);
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
      await keyValueStorage.setKeyValue('token', resp.token);
      if (resp.type == 'CLIENT') {
        return Result.success(true);
      }
      await keyValueStorage.setKeyValue<bool>('isAdmin', true);
      return Result.success(false);
    } catch (e) {
      if (e is DioException && e.response?.statusCode != 500) {
        return Result.fail(Exception('wrong credendials'));
      }
      return Result.fail(Exception('wrong credendials'));
    }
  }

  @override
  Future<Result<bool>> sendRecoveryCode(String email) async {
    try {
      await userDatasource.sendRecoveryCode(email);
      return Result.success(true);
    } catch (e) {
      return Result.fail(Exception('Something went wrong'));
    }
  }

  @override
  Future<Result<bool>> changePassword(
      String email, String code, String password) async {
    try {
      await userDatasource.changePassword(email, code, password);
      return Result.success(true);
    } catch (e) {
      return Result.fail(Exception('Something went wrong'));
    }
  }

  @override
  Future<Result<bool>> validateRecoveryCode(String email, String code) async {
    try {
      await userDatasource.validateRecoveryCode(email, code);
      return Result.success(true);
    } catch (e) {
      return Result.fail(Exception('Something went wrong'));
    }
  }
}
