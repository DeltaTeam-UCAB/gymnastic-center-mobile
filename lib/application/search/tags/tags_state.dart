part of 'tags_bloc.dart';

enum TagStatus { loading, success, failure }

class TagsState extends Equatable {
  final List<String> tags;
  final TagStatus status;
  final int perPage;

  const TagsState({
    this.perPage = 8,
    this.tags = const [],
    this.status = TagStatus.loading,
  });

  TagsState copyWith({
    List<String>? tags,
    TagStatus? status,
  }) {
    return TagsState(
      tags: tags ?? this.tags,
      status: status ?? this.status,
    );
  }
  
  @override
  List<Object> get props => [tags, status, perPage];
}

