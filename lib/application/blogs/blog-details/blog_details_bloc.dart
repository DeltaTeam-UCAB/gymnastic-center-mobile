import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/core/bloc/safe_bloc.dart';
import 'package:gymnastic_center/domain/entities/blogs/blog.dart';
import 'package:gymnastic_center/domain/entities/trainers/trainer.dart';
import 'package:gymnastic_center/domain/repositories/blogs/blogs_repository.dart';

part 'blog_details_event.dart';
part 'blog_details_state.dart';

final initialBlog = Blog(
    id: '',
    title: '',
    body: '',
    released: DateTime.now(),
    images: [],
    trainer: Trainer(id: '', name: '', location: '', image: ''),
    category: '',
    tags: []);

class BlogDetailsBloc extends SafeBloc<BlogDetailsEvent, BlogDetailsState> {
  final BlogsRepository blogsRepository;
  BlogDetailsBloc(this.blogsRepository)
      : super(BlogDetailsState(blog: initialBlog)) {
    on<BlogLoaded>(_onBlogLoaded);
    on<LoadingStarted>(_onLoadingStarted);
    on<ErrorOnBlogLoading>(_onErrorOnBlogLoading);
  }

  void _onLoadingStarted(LoadingStarted event, Emitter<BlogDetailsState> emit) {
    emit(state.copyWith(status: BlogDetailsStatus.loading));
  }

  void _onBlogLoaded(BlogLoaded event, Emitter<BlogDetailsState> emit) {
    emit(state.copyWith(blog: event.blog, status: BlogDetailsStatus.loaded));
  }

  void _onErrorOnBlogLoading(
      ErrorOnBlogLoading event, Emitter<BlogDetailsState> emit) {
    emit(state.copyWith(status: BlogDetailsStatus.error));
  }

  Future<void> loadBlogById(String blogId) async {
    if (state.status == BlogDetailsStatus.loading) return;
    add(LoadingStarted());
    final blogResponse = await blogsRepository.getBlogById(blogId);

    if (blogResponse.isSuccessful()) {
      final blog = blogResponse.getValue();
      add(BlogLoaded(blog: blog));
      return;
    }
    add(ErrorOnBlogLoading());
  }
}
