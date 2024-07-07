class NotificationResponse {
  final String id;
  final String title;
  final String body;
  final String date;
  final bool read;

  NotificationResponse(
      {required this.id,
      required this.title,
      required this.body,
      required this.date,
      required this.read});

  factory NotificationResponse.fromJson(Map<String, dynamic> json) =>
      NotificationResponse(
          id: json["id"],
          title: json["title"],
          body: json["body"],
          date: json["date"],
          read: json["readed"] ?? true);
}
