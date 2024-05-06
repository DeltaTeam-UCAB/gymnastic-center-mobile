class Comment {
    final String id;
    final String clientId;
    final String description;
    final DateTime creationDate;
    final int likes;
    final int dislikes;
    final bool userLiked;

    Comment({
        required this.id,
        required this.clientId,
        required this.description,
        required this.creationDate,
        required this.likes,
        required this.dislikes,
        required this.userLiked,
    });

}