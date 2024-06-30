import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gymnastic_center/application/core/bloc/safe_bloc.dart';
import 'package:gymnastic_center/domain/entities/categories/category.dart';
import 'package:gymnastic_center/domain/repositories/categories/categories_repository.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends SafeBloc<CategoriesEvent, CategoriesState> {
  final CategoriesRepository categoryRepository;
  CategoriesBloc({required this.categoryRepository})
      : super(const CategoriesState()) {
    on<CategoriesFetched>(_onCategoriesFetched);
    on<CategoriesLoading>(_onCategoriesLoading);
    on<CategoriesIsEmpty>(_onCategoryIsEmpty);
    on<CategoriesError>(_onCategoryError);
    on<CurrentCategory>(_onCurrentCategory);
  }

  void _onCategoriesFetched(
      CategoriesFetched event, Emitter<CategoriesState> emit) {
    emit(state.copyWith(
        categories: [...state.categories, ...event.categories],
        isLoading: false,
        page: state.page + 1));
  }

  void _onCurrentCategory(
      CurrentCategory event, Emitter<CategoriesState> emit) {
    emit(state.copyWith(currentCategory: event.category, isLoading: false));
  }

  void _onCategoryError(CategoriesError event, Emitter<CategoriesState> emit) {
    emit(state.copyWith(isError: true));
  }

  void _onCategoryIsEmpty(
      CategoriesIsEmpty event, Emitter<CategoriesState> emit) {
    emit(state.copyWith(isLastPage: true));
  }

  void _onCategoriesLoading(
      CategoriesLoading event, Emitter<CategoriesState> emit) {
    emit(state.copyWith(isLoading: true, isError: false));
  }

  Future<void> loadNextPage() async {
    if (state.isLastPage || state.isLoading || state.isError) return;
    add(const CategoriesLoading());

    final categoriesResponse = await categoryRepository.getCategoriesPaginated(
        page: state.page, perPage: state.perPage);
    if (categoriesResponse.isSuccessful()) {
      final categories = categoriesResponse.getValue();
      if (categories.isEmpty) {
        add(const CategoriesIsEmpty());
        return;
      }
      add(CategoriesFetched(categories));
      return;
    }
    add(const CategoriesError());
  }
}
