import 'package:dio/dio.dart';
import 'package:gymnastic_center/application/key_value_storage/key_value_storage.dart';
import 'package:gymnastic_center/common/results.dart';
import 'package:gymnastic_center/domain/datasources/clients/clients_datasource.dart';
import 'package:gymnastic_center/domain/entities/client/client.dart';
import 'package:gymnastic_center/domain/repositories/clients/clients_repository.dart';

class ClientsRepositoryImpl extends ClientsRepository {
  final KeyValueStorageService keyValueStorage;
  final ClientsDatasource clientsDatasource;
  ClientsRepositoryImpl(
      {required this.clientsDatasource, required this.keyValueStorage});

  @override
  Future<Result<Client>> getClientData() async {
    try {
      final resp = await clientsDatasource.getClientData();
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
      {String? email,
      String? name,
      String? phone,
      String? avatarImage,
      String? password}) async {
    try {
      await clientsDatasource.update(
          email: email,
          name: name,
          phone: phone,
          avatarImage: avatarImage,
          password: password);
      return Result.success(true);
    } catch (e) {
      if (e is DioException && e.response?.statusCode != 500) {
        Result.fail(Exception('Unathorized'));
      }
      rethrow;
    }
  }
}
