import 'package:flutter_hive_boxes/domain/category.dart';
import 'package:flutter_hive_boxes/domain/category_generator.dart';
import 'package:flutter_hive_boxes/domain/category_item.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CategoryRepository {
  final CategoryGenerator _gen;
  final Box<Category> box;
  const CategoryRepository(this._gen, this.box);

  static Future<CategoryRepository> init() async {
    final gen = CategoryGenerator();
    final box = await Hive.openBox<Category>('categories');

    return CategoryRepository(gen, box);
  }

  int count() {
    return box.length;
  }

  void add() {
    final category = _gen.generate();

    box.put(category.id, category);
  }

  void remove(Category category) {
    category.delete();
  }

  void addItem(Category category) {
    final item = _gen.generateItem();
    category.add(item);

    category.save();
  }

  Future<void> removeItem(Category category, CategoryItem item) async {
    category.remove(item);

    category.save();
  }
}
