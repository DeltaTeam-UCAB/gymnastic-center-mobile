import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymnastic_center/application/comments/bloc/comments_bloc.dart';
import 'package:gymnastic_center/domain/entities/comments/comment.dart';

import '../utils/mock_comments_repository.dart';


void main() {
  late MockCommentsRepository mockCommentsRepository;
  late List<Comment> mockComments;

  setUp(() {
    mockComments = [
      Comment(
        id: '1',
        userId: '1',
        body: 'Message 1',
        likes: 0,
        dislikes: 0,
        creationDate: DateTime.now(),
        userDisliked: false,
        userLiked: false,
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
      Comment(
        id: '3',
        userId: '3',
        body: 'Message 3',
        likes: 0,
        dislikes: 0,
        creationDate: DateTime.now(),
        userDisliked: false,
        userLiked: false,
        username: 'username', 
      ),
      Comment(
        id: '4',
        userId: '4',
        body: 'Message 4',
        likes: 0,
        dislikes: 0,
        creationDate: DateTime.now(),
        userDisliked: false,
        userLiked: false,
        username: 'username', 
      ),
    ];
    mockCommentsRepository = MockCommentsRepository(mockComments, true);
  });

  blocTest(
      'Should emit CommentsState with status error when loadNextPageById is called',
      build: () => CommentsBloc(mockCommentsRepository),
      seed: () => CommentsState(
        status: CommentsStatus.loaded,
        page: 1,
        comments: mockComments.sublist(0,2),
      ),
      act: (bloc) => bloc.loadNextPageById('1', 'BLOG', perPage: 2),
      expect: () => [
        isA<CommentsState>()
          .having((state) => state.status, 'status', CommentsStatus.loading),
        isA<CommentsState>()
          .having((state) => state.status, 'status', CommentsStatus.error)
      ]);
}
