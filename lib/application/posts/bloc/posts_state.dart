part of 'posts_bloc.dart';

enum PostStatus {
  loading,
  error,
  loaded,
}

class PostsState extends Equatable {
  final Post currentPost;
  final PostStatus status;
  final List<Post> loadedPosts;

  const PostsState({
    required this.currentPost,
    this.loadedPosts = const [],
    this.status = PostStatus.loading,
  });

  PostsState copyWith({
    Post? currentPost,
    PostStatus? status,
    List<Post>? loadedPosts,
  }) =>
      PostsState(
        currentPost: currentPost ?? this.currentPost,
        status: status ?? this.status,
        loadedPosts: loadedPosts ?? this.loadedPosts,
      );

  @override
  List<Object> get props => [currentPost, status, loadedPosts];
}
