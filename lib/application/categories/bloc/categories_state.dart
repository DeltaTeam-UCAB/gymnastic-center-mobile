part of 'categories_bloc.dart';

class CategoriesState extends Equatable {
  final List<Category> categories;
  final Category? currentCategory;
  final bool isLoading;
  final int page;
  final int perPage;
  final bool isLastPage;
  final bool isError;

  const CategoriesState(
      {this.categories = const [],
      this.currentCategory,
      this.isLoading = false,
      this.page = 1,
      this.perPage = 10,
      this.isLastPage = false,
      this.isError = false});

  CategoriesState copyWith({
    List<Category>? categories,
    Category? currentCategory,
    bool? isLoading,
    int? page,
    int? perPage,
    bool? isLastPage,
    bool? isError,
  }) {
    return CategoriesState(
        categories: categories ?? this.categories,
        currentCategory: currentCategory ?? this.currentCategory,
        isLoading: isLoading ?? this.isLoading,
        page: page ?? this.page,
        perPage: perPage ?? this.perPage,
        isLastPage: isLastPage ?? this.isLastPage,
        isError: isError ?? this.isError);
  }

  @override
  List<Object> get props =>
      [categories, isLoading, page, perPage, isLastPage, isError];
}
