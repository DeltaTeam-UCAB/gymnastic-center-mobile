class Trainer {
  final String id;
  final String name;
  final String location;
  final int followers;
  final String image;

  Trainer({
    required this.id,
    required this.name,
    required this.location,
    required this.image,
    this.followers = 0,
  });

  Trainer copyWith({
    String? id,
    String? name,
    String? location,
    int? followers,
    String? image,
  }) {
    return Trainer(
      id: id ?? this.id,
      name: name ?? this.name,
      location: location ?? this.location,
      followers: followers ?? this.followers,
      image: image ?? this.image,
    );
  }
}