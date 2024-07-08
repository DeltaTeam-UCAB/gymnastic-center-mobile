import 'package:gymnastic_center/common/results.dart';
import 'package:gymnastic_center/domain/datasources/search/search_datasource.dart';
import 'package:gymnastic_center/domain/repositories/search/search_repository.dart';

class MockSearchRepository extends SearchRepository {
  final List<String> tags;
  final SearchResponse searchResponse;
  final bool shouldFail;

  MockSearchRepository(
      {this.tags = const [],
      required this.searchResponse,
      this.shouldFail = false});

  @override
  Future<Result<List<String>>> loadPopularTags([page = 1, perPage = 10]) {
    if (tags.isNotEmpty) {
      return Future.value(Result.success(tags));
    }
    return Future.value(Result.fail(Exception('No Tags Found')));
  }

  @override
  Future<Result<SearchResponse>> search(
      {int page = 1,
      int perPage = 8,
      List<String> tags = const [],
      required String term}) {
    if (shouldFail) {
      return Future.value(Result.fail(Exception('Failed to search')));
    }
    return Future.value(Result.success(searchResponse));
  }
}
