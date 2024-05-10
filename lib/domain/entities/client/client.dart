class Client {
  final String id;
  final int? weight;
  final int? height;
  final String? location;
  final String? gender;
  final DateTime? birthDate;
  Client(
      {required this.id,
      this.weight,
      this.height,
      this.birthDate,
      this.gender,
      this.location});
}
