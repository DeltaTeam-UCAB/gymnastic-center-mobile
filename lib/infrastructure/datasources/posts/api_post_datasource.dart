import 'package:dio/dio.dart';
import 'package:gymnastic_center/domain/datasources/posts/posts_datasource.dart';
import 'package:gymnastic_center/domain/entities/posts/post.dart';
import 'package:gymnastic_center/infrastructure/core/constants/environment.dart';
import 'package:gymnastic_center/infrastructure/mappers/post_mapper.dart';
import 'package:gymnastic_center/infrastructure/models/posts/post_apipost.dart';

class APIPostDatasource extends PostsDatasource {
  
  final dio =
      Dio(BaseOptions(baseUrl: '${Environment.backendApi}/post', headers: {
    //TODO: Extraer el token de autenticacion de un localstorage
    'auth' : 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjU1MzYwMzQ5LTU4NjMtNDJlMi05ZTI1LTAyMWNkZmUyNWM3NCIsImlhdCI6MTcxNTAyNzk4OH0.huPvB-cpIW6E6lvpLl26hxQ3v3gbJkpbkGHlTEMuM6A'
  }));
  
  @override
  Future<List<Post>> getAllPosts({int limit = 5, int offset = 0}) async{
    final response = await dio.get(
      '/getAll',
      queryParameters: {
        'limit' : limit,
        'offset' : offset,
      }
    );

    final posts = (response.data as List).map((data) {
        final apiPostResponse = PostAPIPost.fromJson(data);
        return PostMapper.apiPostToEntity(apiPostResponse);
    }).toList();

    return posts;
  }

  @override
  Future<Post> getPostById(String postId) async {
    final response = await dio.get('/getById/$postId');

    final apiPostResponse = PostAPIPost.fromJson(response.data);
    final post = PostMapper.apiPostToEntity(apiPostResponse);

    return post;
  }
}
