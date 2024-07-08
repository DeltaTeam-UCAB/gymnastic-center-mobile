import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/core/bloc/safe_bloc.dart';
import 'package:gymnastic_center/domain/repositories/search/search_repository.dart';

part 'tags_event.dart';
part 'tags_state.dart';

class TagsBloc extends SafeBloc<TagsEvent, TagsState> {
  final SearchRepository _searchRepository;

  TagsBloc(this._searchRepository) : super(const TagsState()) {
    on<LoadPopularTags>(_onLoadPopularTags);
    on<FailedLoadPopularTags>(_onFailedLoadPopularTags);
  }

  void _onFailedLoadPopularTags(
      FailedLoadPopularTags event, Emitter<TagsState> emit) {
    emit(state.copyWith(status: TagStatus.failure));
  }

  void _onLoadPopularTags(LoadPopularTags event, Emitter<TagsState> emit) {
    emit(state.copyWith(tags: event.popularTags, status: TagStatus.success));
  }

  Future<void> loadPopularTags() async {
    final result = await _searchRepository.loadPopularTags();
    if (result.isSuccessful()) {
      final popularTags = result.getValue();
      add(LoadPopularTags(popularTags));
      return;
    }
    add(FailedLoadPopularTags());
  }
}
