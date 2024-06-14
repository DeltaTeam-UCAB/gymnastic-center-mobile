class ClientAPI {
  final String id;
  final String name;
  final String phone;
  final String email;
  final String? avatarImage;

  ClientAPI(
      {required this.id,
      required this.name,
      required this.phone,
      required this.email,
      this.avatarImage});

  factory ClientAPI.fromJson(Map<String, dynamic> json) => ClientAPI(
      id: json["id"],
      email: json["email"],
      name: json["name"],
      phone: json["phone"],
      avatarImage: json["image"]);
}
