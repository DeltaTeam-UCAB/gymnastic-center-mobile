part of 'delete_blog_bloc.dart';


enum DeleteBlogStatus {initial, deleting, error}
class DeleteBlogState extends Equatable {


  final DeleteBlogStatus status;
  const DeleteBlogState({
    this.status = DeleteBlogStatus.initial
  });

  DeleteBlogState copyWith({
    DeleteBlogStatus? status
  }) => DeleteBlogState(
      status: status ?? this.status
    );
  
  @override
  List<Object> get props => [status];
}