import 'package:gymnastic_center/domain/entities/blogs/blog.dart';
import 'package:gymnastic_center/domain/entities/courses/course.dart';

class SearchResponse {
  final List<Course> courses;
  final List<Blog> blogs;

  SearchResponse({required this.courses, required this.blogs});
}

abstract class SearchDataSource {
  Future<SearchResponse> search({
    int page = 1,
    int perPage = 8,
    List<String> tags = const [],
    required String term,
  });

  Future<List<String>> loadPopularTags({int page = 1, int perPage = 8});
}
