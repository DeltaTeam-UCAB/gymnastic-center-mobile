import 'package:gymnastic_center/application/core/results.dart';
import 'package:gymnastic_center/domain/entities/posts/post.dart';

abstract class PostsRepository{
  Future<Result<Post>> getPostById(String postId);
  Future<Result<Post>> getAllPosts({int limit, int offset});

}
