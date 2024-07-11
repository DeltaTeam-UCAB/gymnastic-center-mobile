import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/clients/bloc/clients_bloc.dart';
import 'package:gymnastic_center/application/comments/bloc/comments_bloc.dart';
import 'package:gymnastic_center/domain/entities/comments/comment.dart';
import 'package:gymnastic_center/presentation/widgets/shared/delete_popup_menu.dart';
import 'package:timeago/timeago.dart';

class CommentsSection extends StatelessWidget {

  final void Function() onLoadNextComments;
  final void Function() onInitialLoadComments;
  final void Function(String message) onPostComment;

  const CommentsSection({
    super.key, 
    required this.onLoadNextComments, 
    required this.onPostComment, 
    required this.onInitialLoadComments,
  });

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<CommentsBloc, CommentsState>(
      buildWhen: (previous, current) => previous.isPosting && !current.isPosting,
      builder: (context, state) {
        onInitialLoadComments();
        return _CommentsSection(
          onLoadNextComments: onLoadNextComments,
          onPostComment: onPostComment,
        );
      },
    );
  }
}

class _CommentsSection extends StatelessWidget {
  final void Function() onLoadNextComments;
  final void Function(String message) onPostComment;
  const _CommentsSection({required this.onLoadNextComments, required this.onPostComment});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentsBloc, CommentsState>(
      buildWhen: (previous, current) => previous.status != current.status || previous.comments != current.comments,
      builder: (context, state) {

        if (state.status == CommentsStatus.initialLoading) {
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
    final client = context.read<ClientsBloc>().state.client;
    final emptyCommentTextStyle = Theme.of(context).textTheme.titleMedium;
    final showEmptyMessage = 
      context.read<CommentsBloc>().state.status == CommentsStatus.allCommentsLoaded
      && context.read<CommentsBloc>().state.comments.isEmpty;  
    if ( showEmptyMessage ){
      return Expanded(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(bottom:64),
                child: Image.asset(
                  'assets/icon/comments_empty.png',
                  fit: BoxFit.cover,
                  height: 160,
                  width: 160,
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 160),
                child:  Text(
                  'Be the first person to comment! ✍️ ',
                  style: emptyCommentTextStyle,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      );
    }
    
    return Expanded(
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: widget.comments.length,
        itemBuilder: (context, index) {
          final comment = widget.comments[index];
          return _CommentTile(
            comment: comment,
            owned: client.id == comment.userId,
          );
        },
      ),
    );
  }
}

class _CommentTile extends StatelessWidget {
  final Comment comment;
  final bool owned;
  const _CommentTile({
    required this.comment,
    required this.owned,
  });

  String _calculateTimeAgo(DateTime creationDate){
    return format(creationDate, locale: 'en_short').replaceFirst('about', '');
  }

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
                  _calculateTimeAgo(comment.creationDate),
                  style: TextStyle(
                      fontSize: textTheme.titleSmall!.fontSize,
                      color: color.primary),
                ),
                if (owned)
                DeletePopupMenu(onPressed: 
                () => context.read<CommentsBloc>().deleteComment(comment.id),
                color: Colors.white,
                dialogTitle: 'Do you want to delete your comment?',
                dialogBody: 'It will be erased forever',
                dialogAccept: 'Yes, please',
                dialogDeny: 'No',
                popuplabel: 'Remove comment')
                else
                const SizedBox(width: 44,)
              ],
            ),
            Text(
              comment.body,
              style: TextStyle(
                  fontSize: textTheme.bodyLarge!.fontSize,
                  fontWeight: FontWeight.bold),
            ),
            if (comment.userId != '')
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => context.read<CommentsBloc>().toggleLike(comment.id, comment.userLiked),
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
                  onPressed: () => context.read<CommentsBloc>().toggleDislike(comment.id, comment.userDisliked),
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
