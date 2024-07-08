class TrainerResponse {
  final String id;
  final String name;
  final String location;
  final int followers;
  final bool isFollowed;
  final String image;

  TrainerResponse({
    required this.id,
    required this.name,
    this.location = '',
    this.followers = 0,
    this.isFollowed = false,
    this.image =
        'https://cdn.icon-icons.com/icons2/3551/PNG/512/trainer_man_people_avatar_person_icon_224850.png',
  });

  factory TrainerResponse.fromJson(Map<String, dynamic> json) =>
      TrainerResponse(
        id: json["id"],
        name: json["name"],
        location: json["location"] ?? '',
        followers: json["followers"] ?? 0,
        isFollowed: json["userFollow"] ?? false,
        image: json["image"] ??
            'https://cdn.icon-icons.com/icons2/3551/PNG/512/trainer_man_people_avatar_person_icon_224850.png',
      );
}
