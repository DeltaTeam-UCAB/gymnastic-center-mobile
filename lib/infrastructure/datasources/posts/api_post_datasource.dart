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
    // 'auth' : 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjcyOGIwMTcyLTc0NzQtNDhkYi1iZTZiLWY2MTFhNTA0OTRlYiIsImlhdCI6MTcxNTAyNzkwOX0.h-uYhv0_qMClBZ2_rjcyem29Xu_g4K_CxOqDnyJvdjw'
  }));

  Future<Post> getAllPosts({int limit = 5, int offset = 0}) {
    // TODO: implement getAllPosts
    throw UnimplementedError();
  }

  @override
  Future<Post> getPostById(String postId) async {
    final response = await dio.get('/getById/$postId');

    final apiPostResponse = PostAPIPost.fromJson(response.data);
    final post = PostMapper.apiPostToEntity(apiPostResponse);

    return post;
  }
}
