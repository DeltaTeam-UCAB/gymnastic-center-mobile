class Post {
  final String id;
  final String title;
  final String body;

  final DateTime released;
  final List<String> images;
  final String autor;
  final List<String> tags;

  const Post(
      {required this.id,
      required this.title,
      required this.body,
      required this.released,
      required this.images,
      required this.autor,
      required this.tags});
}