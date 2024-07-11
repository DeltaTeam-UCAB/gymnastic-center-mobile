import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymnastic_center/application/suscriptions/trending-progress/trending_progress_bloc.dart';
import 'package:gymnastic_center/domain/repositories/suscription/suscription_repository.dart';

import '../utils/mock_suscription_repository.dart';

void main() {
  late SuscriptionRepository mockSuscriptionRepository;

  setUp(() {
    mockSuscriptionRepository = MockSuscriptionRepository([]);
  });

  blocTest(
      'Should emit CourseDetailsState with status error when loadTrendingCourseProgress is called and no courseProgress are found',
      build: () => TrendingProgressBloc(mockSuscriptionRepository),
      act: (bloc) => bloc.loadTrendingCourseProgress(),
      expect: () => [
            isA<TrendingProgressState>()
                .having((state) => state.status, 'status', TrendingProgressStatus.error)
                .having((state) => state.trendingCourseProgress, 'trendingCourseProgress', initialCourseProgress)
          ],
    );
}
