class Video {
  final String id;
  final String src;

  const Video({required this.id, required this.src});

  @override
  String toString() {
    return 'Video $src - $id';
  }
}
