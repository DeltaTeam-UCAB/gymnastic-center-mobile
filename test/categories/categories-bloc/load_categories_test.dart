import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymnastic_center/application/categories/bloc/categories_bloc.dart';
import 'package:gymnastic_center/domain/entities/categories/category.dart';
import 'package:gymnastic_center/domain/repositories/categories/categories_repository.dart';

import '../utils/mock_categories_repository.dart';

void main() {
  late CategoriesRepository mockCategoriesRepository;
  late Category categoryMock;

  setUp(() {
    categoryMock = Category(id: '1', name: 'Category 1', icon: ' 1');
    mockCategoriesRepository = MockCategoriesRepository([categoryMock]);
  });

  blocTest(
    'Should emit NotificationListState with isLoading true and notifications [notification] when loadNextPage is called',
    build: () => CategoriesBloc(categoryRepository: mockCategoriesRepository),
    act: (bloc) => bloc.loadNextPage(),
    expect: () => [
      const CategoriesState(categories: [], isLoading: true),
      CategoriesState(categories: [categoryMock], isLoading: false, page: 2),
    ],
  );
}
