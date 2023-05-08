import 'package:flutter_hive_boxes/domain/category.dart';
import 'package:flutter_hive_boxes/domain/category_item.dart';
import 'package:faker/faker.dart';

final faker = Faker(seed: 168347);

class CategoryGenerator {
  Category generate() {
    final titleWords = faker.randomGenerator.integer(2, min: 1);

    return Category(
      faker.guid.guid(),
      faker.lorem.words(titleWords).join(),
      _generateItems(),
    );
  }

  CategoryItem generateItem() {
    final titleWords = faker.randomGenerator.integer(2, min: 1);
    final descriptionWords = faker.randomGenerator.integer(40);

    return CategoryItem(
      title: faker.lorem.words(titleWords).join(),
      description: faker.lorem.sentences(descriptionWords).join(''),
    );
  }

  List<CategoryItem> _generateItems() {
    final items = faker.randomGenerator.integer(3);

    return List<CategoryItem>.generate(
      items,
      (_) => generateItem(),
    );
  }
}
