part of 'search_bloc.dart';

sealed class SearchEvent {
  const SearchEvent();
}

class SearchStatusChange extends SearchEvent {
  final SearchStatus status;
  SearchStatusChange(this.status);
}

class SearchStarded extends SearchEvent {
  final String term;
  SearchStarded(this.term);
}

class SearchCompleted extends SearchEvent {
  final List<Course> courses;
  final List<Blog> blogs;

  SearchCompleted({required this.courses, required this.blogs});
}

class SearchInLastPage extends SearchEvent {}

class ChangeSelectedTags extends SearchEvent {
  final List<String> newTags;
  ChangeSelectedTags(this.newTags);
}

class ResetSearch extends SearchEvent {}
