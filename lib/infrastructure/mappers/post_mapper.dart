import 'package:gymnastic_center/domain/entities/posts/post.dart';
import 'package:gymnastic_center/infrastructure/models/posts/post_apipost.dart';

class PostMapper{
  static Post apiPostToEntity(PostAPIPost postAPIPost) => Post(
          id: postAPIPost.id, 
          title: postAPIPost.title, 
          released: postAPIPost.date, 
          images: postAPIPost.images.map((img) => img.src).toList(), 
          autor: postAPIPost.autor, 
          tags: postAPIPost.tags,
          body: postAPIPost.body
        );
}