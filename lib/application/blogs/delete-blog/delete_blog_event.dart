part of 'delete_blog_bloc.dart';

class DeleteBlogEvent{
  const DeleteBlogEvent();
}

class DeleteBlogStarted extends DeleteBlogEvent{}

class BlogDeleted extends DeleteBlogEvent{}

class ErrorOccurred extends DeleteBlogEvent{}