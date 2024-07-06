part of 'tags_bloc.dart';

sealed class TagsEvent{
  const TagsEvent();
}

class LoadPopularTags extends TagsEvent {
  final List<String> popularTags;
  LoadPopularTags(this.popularTags);
}
