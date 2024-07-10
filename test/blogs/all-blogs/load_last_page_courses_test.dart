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
        id: 'id',
        title: 'title',
        body: 'body',
        released: DateTime(2024),
        images: ['image'],
        trainer: Trainer(
            id: 'id', name: 'name', location: 'location', image: 'image'),
        category: 'category',
        tags: ['tags']);
    mockBlogsRepository = MockBlogsRepository(
      blogs: [],
    );
  });

  blocTest(
    'Should emit BlogState with status [BlogStatus.allBlogsLoaded] when loadNextPage is called and no more blogs are found',
    seed: () => BlogsState(loadedBlogs: [mockBlog]),
    build: () => BlogsBloc(mockBlogsRepository),
    act: (bloc) => bloc.loadNextPage(),
    expect: () => [
      BlogsState(status: BlogStatus.loading, loadedBlogs: [mockBlog]),
      BlogsState(status: BlogStatus.allBlogsLoaded, loadedBlogs: [mockBlog])
    ],
  );
}
