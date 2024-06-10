import 'package:gymnastic_center/common/results.dart';
import 'package:gymnastic_center/domain/datasources/blogs/blogs_datasource.dart';
import 'package:gymnastic_center/domain/entities/blogs/blog.dart';

abstract class BlogsRepository {
  Future<Result<Blog>> getBlogById(String blogId);
  Future<Result<List<Blog>>> getAllBlogs({
    int page, 
    int perPage,
    required BlogFilter filter,
    String? trainer,
    String? category
  });
}
