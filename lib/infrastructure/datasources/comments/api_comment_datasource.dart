import 'package:dio/dio.dart';
import 'package:gymnastic_center/domain/datasources/comments/comments_datasource.dart';
import 'package:gymnastic_center/domain/entities/comments/comment.dart';
import 'package:gymnastic_center/infrastructure/core/constants/environment.dart';
import 'package:gymnastic_center/infrastructure/mappers/comment_mapper.dart';
import 'package:gymnastic_center/infrastructure/models/comments/comment_response.dart';

class ApiCommentDatasource extends CommentsDatasource {
  final dio =
      Dio(BaseOptions(baseUrl: Environment.backendApi, headers: {
    //TODO: Extraer el token de autenticacion de un localstorage
    'auth':
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjcyOGIwMTcyLTc0NzQtNDhkYi1iZTZiLWY2MTFhNTA0OTRlYiIsImlhdCI6MTcxNDk5NTUzNX0.3T96kqagASMZ7OsrKmvZDvgBEJvLvqWS72pG_K3QPdY'
  }));

  @override
  Future<List<Comment>> getCommentsByCourseId(String courseId, {int limit = 5 , int offset= 0}) async {
    final response = await dio.get('/find-course-comments/$courseId',
      queryParameters: {
        'limit': limit,
        'offset': offset
      }, 
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
    );
    return _responseToComments(response.data);

  }

  List<Comment> _responseToComments(dynamic data){
    final List<CommentResponse> apiVideoResponse = (data as List)
      .map((data) => CommentResponse.fromJson(data))
      .toList();
    final List<Comment> comments = CommentMapper.apiCommentsEntity(apiVideoResponse); 
    return comments;
  }

}
