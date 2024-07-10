class LoginAPIResponse {
  final String token;
  final String type;
  LoginAPIResponse({required this.token, required this.type});
  factory LoginAPIResponse.fromJson(Map<String, dynamic> json) =>
      LoginAPIResponse(
        token: json["token"],
        type: json["type"] ?? 'CLIENT',
      );
}
