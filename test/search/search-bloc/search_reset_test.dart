import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymnastic_center/application/search/bloc/search_bloc.dart';
import 'package:gymnastic_center/domain/datasources/search/search_datasource.dart';
import 'package:gymnastic_center/domain/entities/blogs/blog.dart';
import 'package:gymnastic_center/domain/entities/courses/course.dart';
import 'package:gymnastic_center/domain/entities/trainers/trainer.dart';
import 'package:gymnastic_center/domain/repositories/search/search_repository.dart';

import '../utils/mock_search_repository.dart';

void main() {
  late SearchRepository mockSearchRepository;
  late SearchResponse searchResponseMock;
  late Course courseMock;
  late Blog blogMock;

  setUp(() {
    courseMock = Course(
      id: '1',
      title: 'Course 1',
      description: 'Description 1',
      trainer:
          Trainer(id: '1', name: 'name', location: 'location', image: 'image'),
      category: 'Category 1',
      image: 'Image 1',
      tags: ['Tag 1'],
      level: 'Level 1',
      released: DateTime(2024, 6, 21),
      durationMinutes: '400',
      durationWeeks: '4',
      lessons: [],
    );

    blogMock = Blog(
      id: '1',
      title: 'Blog 1',
      tags: ['Tag 1'],
      body: 'Body 1',
      category: 'Category 1',
      images: ['Image 1'],
      released: DateTime(2024, 6, 21),
      trainer:
          Trainer(id: '1', name: 'name', location: 'location', image: 'image'),
    );

    searchResponseMock = SearchResponse(
      blogs: [blogMock],
      courses: [courseMock],
    );
    mockSearchRepository =
        MockSearchRepository(searchResponse: searchResponseMock);
  });

  blocTest(
    'Should emit SearchState with SearchStatus [SearchStatus.initial] and courses & blogs empty when resetSearch is called',
    seed: () => SearchState(
        courses: [courseMock],
        blogs: [blogMock],
        status: SearchStatus.success,
        page: 2,
        term: 'term',
        selectedTags: const ['tag']),
    build: () => SearchBloc(mockSearchRepository),
    act: (bloc) => bloc.resetSearch(),
    expect: () => [
      const SearchState(
          courses: [],
          blogs: [],
          status: SearchStatus.initial,
          term: '',
          selectedTags: [],
          page: 1),
    ],
  );
}
