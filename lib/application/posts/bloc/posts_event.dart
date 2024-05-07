part of 'posts_bloc.dart';

sealed class PostsEvent {
  const PostsEvent();
}

class CurrentPostLoaded extends PostsEvent {
  final Post currentPost;
  CurrentPostLoaded({required this.currentPost});
}

class PostNotFound extends PostsEvent{}