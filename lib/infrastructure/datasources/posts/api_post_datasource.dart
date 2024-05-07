import 'package:dio/dio.dart';
import 'package:gymnastic_center/application/key_value_storage/key_value_storage.dart';
import 'package:gymnastic_center/domain/datasources/posts/posts_datasource.dart';
import 'package:gymnastic_center/domain/entities/posts/post.dart';
import 'package:gymnastic_center/infrastructure/core/constants/environment.dart';
import 'package:gymnastic_center/infrastructure/mappers/post_mapper.dart';
import 'package:gymnastic_center/infrastructure/models/posts/post_apipost.dart';

class APIPostDatasource extends PostsDatasource {
  final KeyValueStorageService keyValueStorage;
  final dio = Dio(BaseOptions(baseUrl: '${Environment.backendApi}/post'));
  APIPostDatasource(KeyValueStorageService keyValueStorageI)
      : keyValueStorage = keyValueStorageI;

  Future<Post> getAllPosts({int limit = 5, int offset = 0}) {
    // TODO: implement getAllPosts
    throw UnimplementedError();
  }

  @override
  Future<Post> getPostById(String postId) async {
    final response = await dio.get('/getById/$postId',
        options: Options(headers: {
          'auth': await keyValueStorage.getValue<String>('token')
        }));

    final apiPostResponse = PostAPIPost.fromJson(response.data);
    final post = PostMapper.apiPostToEntity(apiPostResponse);

    return post;
  }
}
