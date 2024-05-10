import 'package:dio/dio.dart';
import 'package:gymnastic_center/application/key_value_storage/key_value_storage.dart';
import 'package:gymnastic_center/domain/datasources/comments/comments_datasource.dart';
import 'package:gymnastic_center/domain/entities/comments/comment.dart';
import 'package:gymnastic_center/infrastructure/core/constants/environment.dart';
import 'package:gymnastic_center/infrastructure/mappers/comment_mapper.dart';
import 'package:gymnastic_center/infrastructure/models/comments/comment_response.dart';

class ApiCommentDatasource extends CommentsDatasource {
  final KeyValueStorageService keyValueStorage;
  final dio =
      Dio(BaseOptions(baseUrl: Environment.backendApi ));
  ApiCommentDatasource(KeyValueStorageService keyValueStorageI)
      : keyValueStorage = keyValueStorageI;
  @override
  Future<List<Comment>> getCommentsByCourseId(String courseId, {int limit = 5 , int offset= 0}) async {
    final response = await dio.get('/find-course-comments/$courseId',
      queryParameters: {
        'limit': limit,
        'offset': offset
      }, 
      options: Options(headers: {
        'auth': await keyValueStorage.getValue<String>('token')
      })
    );
    return _responseToComments(response.data);
  }

  @override
  Future<List<Comment>> getCommentsByPostId(String postId, {int limit = 5 , int offset= 0}) async {
    final response = await dio.get('/find-post-comments/$postId',
      queryParameters: {
        'limit': limit,
        'offset': offset
      }, 
      options: Options(headers: {
        'auth': await keyValueStorage.getValue<String>('token')
      })
    );
    return _responseToComments(response.data);
  }

  List<Comment> _responseToComments(dynamic data){
    final List<CommentResponse> apiCommentsResponse = (data as List)
      .map((data) => CommentResponse.fromJson(data))
      .toList();
    final List<Comment> comments = CommentMapper.apiCommentsEntity(apiCommentsResponse); 
    return comments;
  }

  @override
  Future<bool> likeCommentById(String commentId) async {
    final response = await dio.post('/like',
      data: {
        'idComment' : commentId
      },
      options: Options(
        headers: {
          'auth': await keyValueStorage.getValue<String>('token')
        },
      )
    );
    if (response.data != null){
      final String message = response.data['message'];
      if (message.isNotEmpty){
        return true;
      }
    }
    return false;
  }

  @override
  Future<bool> dislikeCommentById(String commentId) async {
    final response =await dio.post('/dislike',
      data: {
        'idComment' : commentId
      },
      options: Options(
        headers: {
          'auth': await keyValueStorage.getValue<String>('token')
        },
      )
    );
    if (response.data != null){
      final String message = response.data['message'];
      if (message.isNotEmpty){
        return true;
      }
    }
    return false;
  }
}
