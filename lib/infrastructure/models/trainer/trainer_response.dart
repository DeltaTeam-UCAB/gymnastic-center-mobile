class TrainerResponse {
  final String id;
  final String name;
  final String locations;
  final int followers;
  final bool isFollowed;

  TrainerResponse({
    required this.id,
    required this.name,
    this.locations = '',
    this.followers = 0,
    this.isFollowed = false,
  });

  factory TrainerResponse.fromJson(Map<String, dynamic> json) =>
      TrainerResponse(
        id: json["id"],
        name: json["name"],
        locations: json["locations"] ?? '',
        followers: json["followers"] ?? 0,
        isFollowed: json["userFollow"] ?? false,
      );
}
