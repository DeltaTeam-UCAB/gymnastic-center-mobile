import 'package:gymnastic_center/domain/entities/categories/category.dart';

abstract class CategoryDatasource {
  Future<List<Category>> getCategoriesPaginated(
      {int page = 1, int perPage = 10});
}
