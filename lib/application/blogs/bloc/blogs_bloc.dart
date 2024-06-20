import 'dart:core';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/domain/datasources/blogs/blogs_datasource.dart';
import 'package:gymnastic_center/domain/entities/blogs/blog.dart';
import 'package:gymnastic_center/domain/repositories/blogs/blogs_repository.dart';

part 'blogs_event.dart';
part 'blogs_state.dart';

class BlogsBloc extends Bloc<BlogsEvent, BlogsState> {
  final BlogsRepository blogsRepository;

  BlogsBloc(this.blogsRepository) : super(const BlogsState()) {
    on<BlogsLoaded>(_onBlogsLoaded);
    on<LoadingStarted>(_onLoadingStarted);
    on<ErrorOnBlogsLoading>(_onErrorOnBlogsLoading);
    on<AllBlogsLoaded>(_onAllBlogsLoaded);
  }

  void _onLoadingStarted(LoadingStarted event, Emitter<BlogsState> emit) {
    emit(state.copyWith(status: BlogStatus.loading));
  }

  void _onBlogsLoaded(BlogsLoaded event, Emitter<BlogsState> emit) {
    emit(state.copyWith(
        loadedBlogs: [...state.loadedBlogs, ...event.blogs],
        status: BlogStatus.loaded,
        page: state.page + 1));
  }

  void _onAllBlogsLoaded(AllBlogsLoaded event, Emitter<BlogsState> emit) {
    emit(state.copyWith(status: BlogStatus.allBlogsLoaded));
  }

  void _onErrorOnBlogsLoading(
      ErrorOnBlogsLoading event, Emitter<BlogsState> emit) {
    emit(state.copyWith(status: BlogStatus.error));
  }

  Future<void> loadNextPage(
      {BlogFilter filter = BlogFilter.recent,
      String? categoryId,
      String? trainerId}) async {
    if (state.status == BlogStatus.loading ||
        state.status == BlogStatus.allBlogsLoaded) return;
    add(LoadingStarted());
    final blogsResult = await blogsRepository.getAllBlogs(
      page: state.page,
      perPage: state.perPage,
      filter: filter,
      category: categoryId,
      trainer: trainerId,
    );
    if (blogsResult.isSuccessful()) {
      final blogs = blogsResult.getValue();
      if (blogs.isNotEmpty) {
        add(BlogsLoaded(blogs: blogs));
        return;
      }
      add(AllBlogsLoaded());
      return;
    }
    add(ErrorOnBlogsLoading());
  }
}
