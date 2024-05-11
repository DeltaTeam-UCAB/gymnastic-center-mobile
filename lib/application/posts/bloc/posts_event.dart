part of 'posts_bloc.dart';

sealed class PostsEvent {
  const PostsEvent();
}

class CurrentPostLoaded extends PostsEvent {
  final Post currentPost;
  CurrentPostLoaded({required this.currentPost});
}

class PostsLoaded extends PostsEvent {
  final List<Post> posts;
  PostsLoaded({required this.posts});
}

class AllPostsLoaded extends PostsEvent {}

class LoadingStarted extends PostsEvent {}

class ErrorOnPostsLoading extends PostsEvent {}
