import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/comments/bloc/comments_bloc.dart';
import 'package:gymnastic_center/domain/entities/comments/comment.dart';

class CommentsList extends StatefulWidget {
  final List<Comment> comments;
  const CommentsList(this.comments);

  @override
  State<CommentsList> createState() => CommentsListState();
}

class CommentsListState extends State<CommentsList> {
  CommentsListState();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels + 500 >=
          _scrollController.position.maxScrollExtent) {
        // context.read<CommentsBloc>().loadNextPageByPostId(widget.postId);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: widget.comments.length,
        itemBuilder: (context, index) {
          final comment = widget.comments[index];
          return _CommentTile(comment: comment);
        },
      ),
    );
  }
}

class _CommentTile extends StatelessWidget {
  final Comment comment;
  const _CommentTile({
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final color = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              comment.username,
              style: TextStyle(
                  fontSize: textTheme.titleMedium!.fontSize,
                  color: color.primary),
            ),
            Text(
              comment.description,
              style: TextStyle(
                  fontSize: textTheme.bodyLarge!.fontSize,
                  fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    if (!comment.userLiked) {
                      context
                          .read<CommentsBloc>()
                          .likeComment(comment.id, comment.userLiked);
                      return;
                    }
                    context
                        .read<CommentsBloc>()
                        .deleteLike(comment.id, comment.userLiked);
                  },
                  icon: (!comment.userLiked)
                      ? const Icon(Icons.thumb_up_outlined)
                      : Icon(
                          Icons.thumb_up,
                          color: color.primary,
                        ),
                  iconSize: 16,
                ),
                Text('${comment.likes}', style: textTheme.labelMedium),
              ],
            ),
            const SizedBox(
              height: 8,
            )
          ],
        ),
      ),
    );
  }
}
