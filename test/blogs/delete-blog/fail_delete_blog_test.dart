import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymnastic_center/application/blogs/delete-blog/delete_blog_bloc.dart';
import 'package:gymnastic_center/domain/entities/blogs/blog.dart';
import 'package:gymnastic_center/domain/entities/trainers/trainer.dart';

import '../utils/mock_blogs_repository.dart';


void main() {
  late MockBlogsRepository mockBlogsRepository;
  late List<Blog> mockBlogs;
  setUp(() {
    mockBlogs = [
      Blog(
        id: '1',
        title: 'Blog 1',
        tags: ['Tag 1'],
        body: 'Body 1',
        category: 'Category 1',
        images: ['Image 1'],
        released: DateTime(2024, 6, 21),
        trainer:
            Trainer(id: '1', name: 'name', location: 'location', image: 'image'),
      ),
    ];
    mockBlogsRepository = MockBlogsRepository(blogs: mockBlogs, shouldFail: true);
  });

  blocTest(
      'Should emit DeleteBlogState with staatus deleting and error when deleteBlog is called',
      build: () => DeleteBlogBloc(mockBlogsRepository),
      act: (bloc) => bloc.deleteBlog('1'),
      expect: () => [
        isA<DeleteBlogState>()
          .having((state) => state.status, 'status', DeleteBlogStatus.deleting),
        isA<DeleteBlogState>()
          .having((state) => state.status, 'status', DeleteBlogStatus.error),
      ]);
}
 