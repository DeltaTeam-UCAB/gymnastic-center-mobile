import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymnastic_center/application/search/bloc/search_bloc.dart';
import 'package:gymnastic_center/domain/datasources/search/search_datasource.dart';
import 'package:gymnastic_center/domain/repositories/search/search_repository.dart';

import '../utils/mock_search_repository.dart';

void main() {
  late SearchRepository mockSearchRepository;
  late SearchResponse searchResponseMock;

  setUp(() {
    searchResponseMock = SearchResponse(
      blogs: [],
      courses: [],
    );
    mockSearchRepository =
        MockSearchRepository(searchResponse: searchResponseMock, shouldFail: true);
  });

  blocTest(
    'Should emit SearchState with SearchStatus [SearchStatus.failure] when search is called and fails',
    build: () => SearchBloc(mockSearchRepository),
    act: (bloc) => bloc.search('query'),
    expect: () => [
      const SearchState(
        courses: [],
        blogs: [],
        status: SearchStatus.loading,
        term: 'query',
        page: 1
      ),
      const SearchState(
        courses: [],
        blogs: [],
        status: SearchStatus.failure,
        term: 'query',
        page: 1
      ),
    ],
  );
}
