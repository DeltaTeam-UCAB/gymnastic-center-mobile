class UserAPI {
  final String id;
  final String email;
  final String name;
  final String type;
  UserAPI(
      {required this.id,
      required this.email,
      required this.name,
      required this.type});
  factory UserAPI.fromJson(Map<String, dynamic> json) => UserAPI(
        id: json["id"],
        email: json["email"],
        name: json["name"],
        type: json["type"],
      );
}
