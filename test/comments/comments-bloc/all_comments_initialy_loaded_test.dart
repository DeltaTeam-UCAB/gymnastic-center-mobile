import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymnastic_center/application/comments/bloc/comments_bloc.dart';

import '../utils/mock_comments_repository.dart';


void main() {
  late MockCommentsRepository mockCommentsRepository;

  setUp(() {
    
    mockCommentsRepository = MockCommentsRepository([]);
  });

  blocTest(
      'Should emit CommentsState with status allCOmmentsCompleted, loaded and increment actual page  when startInitialLoad is called',
      build: () => CommentsBloc(mockCommentsRepository),
      act: (bloc) => bloc.startInitialLoad('1', 'BLOG'),
      expect: () => [
        isA<CommentsState>()
          .having((state) => state.status, 'status', CommentsStatus.initialLoading)
          .having((state) => state.page, 'page', 0)
          .having((state) => state.comments, 'commets', []),
        isA<CommentsState>()
          .having((state) => state.status, 'status', CommentsStatus.allCommentsLoaded)
          .having((state) => state.page, 'page', 0)
          .having((state) => state.comments, 'commets', [])
      ]);
}
