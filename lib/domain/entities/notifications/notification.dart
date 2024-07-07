class Notification {
  final String id;
  final String title;
  final String body;
  final DateTime date;
  final bool read;

  Notification(
      {required this.id,
      required this.title,
      required this.body,
      required this.date,
      required this.read});
}
