import 'package:gymnastic_center/domain/entities/blogs/blog.dart';
import 'package:gymnastic_center/infrastructure/mappers/trainer_mapper.dart';
import 'package:gymnastic_center/infrastructure/models/blogs/blog_apiblog.dart';

class BlogMapper {
  static Blog apiBlogToEntity(BlogAPIBlog blogAPIBlog) => Blog(
        id: blogAPIBlog.id,
        title: blogAPIBlog.title,
        released: blogAPIBlog.date,
        images: blogAPIBlog.images,
        trainer: TrainerMapper.trainerToEntity(blogAPIBlog.trainer),
        tags: blogAPIBlog.tags,
        body: blogAPIBlog.body,
        category: blogAPIBlog.category,
      );
}
