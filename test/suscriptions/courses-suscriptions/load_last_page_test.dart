import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymnastic_center/application/suscriptions/courses-suscriptions/courses_suscriptions_bloc.dart';
import 'package:gymnastic_center/domain/entities/suscription/course_progress.dart';
import 'package:gymnastic_center/domain/repositories/suscription/suscription_repository.dart';

import '../utils/mock_suscription_repository.dart';

void main() {
  late SuscriptionRepository mockSuscriptionRepository;
  late List<CourseProgress> mockCoursesProgress;

  setUp(() {
    mockCoursesProgress = [];
    mockSuscriptionRepository = MockSuscriptionRepository(mockCoursesProgress);
  });

  blocTest(
      'Should emit CoursesSuscriptionsState with isLastPage when loadNextPage is called',
      build: () => CoursesSuscriptionsBloc(mockSuscriptionRepository),
      act: (bloc) => bloc.loadNextPage(perPage: 2),
      expect: () => [
        isA<CoursesSuscriptionsState>()
            .having((state) => state.status, 'status', CoursesSuscriptionsStatus.loading)
            .having((state) => state.isLastPage, 'isLastPage', false)
            .having((state) => state.page, 'page', 0),
        isA<CoursesSuscriptionsState>()
            .having((state) => state.status, 'status', CoursesSuscriptionsStatus.loaded)
            .having((state) => state.isLastPage, 'isLastPage', true)
            .having((state) => state.page, 'page', 1),
      ]);
}
