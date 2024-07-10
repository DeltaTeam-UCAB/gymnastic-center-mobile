import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymnastic_center/application/blogs/bloc/blogs_bloc.dart';
import 'package:gymnastic_center/domain/entities/blogs/blog.dart';
import 'package:gymnastic_center/domain/entities/trainers/trainer.dart';
import 'package:gymnastic_center/domain/repositories/blogs/blogs_repository.dart';

import '../utils/mock_blogs_repository.dart';

void main() {
  late BlogsRepository mockBlogsRepository;
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
    mockBlogsRepository = MockBlogsRepository(
      blogs: [mockBlog],
    );
  });
  blocTest(
      'Should emit BlogsState with state [BlogState.loaded] and loadBlogs [mockBlog] when loadNextPage is called',
      build: () => BlogsBloc(mockBlogsRepository),
      act: (bloc) => bloc.loadNextPage(),
      expect: () => [
            const BlogsState(status: BlogStatus.loading, loadedBlogs: []),
            BlogsState(status: BlogStatus.loaded, loadedBlogs: [mockBlog])
          ]);
}
