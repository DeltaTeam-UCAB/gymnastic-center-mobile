part of 'blogs_bloc.dart';

sealed class BlogsEvent {
  const BlogsEvent();
}

class BlogsLoaded extends BlogsEvent {
  final List<Blog> blogs;
  BlogsLoaded({required this.blogs});
}

class AllBlogsLoaded extends BlogsEvent {}

class LoadingStarted extends BlogsEvent {}

class ErrorOnBlogsLoading extends BlogsEvent {}
