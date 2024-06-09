import 'package:gymnastic_center/domain/entities/categories/category.dart';
import '../../../common/results.dart';

abstract class CategoriesRepository {
  Future<Result<List<Category>>> getCategoriesPaginated(
      {int page = 1, int perPage = 10});
}
