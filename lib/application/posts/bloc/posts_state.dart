part of 'posts_bloc.dart';

enum PostStatus {
  loading,
  error,
  loaded,
  allPostsLoaded
}

class PostsState extends Equatable {
  final Post currentPost;
  final PostStatus status;
  final List<Post> loadedPosts;
  final int limit;
  final int offset;


  const PostsState({
    required this.currentPost,
    this.loadedPosts = const [],
    this.status = PostStatus.loaded,
    this.limit = 8,
    this.offset =0
  });

  PostsState copyWith({
    Post? currentPost,
    PostStatus? status,
    List<Post>? loadedPosts,
    int? limit,
    int? offset,
  }) =>
      PostsState(
        currentPost: currentPost ?? this.currentPost,
        status: status ?? this.status,
        loadedPosts: loadedPosts ?? this.loadedPosts,
        limit: limit ?? this.limit,
        offset: offset ?? this.offset,
      );

  @override
  List<Object> get props => [currentPost, status, loadedPosts];
}
