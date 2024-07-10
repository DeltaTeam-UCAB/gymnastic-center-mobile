import 'package:gymnastic_center/common/results.dart';
import 'package:gymnastic_center/domain/datasources/blogs/blogs_datasource.dart';
import 'package:gymnastic_center/domain/entities/blogs/blog.dart';
import 'package:gymnastic_center/domain/repositories/blogs/blogs_repository.dart';

class MockBlogsRepository extends BlogsRepository {
  final List<Blog> blogs;
  final bool shouldFail;

  MockBlogsRepository({required this.blogs, this.shouldFail = false});

  @override
  Future<Result<List<Blog>>> getAllBlogs(
      {int page = 1,
      int perPage = 10,
      required BlogFilter filter,
      String? trainer,
      String? category}) {
    if (shouldFail) {
      return Future.value(Result.fail(Exception('Failed to fetch blogs')));
    }

    if (blogs.isEmpty) {
      return Future.value(Result.success([]));
    }
    return Future.value(Result.success(blogs));
  }

  @override
  Future<Result<Blog>> getBlogById(String blogId) {
    if (shouldFail) {
      return Future.value(Result.fail(Exception('Failed to fetch blog')));
    }
    return Future.value(
        Result.success(blogs.firstWhere((blog) => blog.id == blogId)));
  }
  
  @override
  Future<Result<String>> deleteBlog(String blogId) {
    if (shouldFail) {
      return Future.value(Result.fail(Exception('Failed to delete blog')));
    }
    blogs.removeWhere((blog) => blog.id == blogId);
    return Future.value(Result.success('Blog deleted'));
  }
}
