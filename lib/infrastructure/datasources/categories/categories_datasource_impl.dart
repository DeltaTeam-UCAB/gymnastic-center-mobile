// ignore_for_file: unnecessary_this

import 'package:dio/dio.dart';
import 'package:gymnastic_center/application/key_value_storage/key_value_storage.dart';
import 'package:gymnastic_center/domain/datasources/categories/categorie_datasource.dart';
import 'package:gymnastic_center/domain/entities/categories/category.dart';
import 'package:gymnastic_center/infrastructure/core/constants/environment.dart';
import 'package:gymnastic_center/infrastructure/mappers/category_mapper.dart';
import 'package:gymnastic_center/infrastructure/models/categories/category_response.dart';

class CategoriesDatasourceImpl extends CategoryDatasource {
  final KeyValueStorageService keyValueStorage;
  final dio = Dio(BaseOptions(baseUrl: '${Environment.backendApi}/category'));
  CategoriesDatasourceImpl(KeyValueStorageService keyValueStorageI)
      : this.keyValueStorage = keyValueStorageI;

  @override
  Future<List<Category>> getCategoriesPaginated(
      {int page = 1, int perPage = 10}) async {
        final token = await keyValueStorage.getValue<String>('token');
        final response = await dio.get('/many?page=$page&perPage=$perPage',
          options: Options(headers: {
            'Authorization': 'Bearer $token',
        }));
    final List<Category> categories = [];

    for (final category in response.data ?? []) {
      final categoryResponse = CategoryResponse.fromJson(category);
      categories.add(CategoryMapper.categoryToEntity(categoryResponse));
    }

    return categories;
  }
}
