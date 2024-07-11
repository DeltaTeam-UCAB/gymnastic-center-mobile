import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymnastic_center/application/categories/bloc/categories_bloc.dart';
import 'package:gymnastic_center/domain/repositories/categories/categories_repository.dart';

import '../utils/mock_categories_repository.dart';

void main() {
  late CategoriesRepository mockCategoriesRepository;

  setUp(() {
    mockCategoriesRepository = MockCategoriesRepository([]);
  });

  blocTest(
    'Should emit CategoriesState with isLoading false and isLastPage true when loadNextPage is called and no categories are found',
    build: () => CategoriesBloc(categoryRepository: mockCategoriesRepository),
    act: (bloc) => bloc.loadNextPage(),
    expect: () => [
      const CategoriesState(categories: [], isLoading: true),
      const CategoriesState(categories: [], isLoading: false, isLastPage: true)
    ],
  );
}
