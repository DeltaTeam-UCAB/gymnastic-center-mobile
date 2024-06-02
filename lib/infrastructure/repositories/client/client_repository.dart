import 'package:dio/dio.dart';
import 'package:gymnastic_center/common/results.dart';
import 'package:gymnastic_center/domain/datasources/client/client_datasource.dart';
import 'package:gymnastic_center/domain/entities/client/client.dart';
import 'package:gymnastic_center/domain/repositories/client/client_repository.dart';

class ClientRepositoryImpl extends ClientRepository {
  final ClientDataSource clientDataSource;
  ClientRepositoryImpl({required this.clientDataSource});
  @override
  Future<Result<bool>> setInfo(
      {int? weight,
      int? height,
      DateTime? birthDate,
      String? gender,
      String? location}) async {
    try {
      await clientDataSource.setInfo(
          birthDate: birthDate,
          weight: weight,
          height: height,
          gender: gender,
          location: location);
      return Result.success(true);
    } catch (e) {
      if (e is DioException &&
          e.response?.statusCode != null &&
          e.response?.statusCode != 500) {
        return Result.fail(Exception('Unauthorized'));
      }
      rethrow;
    }
  }

  @override
  Future<Result<Client>> getInfo() async {
    try {
      final client = await clientDataSource.getInfo();
      return Result.success(client);
    } catch (e) {
      if (e is DioException &&
          e.response?.statusCode != null &&
          e.response?.statusCode != 500) {
        return Result.fail(Exception('Unauthorized'));
      }
      rethrow;
    }
  }
}
