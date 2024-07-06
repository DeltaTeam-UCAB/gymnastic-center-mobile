import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/domain/repositories/search/search_repository.dart';

part 'tags_event.dart';
part 'tags_state.dart';

class TagsBloc extends Bloc<TagsEvent, TagsState> {
  final SearchRepository _searchRepository;

  TagsBloc(this._searchRepository) : super(const TagsState()) {
    on<LoadPopularTags>(_onLoadPopularTags);
  }

  void _onLoadPopularTags(LoadPopularTags event, Emitter<TagsState> emit) {
    emit(state.copyWith(tags: event.popularTags, status: TagStatus.success));
  }

  Future<void> loadPopularTags() async {
    final result = await _searchRepository.loadPopularTags();
    if (result.isSuccessful()) {
      final popularTags = result.getValue();
      add(LoadPopularTags(popularTags));
    }
  }
}
