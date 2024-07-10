import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymnastic_center/application/categories/bloc/categories_bloc.dart';
import 'package:gymnastic_center/domain/repositories/categories/categories_repository.dart';
import '../utils/mock_categories_repository.dart';

void main() {
  late CategoriesRepository mockCategoriesRepository;

  setUp(() {
    mockCategoriesRepository = MockCategoriesRepository([], true);
  });

  blocTest(
    'Should emit CategoriesState with isLoading true and isError true when loadNextPage is called and an error occurs',
    build: () => CategoriesBloc(categoryRepository: mockCategoriesRepository),
    act: (bloc) => bloc.loadNextPage(),
    expect: () => [
      const CategoriesState(categories: [], isLoading: true),
      const CategoriesState(categories: [], isLoading: false, isError: true)
    ],
  );
}
