import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/core/bloc/safe_bloc.dart';
import 'package:gymnastic_center/domain/entities/blogs/blog.dart';
import 'package:gymnastic_center/domain/entities/courses/course.dart';
import 'package:gymnastic_center/domain/repositories/search/search_repository.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends SafeBloc<SearchEvent, SearchState> {
  final SearchRepository _searchRepository;

  SearchBloc(this._searchRepository) : super(const SearchState()) {
    on<ChangeSelectedTags>(_onChangeSelectedTags);
    on<SearchInLastPage>(_onSearchInLastPage);
    on<SearchStarded>(_onSearchStarted);
    on<SearchStatusChange>(_onSearchStatusChange);
    on<SearchCompleted>(_onSearchCompleted);
    on<ResetSearch>(_onResetSearch);
  }

  void _onResetSearch(ResetSearch event, Emitter<SearchState> emit) {
    emit(const SearchState());
  }

  void _onChangeSelectedTags(
      ChangeSelectedTags event, Emitter<SearchState> emit) {
    emit(state.copyWith(selectedTags: event.newTags));
  }

  void _onSearchInLastPage(SearchInLastPage event, Emitter<SearchState> emit) {
    emit(state.copyWith(status: SearchStatus.success, isLastPage: true));
  }

  void _onSearchStarted(SearchStarded event, Emitter<SearchState> emit) {
    emit(state.copyWith(
        status: SearchStatus.loading,
        page: 1,
        isLastPage: false,
        courses: [],
        blogs: [],
        term: event.term));
  }

  void _onSearchStatusChange(
      SearchStatusChange event, Emitter<SearchState> emit) {
    emit(state.copyWith(status: event.status));
  }

  void _onSearchCompleted(SearchCompleted event, Emitter<SearchState> emit) {
    emit(state.copyWith(
        status: SearchStatus.success,
        courses: [...state.courses, ...event.courses],
        blogs: [...state.blogs, ...event.blogs],
        page: state.page + 1));
  }

  void onChangeTags(List<String> newTags) {
    add(ChangeSelectedTags(newTags));
    Future.delayed(const Duration(milliseconds: 100), () async {
      await search(state.term);
    });
  }

  void resetSearch() {
    add(ResetSearch());
  }

  Future<void> search(String term) async {
    if (term.isEmpty) return;
    add(SearchStarded(term));

    final result = await _searchRepository.search(
        term: term, page: 1, tags: state.selectedTags);

    if (result.isSuccessful()) {
      final searchResult = result.getValue();
      add(SearchCompleted(
        courses: searchResult.courses,
        blogs: searchResult.blogs,
      ));
      return;
    }
    add(SearchStatusChange(SearchStatus.failure));
  }

  Future<void> loadNextPage() async {
    if (state.status == SearchStatus.loading || state.isLastPage) return;
    add(SearchStatusChange(SearchStatus.loading));

    final result = await _searchRepository.search(
        term: state.term, page: state.page, tags: state.selectedTags);

    if (result.isSuccessful()) {
      final searchResult = result.getValue();
      if (searchResult.blogs.isEmpty && searchResult.courses.isEmpty) {
        add(SearchInLastPage());
        return;
      }
      add(SearchCompleted(
        courses: searchResult.courses,
        blogs: searchResult.blogs,
      ));
      return;
    }
    add(SearchStatusChange(SearchStatus.failure));
  }
}
