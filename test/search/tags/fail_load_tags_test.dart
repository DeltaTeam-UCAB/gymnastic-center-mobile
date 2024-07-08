import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymnastic_center/application/search/tags/tags_bloc.dart';
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
    mockSearchRepository = MockSearchRepository(
        searchResponse: searchResponseMock);
  });

  blocTest(
    'Should emit TagsState with status [TagStatus.failure] when loadPopularTags is called and fails',
    build: () => TagsBloc(mockSearchRepository),
    act: (bloc) => bloc.loadPopularTags(),
    expect: () => [const TagsState(tags: [], status: TagStatus.failure)],
  );
}
