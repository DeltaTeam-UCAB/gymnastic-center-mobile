import 'package:gymnastic_center/domain/entities/categories/category.dart';
import 'package:gymnastic_center/infrastructure/models/categories/category_response.dart';

class CategoryMapper {
  static Category categoryToEntity(CategoryResponse json) {
    return Category(id: json.id, name: json.name, icon: json.icon);
  }
}
