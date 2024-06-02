import 'package:gymnastic_center/common/results.dart';
import 'package:gymnastic_center/domain/entities/posts/post.dart';

abstract class PostsRepository {
  Future<Result<Post>> getPostById(String postId);
  Future<Result<List<Post>>> getAllPosts({int limit, int offset});
}
