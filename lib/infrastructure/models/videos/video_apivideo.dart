class VideoAPIVideo {
  final String id;
  final String src;

  VideoAPIVideo({
    required this.id,
    required this.src,
  });

  factory VideoAPIVideo.fromJson(Map<String, dynamic> json) => VideoAPIVideo(
        id: json["id"],
        src: json["src"],
      );
}
