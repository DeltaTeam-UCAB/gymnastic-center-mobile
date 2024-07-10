import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymnastic_center/application/blogs/blog-details/blog_details_bloc.dart';
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
      'Should emit BlogDetailsState with status [BlogDetailsStatus.loaded] when loadBlogById is called and blog are found',
      build: () => BlogDetailsBloc(mockBlogsRepository),
      act: (bloc) => bloc.loadBlogById('1'),
      expect: () => [
            BlogDetailsState(
                blog: initialBlog, status: BlogDetailsStatus.loading),
            BlogDetailsState(
                blog: mockBlog, status: BlogDetailsStatus.loaded)
          ]);
}
