import 'package:gymnastic_center/domain/entities/blogs/blog.dart';

enum BlogFilter {
  recent,
  popular,
}

abstract class BlogsDatasource {
  Future<Blog> getBlogById(String blogId);
  Future<List<Blog>> getAllBlogs({
    int page, 
    int perPage,
    required  BlogFilter filter,
    String? trainer,
    String? category
  });
  Future<String> deleteBlog(String blogId);
}
