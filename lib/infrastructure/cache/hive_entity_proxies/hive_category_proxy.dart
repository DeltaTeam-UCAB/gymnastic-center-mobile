import 'package:gymnastic_center/domain/entities/categories/category.dart';
import 'package:gymnastic_center/infrastructure/cache/hive_entity_proxies/core/hive_entity_proxy.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'hive_category_proxy.g.dart';

@HiveType(typeId: 1)
class HiveCategory extends HiveEntityProxy<Category> {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String icon;

  HiveCategory({required this.id, required this.name, required this.icon});

  @override
  factory HiveCategory.fromProxiedType(Category data) {
    return HiveCategory(id: data.id, name: data.name, icon: data.icon);
  }

  @override
  Category toProxiedType() {
    return Category(id: id, name: name, icon: icon);
  }
}
