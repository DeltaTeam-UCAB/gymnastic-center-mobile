class CommentApiResponse {
    final String id;
    final String user;
    final String userId;
    final int countLikes;
    final int countDislikes;
    final String body;
    final bool userLiked;
    final bool userDisliked;
    final DateTime date;


    CommentApiResponse({
        required this.id,
        required this.user,
        required this.userId,
        required this.countLikes,
        required this.countDislikes,
        required this.body,
        required this.userLiked,
        required this.userDisliked,
        required this.date
    });

    factory CommentApiResponse.fromJson(Map<String, dynamic> json) => CommentApiResponse(
        id: json["id"],
        user: json["user"],
        userId: json["userId"] ?? '',
        countLikes: json["countLikes"],
        countDislikes: json["countDislikes"],
        body: json["body"],
        userLiked: json["userLiked"],
        userDisliked: json["userDisliked"],
        date: DateTime.parse(json["date"]),
    );
}
