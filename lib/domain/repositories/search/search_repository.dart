import 'package:gymnastic_center/common/results.dart';
import 'package:gymnastic_center/domain/datasources/search/search_datasource.dart';

abstract class SearchRepository {
  Future<Result<SearchResponse>> search({
    int page = 1,
    int perPage = 8,
    List<String> tags = const [],
    required String term,
  });

  Future<Result<List<String>>> loadPopularTags({int page = 1, int perPage = 8});
}
