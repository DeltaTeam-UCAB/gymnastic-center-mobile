import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/core/bloc/safe_bloc.dart';
import 'package:gymnastic_center/domain/repositories/blogs/blogs_repository.dart';

part 'delete_blog_event.dart';
part 'delete_blog_state.dart';

class DeleteBlogBloc extends SafeBloc<DeleteBlogEvent, DeleteBlogState> {

  final BlogsRepository _blogRepository;

  DeleteBlogBloc(this._blogRepository) : super(const DeleteBlogState()) {
    on<DeleteBlogStarted>(_onDeleteBlogStarted);
    on<BlogDeleted>(_onBlogDeleted);
    on<ErrorOccurred>(_onErrorOccurred);
  }
  void _onDeleteBlogStarted(DeleteBlogStarted event, Emitter<DeleteBlogState> emit){
    emit(
      state.copyWith(
        status: DeleteBlogStatus.deleting,
      )
    );
  }
  void _onBlogDeleted(BlogDeleted event, Emitter<DeleteBlogState> emit){
    emit(
      state.copyWith(
        status: DeleteBlogStatus.initial,
      )
    );
  }
  
  void _onErrorOccurred(ErrorOccurred event, Emitter<DeleteBlogState> emit){
    emit(
      state.copyWith(
        status: DeleteBlogStatus.error,
      )
    );
  }

  Future<void> deleteBlog(String blogId) async {
    add(DeleteBlogStarted());
    final deleteBlogResult = await _blogRepository.deleteBlog(blogId);
    if ( deleteBlogResult.isSuccessful() ){
      add(BlogDeleted());
      return;
    }
    add(ErrorOccurred());
  }
  
}
