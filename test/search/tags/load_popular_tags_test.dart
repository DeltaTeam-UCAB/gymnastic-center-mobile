import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymnastic_center/application/search/tags/tags_bloc.dart';
import 'package:gymnastic_center/domain/datasources/search/search_datasource.dart';
import 'package:gymnastic_center/domain/repositories/search/search_repository.dart';

import '../utils/mock_search_repository.dart';

void main() {
  late SearchRepository mockSearchRepository;
  late SearchResponse searchResponseMock;
  late List<String> tagsMock;

  setUp(() {
    tagsMock = ['tag1', 'tag2'];
    searchResponseMock = SearchResponse(
      blogs: [],
      courses: [],
    );
    mockSearchRepository = MockSearchRepository(
        searchResponse: searchResponseMock, tags: tagsMock);
  });

  blocTest(
    'Should emit TagsState with tags [tags] and status [TagStatus.success] when loadPopularTags is called',
    build: () => TagsBloc(mockSearchRepository),
    act: (bloc) => bloc.loadPopularTags(),
    expect: () => [TagsState(tags: tagsMock, status: TagStatus.success)],
  );
}
