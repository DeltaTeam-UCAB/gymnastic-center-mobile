class TrainerResponse {
  final String id;
  final String name;
  final String locations;

  TrainerResponse({
    required this.id,
    required this.name,
    this.locations = '',
  });

  factory TrainerResponse.fromJson(Map<String, dynamic> json) =>
      TrainerResponse(
        id: json["id"],
        name: json["name"],
        locations: json["locations"] ?? '',
      );
}
