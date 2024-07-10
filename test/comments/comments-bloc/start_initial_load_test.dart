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
    ];
    mockCommentsRepository = MockCommentsRepository(mockComments);
  });

  blocTest(
      'Should emit CommentsState with status initial, loaded and increment actual page  when startInitialLoad is called',
      build: () => CommentsBloc(mockCommentsRepository),
      act: (bloc) => bloc.startInitialLoad('1', 'BLOG', perPage: 3),
      expect: () => [
        isA<CommentsState>()
          .having((state) => state.status, 'status', CommentsStatus.initialLoading)
          .having((state) => state.page, 'page', 0)
          .having((state) => state.comments, 'commets', []),
        isA<CommentsState>()
          .having((state) => state.status, 'status', CommentsStatus.loaded)
          .having((state) => state.page, 'page', 1)
          .having((state) => state.comments, 'commets', mockComments)
      ]);
}
