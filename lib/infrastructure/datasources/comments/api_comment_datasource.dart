import 'package:dio/dio.dart';
import 'package:gymnastic_center/application/key_value_storage/key_value_storage.dart';
import 'package:gymnastic_center/domain/datasources/comments/comments_datasource.dart';
import 'package:gymnastic_center/domain/entities/comments/comment.dart';
import 'package:gymnastic_center/infrastructure/core/constants/environment.dart';
import 'package:gymnastic_center/infrastructure/mappers/comment_mapper.dart';
import 'package:gymnastic_center/infrastructure/models/comments/comment_apiresponse.dart';

class ApiCommentDatasource extends CommentsDatasource {
  final KeyValueStorageService keyValueStorage;
  final dio =
      Dio(BaseOptions(baseUrl: '${Environment.backendApi}/comment' ));
  ApiCommentDatasource(this.keyValueStorage){
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      final token = await keyValueStorage.getValue<String>('token');
      options.headers['Authorization'] = 'Bearer $token';
      return handler.next(options);
    }));
  }

  @override
  Future<List<Comment>> getCommentsById(String targetId, String targetType,  {int perPage = 5 , int page = 0}) async {
    
    final Map<String, dynamic> queryParameters = {
        'page': page,
        'perPage': perPage,
    };
    
    if (targetType == 'LESSON'){
      queryParameters.addAll({'lesson' : targetId});
    }

    if (targetType == 'BLOG'){
      queryParameters.addAll({'blog' : targetId});
    }

    final response = await dio.get('/many',
      queryParameters: queryParameters
    );
    
    return _responseToComments(response.data);
  }
  
  List<Comment> _responseToComments(dynamic data){
    final List<CommentApiResponse> apiCommentsResponse = (data as List)
      .map((data) => CommentApiResponse.fromJson(data))
      .toList();
    final List<Comment> comments = CommentMapper.apiCommentsEntity(apiCommentsResponse); 
    return comments;
  }

  @override
  Future<bool> toggleLikeCommentById(String commentId) async {
    final response = await dio.post('/toggle/like/$commentId');
    final bool like = response.data['like'];
    return like;
  }

  @override
  Future<bool> toggleDislikeCommentById(String commentId) async {
    final response = await dio.post('/toggle/dislike/$commentId');
    final bool dislike = response.data['dislike'];
    return dislike;
  }
  
  @override
  Future<String> createComment(String targetId, String targetType, String message) async {

    final Map<String, String> body = {
      'target' : targetId,
      'targetType' : targetType,
      'body' : message
    };

    final response = await dio.post('/release',
      data: body
    );

    return response.data['commentId'];
  }
}
