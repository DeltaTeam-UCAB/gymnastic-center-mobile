part of 'categories_bloc.dart';

sealed class CategoriesEvent {
  const CategoriesEvent();
}

class CategoriesFetched extends CategoriesEvent {
  final List<Category> categories;
  const CategoriesFetched(this.categories);
}

class CategoriesLoading extends CategoriesEvent {
  const CategoriesLoading();
}

class CategoriesIsEmpty extends CategoriesEvent {
  const CategoriesIsEmpty();
}

class CategoriesError extends CategoriesEvent {
  const CategoriesError();
}

class CurrentCategory extends CategoriesEvent {
  final Category? category;
  const CurrentCategory(this.category);
}
