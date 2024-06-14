import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/comments/bloc/comments_bloc.dart';
import 'package:gymnastic_center/domain/entities/comments/comment.dart';

class CommentsSection extends StatelessWidget {
  final String? lessonId;
  final String? blogId;

  const CommentsSection({super.key, this.lessonId, this.blogId})
      : assert(lessonId != null || blogId != null,
            'blogId and lessonId not must be provided at the same time');

  @override
  Widget build(BuildContext context) {

    return BlocSelector<CommentsBloc, CommentsState, bool>(
      selector: (state) => state.isPosting,
      builder: (context, state) {
        if (lessonId != null){
          context.read<CommentsBloc>().loadNextPageByLessonId(lessonId!);
        }
        if (blogId != null){
          context.read<CommentsBloc>().loadNextPageByBlogId(blogId!);
        }
        return _CommentsSection(
          blogId: blogId,
          lessonId: lessonId,
        );
      },
    );
  }
}

class _CommentsSection extends StatelessWidget {
  final String? lessonId;
  final String? blogId;

  const _CommentsSection({this.lessonId, this.blogId});
  @override
  Widget build(BuildContext context) {
    late void Function() onLoadNextComments;
    late void Function(String message) onPostComment;

    return BlocBuilder<CommentsBloc, CommentsState>(
      builder: (context, state) {
        if (lessonId != null) {
          onLoadNextComments = () =>
              context.read<CommentsBloc>().loadNextPageByLessonId(lessonId!);
          onPostComment = (message) => context.read<CommentsBloc>().createCommentByLessonId(lessonId!, message);
        }

        if (blogId != null) {
          onLoadNextComments =
              () => context.read<CommentsBloc>().loadNextPageByBlogId(blogId!);
          onPostComment = (message) => context.read<CommentsBloc>().createCommentByBlogId(blogId!, message);
        }

        if (state.status == CommentsStatus.loading && state.comments.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state.status == CommentsStatus.error) {
          return const Center(
            child: Text('Error has occured'),
          );
        }

        return SafeArea(
          child: Column(children: [
            _CommentsList(
              state.comments,
              onLoadNextComments: onLoadNextComments,
            ),
            if (state.status == CommentsStatus.loading)
              const SizedBox(
                height: 100,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            _CommentInput(onPostSuccess: () {
              context.read<CommentsBloc>().reset();
            }, onValue: onPostComment),
          ]),
        );
      },
    );
  }
}

class _CommentsList extends StatefulWidget {
  final List<Comment> comments;
  final void Function() onLoadNextComments;
  const _CommentsList(this.comments, {required this.onLoadNextComments});
  @override
  State<_CommentsList> createState() => _CommentsListState();
}

class _CommentsListState extends State<_CommentsList> {
  _CommentsListState();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.offset ==
          _scrollController.position.maxScrollExtent) {
        widget.onLoadNextComments();
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
    return Expanded(
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
    final dateFormat = DateFormat('dd-MM-yyyy');
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  comment.username,
                  style: TextStyle(
                      fontSize: textTheme.titleMedium!.fontSize,
                      color: color.primary),
                ),
                const Spacer(),
                Text(
                  dateFormat.format(comment.creationDate),
                  style: TextStyle(
                      fontSize: textTheme.titleSmall!.fontSize,
                      color: color.primary),
                ),
              ],
            ),
            Text(
              comment.body,
              style: TextStyle(
                  fontSize: textTheme.bodyLarge!.fontSize,
                  fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => context.read<CommentsBloc>().toggleLike(comment.id),
                  icon: (!comment.userLiked)
                      ? const Icon(Icons.thumb_up_outlined)
                      : Icon(
                          Icons.thumb_up,
                          color: color.primary,
                        ),
                  iconSize: 16,
                ),
                Text('${comment.likes}', style: textTheme.labelMedium),
                IconButton(
                  onPressed: () => context.read<CommentsBloc>().toggleDislike(comment.id),
                  icon: (!comment.userDisliked)
                      ? const Icon(Icons.thumb_down_outlined)
                      : Icon(
                          Icons.thumb_down,
                          color: color.primary,
                        ),
                  iconSize: 16,
                ),
                Text('${comment.dislikes}', style: textTheme.labelMedium),
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

class _CommentInput extends StatelessWidget {
  final ValueChanged<String> onValue;
  final void Function() onPostSuccess;
  const _CommentInput({required this.onValue, required this.onPostSuccess});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CommentsBloc, CommentsState>(
      listenWhen: (previous, current) =>
          previous.isPosting != current.isPosting,
      listener: (context, state) {
        if (!state.isPosting && state.status != CommentsStatus.error) {
          onPostSuccess();
          return ;
          
        }
        if (state.isPosting && state.status == CommentsStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('something gone wrong')));
          return;
        }
      },
      buildWhen: (previous, current) => previous.isPosting != current.isPosting,
      builder: (context, state) {
        final textController = TextEditingController();
        final focusNode = FocusNode();
        final colors = Theme.of(context).colorScheme;

        final outlineInputBorder = UnderlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(20));

        final inputDecoration = InputDecoration(
            hintText: 'Write a comment...',
            enabledBorder: outlineInputBorder,
            focusedBorder: outlineInputBorder,
            filled: true,
            suffixIcon:IconButton(
                    icon: const Icon(Icons.send_outlined),
                    color: colors.primary,
                    onPressed: () {
                      final value = textController.value.text;
                      onValue(value);
                      textController.clear();
                      focusNode.unfocus();  
                    },
                  ));
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
                onTapOutside: (event) {
                  focusNode.unfocus();
                },
                focusNode: focusNode,
                controller: textController,
                decoration: inputDecoration,
                onFieldSubmitted: (value) {
                  textController.clear();
                  onValue(value);
                  focusNode.requestFocus();
                },
              ),
        );
      },
    );
  }
}
