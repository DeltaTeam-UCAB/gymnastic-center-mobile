import 'package:dio/dio.dart';
import 'package:gymnastic_center/application/key_value_storage/key_value_storage.dart';
import 'package:gymnastic_center/domain/datasources/blogs/blogs_datasource.dart';
import 'package:gymnastic_center/domain/entities/blogs/blog.dart';
import 'package:gymnastic_center/infrastructure/core/constants/environment.dart';
import 'package:gymnastic_center/infrastructure/mappers/blog_mapper.dart';
import 'package:gymnastic_center/infrastructure/models/blogs/blog_apiblog.dart';

class APIBlogDatasource extends BlogsDatasource {
  final KeyValueStorageService keyValueStorage;
  final dio = Dio(BaseOptions(baseUrl: '${Environment.backendApi}/blog'));

  APIBlogDatasource(this.keyValueStorage) {
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      options.headers['auth'] = await keyValueStorage.getValue<String>('token');
      return handler.next(options);
    }));
  }

  @override
  Future<Blog> getBlogById(String blogId) async {
    final response = await dio.get('/one/$blogId');
    final apiBlogResponse = BlogAPIBlog.fromJson(response.data);
    final blog = BlogMapper.apiBlogToEntity(apiBlogResponse);
    return blog;
  }

  @override
  Future<List<Blog>> getAllBlogs(
      {page = 1,
      perPage = 10,
      required BlogFilter filter,
      String? trainer,
      String? category}) async {
    final queryParameters = {
      'page': page,
      'perPage': perPage,
      'filter': filter == BlogFilter.recent ? 'RECENT' : 'POPULAR',
    };

    if (trainer != null) {
      queryParameters['trainer'] = trainer;
    }

    if (category != null) {
      queryParameters['category'] = category;
    }

    final response = await dio.get('/many', queryParameters: queryParameters);

    final blogs = (response.data as List).map((data) {
      final apiBlogResponse = BlogAPIBlog.fromJson(data);
      return BlogMapper.apiBlogToEntity(apiBlogResponse);
    }).toList();

    return blogs;
  }
}
