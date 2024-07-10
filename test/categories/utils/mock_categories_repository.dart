import 'package:gymnastic_center/common/results.dart';
import 'package:gymnastic_center/domain/entities/categories/category.dart';
import 'package:gymnastic_center/domain/repositories/categories/categories_repository.dart';

class MockCategoriesRepository extends CategoriesRepository {
  final List<Category> categories;
  final bool shouldFail;

  MockCategoriesRepository(this.categories, [this.shouldFail = false]);

  @override
  Future<Result<List<Category>>> getCategoriesPaginated(
      {int page = 1, int perPage = 10}) {
    if (shouldFail) {
      return Future.value(Result.fail(Exception('An error occurred')));
    }
    return Future.value(Result.success(categories));
  }
}
