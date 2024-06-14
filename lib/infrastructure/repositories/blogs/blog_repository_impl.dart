import 'package:gymnastic_center/common/results.dart';
import 'package:gymnastic_center/domain/datasources/blogs/blogs_datasource.dart';
import 'package:gymnastic_center/domain/entities/blogs/blog.dart';
import 'package:gymnastic_center/domain/repositories/blogs/blogs_repository.dart';

class BlogRepositoryImpl extends BlogsRepository {
  final BlogsDatasource blogsDatasource;

  BlogRepositoryImpl({required this.blogsDatasource});

  @override
  Future<Result<List<Blog>>> getAllBlogs(
      {page = 1,
      perPage = 10,
      required BlogFilter filter,
      String? trainer,
      String? category}) async {
    try {
      final blogs = await blogsDatasource.getAllBlogs(
          page: page,
          perPage: perPage,
          filter: filter,
          trainer: trainer,
          category: category);
      return Result<List<Blog>>.success(blogs);
    } catch (e) {
      return Result<List<Blog>>.fail(e as Exception);
    }
  }

  @override
  Future<Result<Blog>> getBlogById(String blogId) async {
    try {
      final blog = await blogsDatasource.getBlogById(blogId);
      return Result<Blog>.success(blog);
    } catch (e) {
      return Result<Blog>.fail(e as Exception);
    }
  }
}
