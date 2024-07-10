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
  late Course mockCourse;
  late Blog mockBlog;

  setUp(() {
    mockBlog = Blog(
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

    mockCourse = Course(
      id: 'id',
      title: 'title',
      description: 'description',
      image: 'image',
      trainer:
          Trainer(id: 'id', name: 'name', location: 'location', image: 'image'),
      category: 'category',
      tags: ['tags'],
      durationMinutes: '60',
      durationWeeks: '70',
      lessons: [],
      level: 'EASY',
      released: DateTime(2024),
    );

    searchResponseMock = SearchResponse(
      blogs: [],
      courses: [],
    );
    mockSearchRepository =
        MockSearchRepository(searchResponse: searchResponseMock);
  });

  blocTest(
    'Should emit SearchState with SearchStatus [SearchStatus.success], isLastPage True when loadNextPage is called and succeeds with no results',
    seed: () => SearchState(
        courses: [mockCourse],
        blogs: [mockBlog],
        status: SearchStatus.success,
        term: 'query',
        isLastPage: false,
        page: 2),
    build: () => SearchBloc(mockSearchRepository),
    act: (bloc) => bloc.loadNextPage(),
    expect: () => [
      SearchState(
          courses: [mockCourse],
          blogs: [mockBlog],
          status: SearchStatus.loading,
          term: 'query',
          isLastPage: false,
          page: 2),
      SearchState(
          courses: [mockCourse],
          blogs: [mockBlog],
          status: SearchStatus.success,
          term: 'query',
          isLastPage: true,
          page: 2),
    ],
  );
}
