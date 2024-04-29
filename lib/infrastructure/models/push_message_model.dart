class PushMessageModel {
  final String messageId;
  final String title;
  final String body;
  final DateTime sentDate;
  final Map<String, dynamic>? data;
  final String? imageUrl;

  PushMessageModel({
    required this.messageId,
    required this.title,
    required this.body,
    required this.sentDate,
    this.data,
    this.imageUrl
  });

  @override
  String toString() {
    return '''
pushMessage - 
  id: $messageId
  title: $title
  body: $body
  sentDate: $sentDate
  data: $data
  imageUrl: $imageUrl
    ''';
  }
  
}