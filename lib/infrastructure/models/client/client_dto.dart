class ClientDTO {
  final String id;
  final int? weight;
  final int? height;
  final String? location;
  final String? gender;
  final DateTime? birthDate;
  ClientDTO(
      {required this.id,
      this.weight,
      this.height,
      this.birthDate,
      this.gender,
      this.location});
  factory ClientDTO.fromJson(Map<String, dynamic> json) => ClientDTO(
        id: json["id"] ?? "",
        weight: json["weight"] != null ? int.parse(json["weight"]) : null,
        height: json["height"] != null ? int.parse(json["height"]) : null,
        gender: json["gender"],
        location: json["location"],
        birthDate: json["birthDate"] != null
            ? DateTime.parse(json["birthDate"])
            : null,
      );
}
