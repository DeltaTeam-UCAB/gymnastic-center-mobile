import 'package:gymnastic_center/common/results.dart';
import 'package:gymnastic_center/domain/datasources/search/search_datasource.dart';
import 'package:gymnastic_center/domain/repositories/search/search_repository.dart';

class SearchRepositoryImpl extends SearchRepository {
  final SearchDataSource searchDataSource;
  SearchRepositoryImpl(this.searchDataSource);

  @override
  Future<Result<SearchResponse>> search(
      {int page = 1,
      int perPage = 8,
      List<String> tags = const [],
      required String term}) async {
    try {
      final results = await searchDataSource.search(
          page: page, perPage: perPage, term: term, tags: tags);
      return Result<SearchResponse>.success(results);
    } catch (e) {
      return Result<SearchResponse>.fail(e as Exception);
    }
  }

  @override
  Future<Result<List<String>>> loadPopularTags({int page = 1, int perPage = 8}) async {
    try {
      final results = await searchDataSource.loadPopularTags(page: page, perPage: perPage);
      return Result<List<String>>.success(results);
    } catch (e) {
      return Result<List<String>>.fail(e as Exception);
    }
  }
}
