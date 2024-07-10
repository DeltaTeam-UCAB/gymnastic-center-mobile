import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymnastic_center/application/comments/bloc/comments_bloc.dart';
import 'package:gymnastic_center/domain/entities/comments/comment.dart';

import '../utils/mock_comments_repository.dart';


void main() {
  late MockCommentsRepository mockCommentsRepository;
  late List<Comment> mockComments;

  setUp(() {
    mockComments = [];
    mockCommentsRepository = MockCommentsRepository(mockComments);
  });

  blocTest(
      'Should emit CommentsState with isPosting true and resfresh when createComment is called',
      build: () => CommentsBloc(mockCommentsRepository),
      seed: () => const CommentsState(
        status: CommentsStatus.loaded,
        page: 1,
        comments: []
      ),
      act: (bloc) => bloc.createComment('1', 'BLOG', 'New comment'),
      expect: () => [
        isA<CommentsState>()
          .having((state) => state.isPosting, 'isPosting', true),
        isA<CommentsState>()
          .having((state) => state.status, 'status', CommentsStatus.initialLoading)
          .having((state) => state.page, 'page', 0)
          .having((state) => state.comments, 'comments', [])
          .having((state) => state.isPosting, 'isPosting', false),

      ]);
}
 