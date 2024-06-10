class CategoryResponse {
  final String id;
  final String name;
  final String icon;

  CategoryResponse({required this.id, required this.name, required this.icon});

  factory CategoryResponse.fromJson(Map<String, dynamic> json) =>
      CategoryResponse(id: json["id"], name: json["name"], icon: json["icon"]);
}
