part of 'blog_details_bloc.dart';

sealed class BlogDetailsEvent{
  const BlogDetailsEvent();
}

class BlogLoaded extends BlogDetailsEvent{
  final Blog blog;
  BlogLoaded({required this.blog});
}

class LoadingStarted extends BlogDetailsEvent{}
class ErrorOnBlogLoading extends BlogDetailsEvent{}
