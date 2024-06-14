class Trainer {
  final String id;
  final String name;
  final String location;
  final int followers;

  Trainer({
    required this.id,
    required this.name,
    required this.location,
    this.followers = 0,
  });

  Trainer copyWith({
    String? id,
    String? name,
    String? location,
    int? followers,
  }) {
    return Trainer(
      id: id ?? this.id,
      name: name ?? this.name,
      location: location ?? this.location,
      followers: followers ?? this.followers,
    );
  }
}