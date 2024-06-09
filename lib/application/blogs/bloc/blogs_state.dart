part of 'blogs_bloc.dart';

enum BlogStatus { loading, error, loaded, allBlogsLoaded }

class BlogsState extends Equatable {
  final Blog currentBlog;
  final BlogStatus status;
  final List<Blog> loadedBlogs;
  final int page;
  final int perPage;

  const BlogsState(
      {required this.currentBlog,
      this.loadedBlogs = const [],
      this.status = BlogStatus.loaded,
      this.page = 1,
      this.perPage = 10});

  BlogsState copyWith({
    Blog? currentBlog,
    BlogStatus? status,
    List<Blog>? loadedBlogs,
    int? page,
    int? perPage,
  }) =>
      BlogsState(
        currentBlog: currentBlog ?? this.currentBlog,
        status: status ?? this.status,
        loadedBlogs: loadedBlogs ?? this.loadedBlogs,
        page: page ?? this.page,
        perPage: perPage ?? this.perPage,
      );

  @override
  List<Object> get props => [currentBlog, status, loadedBlogs];
}
