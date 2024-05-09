import 'package:gymnastic_center/domain/entities/posts/post.dart';

abstract class PostsDatasource {
  Future<Post> getPostById(String postId);
  Future<List<Post>> getAllPosts({int limit, int offset});
}
