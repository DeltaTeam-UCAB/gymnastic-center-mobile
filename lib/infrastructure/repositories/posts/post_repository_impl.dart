import 'package:gymnastic_center/application/core/results.dart';
import 'package:gymnastic_center/domain/datasources/posts/posts_datasource.dart';
import 'package:gymnastic_center/domain/entities/posts/post.dart';
import 'package:gymnastic_center/domain/repositories/posts/posts_repository.dart';

class PostRepositoryImpl extends PostsRepository {
  final PostsDatasource postsDatasource;

  PostRepositoryImpl({required this.postsDatasource});

  @override
  Future<Result<Post>> getAllPosts({int limit = 5, int offset = 0}) {
    throw UnimplementedError();
  }

  @override
  Future<Result<Post>> getPostById(String postId) async {
    try {
      final post = await postsDatasource.getPostById(postId);
      return Result<Post>.success(post);
    } catch (e) {
      return Result<Post>.fail(e as Exception);
    }
  }
}
