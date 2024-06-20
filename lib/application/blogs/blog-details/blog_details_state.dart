part of 'blog_details_bloc.dart';

enum BlogDetailsStatus { initial, loading, loaded, error }

class BlogDetailsState extends Equatable {
  final Blog blog;
  final BlogDetailsStatus status;
  const BlogDetailsState({
    required this.blog, 
    this.status = BlogDetailsStatus.initial,
  });

  BlogDetailsState copyWith({
    Blog? blog,
    BlogDetailsStatus? status,
  }) {
    return BlogDetailsState(
      blog: blog ?? this.blog,
      status: status ?? this.status,
    );
  }
  
  @override
  List<Object> get props => [blog, status];
}

