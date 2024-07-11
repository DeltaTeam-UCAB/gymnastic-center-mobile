import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymnastic_center/application/blogs/blog-details/blog_details_bloc.dart';
import 'package:gymnastic_center/domain/repositories/blogs/blogs_repository.dart';

import '../utils/mock_blogs_repository.dart';


void main() {
  late BlogsRepository mockBlogsRepository;
  setUp(() => mockBlogsRepository = MockBlogsRepository(
    blogs: [],
    shouldFail: true,
  ));

  blocTest(
    'Should emit BlogDetailsState with status [BlogDetailsStatus.error] when getCourseById is called and no courses are found',
    build: () => BlogDetailsBloc(mockBlogsRepository),
    act: (bloc) => bloc.loadBlogById('1'),
    expect: () => [
      BlogDetailsState(status: BlogDetailsStatus.loading, blog: initialBlog),
      BlogDetailsState(status: BlogDetailsStatus.error, blog: initialBlog)
    ],
  );
}
