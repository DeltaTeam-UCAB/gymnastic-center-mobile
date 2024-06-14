import 'package:gymnastic_center/domain/entities/trainers/trainer.dart';

class Blog {
  final String id;
  final String title;
  final String body;
  final DateTime released;
  final List<String> images;
  final Trainer trainer;
  final List<String> tags;
  final String category;


  const Blog(
      {required this.id,
      required this.title,
      required this.body,
      required this.released,
      required this.images,
      required this.trainer,
      required this.category,
      required this.tags});
}
