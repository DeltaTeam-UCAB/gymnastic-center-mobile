import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymnastic_center/application/blogs/bloc/blogs_bloc.dart';
import 'package:gymnastic_center/domain/repositories/blogs/blogs_repository.dart';

import '../utils/mock_blogs_repository.dart';

void main() {
  late BlogsRepository mockBlogsRepository;

  setUp(() {
    mockBlogsRepository = MockBlogsRepository(blogs: [], shouldFail: true);
  });

  blocTest(
    'Should emit BlogsState with state [BlogStatus.error] when loadNextPage is called and fails',
    build: () => BlogsBloc(mockBlogsRepository),
    act: (bloc) => bloc.loadNextPage(),
    expect: () => [
      const BlogsState(status: BlogStatus.loading, loadedBlogs: []),
      const BlogsState(status: BlogStatus.error, loadedBlogs: [])
    ],
  );
}
