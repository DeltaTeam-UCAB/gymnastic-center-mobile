part of 'search_bloc.dart';

enum SearchStatus { initial, loading, success, failure }

class SearchState extends Equatable {
  final List<Course> courses;
  final List<Blog> blogs;

  final String term;
  final List<String> selectedTags;

  final SearchStatus status;
  final bool isLastPage;
  final int page;
  final int perPage;

  const SearchState(
      {this.courses = const [],
      this.blogs = const [],
      this.selectedTags = const [],
      this.status = SearchStatus.initial,
      this.term = '',
      this.isLastPage = false,
      this.page = 1,
      this.perPage = 8});

  SearchState copyWith({
    List<Course>? courses,
    List<Blog>? blogs,
    SearchStatus? status,
    String? term,
    List<String>? selectedTags,
    bool? isLastPage,
    int? page,
    int? perPage,
  }) {
    return SearchState(
      courses: courses ?? this.courses,
      blogs: blogs ?? this.blogs,
      status: status ?? this.status,
      term: term ?? this.term,
      selectedTags: selectedTags ?? this.selectedTags,
      isLastPage: isLastPage ?? this.isLastPage,
      page: page ?? this.page,
      perPage: perPage ?? this.perPage,
    );
  }

  @override
  List<Object> get props =>
      [courses, blogs, status, isLastPage, page, perPage, term, selectedTags];
}
