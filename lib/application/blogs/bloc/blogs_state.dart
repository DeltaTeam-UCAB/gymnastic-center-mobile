part of 'blogs_bloc.dart';

enum BlogStatus { loading, error, loaded, allBlogsLoaded }

class BlogsState extends Equatable {
  final BlogStatus status;
  final List<Blog> loadedBlogs;
  final int page;
  final int perPage;

  const BlogsState(
      {this.loadedBlogs = const [],
      this.status = BlogStatus.loaded,
      this.page = 1,
      this.perPage = 10});

  BlogsState copyWith({
    BlogStatus? status,
    List<Blog>? loadedBlogs,
    int? page,
    int? perPage,
  }) =>
      BlogsState(
        status: status ?? this.status,
        loadedBlogs: loadedBlogs ?? this.loadedBlogs,
        page: page ?? this.page,
        perPage: perPage ?? this.perPage,
      );

  @override
  List<Object> get props => [status, loadedBlogs];
}
