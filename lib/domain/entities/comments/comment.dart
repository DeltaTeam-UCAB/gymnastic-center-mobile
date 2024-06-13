class Comment {
    final String id;
    final String username;
    final String body;
    final DateTime creationDate;
    final int likes;
    final int dislikes;
    final bool userLiked;
    final bool userDisliked;

    Comment({
        required this.id,
        required this.username,
        required this.body,
        required this.creationDate,
        required this.likes,
        required this.dislikes,
        required this.userLiked,
        required this.userDisliked,
    });

}