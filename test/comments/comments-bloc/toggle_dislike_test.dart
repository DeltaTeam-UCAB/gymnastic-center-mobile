import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymnastic_center/application/comments/bloc/comments_bloc.dart';
import 'package:gymnastic_center/domain/entities/comments/comment.dart';

import '../utils/mock_comments_repository.dart';


void main() {
  late MockCommentsRepository mockCommentsRepository;
  late List<Comment> mockComments;
  late Comment commentLiked;
  setUp(() {
    mockComments = [
      Comment(
        id: '1',
        userId: '1',
        body: 'Message 1',
        likes: 1,
        dislikes: 0,
        creationDate: DateTime.now(),
        userDisliked: false,
        userLiked: true,
        username: 'username', 
      ),
      Comment(
        id: '2',
        userId: '2',
        body: 'Message 2',
        likes: 0,
        dislikes: 0,
        creationDate: DateTime.now(),
        userDisliked: false,
        userLiked: false,
        username: 'username', 
      ),
      commentLiked = Comment(
        id: '1',
        userId: '1',
        body: 'Message 1',
        likes: 1,
        dislikes: 0,
        creationDate: DateTime.now(),
        userDisliked: false,
        userLiked: true,
        username: 'username', 
      ),
    ];
    mockCommentsRepository = MockCommentsRepository(mockComments);
  });

  blocTest(
      'Should emit CommentsState with increment dislikes number and userDisliked in true when toggleDislike is called',
      build: () => CommentsBloc(mockCommentsRepository),
      seed: () => CommentsState(
        status: CommentsStatus.loaded,
        page: 2,
        comments: mockComments.sublist(0,3),
      ),
      act: (bloc) => bloc.toggleDislike('1', false),
      expect: () => [
        isA<CommentsState>()
          .having((state) => state.comments.firstWhere((element) => element.id == commentLiked.id).userDisliked, 'comments', true)
          .having((state) => state.comments.firstWhere((element) => element.id == commentLiked.id).dislikes, 'comments', 1)
          .having((state) => state.comments.firstWhere((element) => element.id == commentLiked.id).userLiked, 'comments', false)
          .having((state) => state.comments.firstWhere((element) => element.id == commentLiked.id).likes, 'comments', 0)
      ]);
}
 