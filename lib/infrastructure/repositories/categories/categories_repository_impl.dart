import 'package:gymnastic_center/common/results.dart';
import 'package:gymnastic_center/domain/datasources/categories/categorie_datasource.dart';
import 'package:gymnastic_center/domain/entities/categories/category.dart';
import 'package:gymnastic_center/domain/repositories/categories/categories_repository.dart';

class CategoriesRespositoryImpl extends CategoriesRepository {
  final CategoryDatasource categoryDatasource;

  CategoriesRespositoryImpl({required this.categoryDatasource});

  @override
  Future<Result<List<Category>>> getCategoriesPaginated(
      {int page = 1, int perPage = 10}) async {
    try {
      final categories = await categoryDatasource.getCategoriesPaginated(
          page: page, perPage: perPage);
      return Result<List<Category>>.success(categories);
    } catch (error, _) {
      return Result<List<Category>>.fail(error as Exception);
    }
  }
}
