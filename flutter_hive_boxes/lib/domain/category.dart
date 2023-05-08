import 'package:flutter_hive_boxes/domain/category_item.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Category extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  List<CategoryItem> items;

  Category(this.id, this.title, this.items);

  factory Category.create(String id, String title) {
    return Category(id, title, []);
  }

  void add(CategoryItem item) {
    items.add(item);
  }

  void remove(CategoryItem item) {
    items.remove(item);
  }
}

class CategoryAdapter extends TypeAdapter<Category> {
  @override
  final typeId = 0;

  @override
  Category read(BinaryReader reader) {
    final id = reader.readString();
    final title = reader.readString();
    var category = Category.create(id, title);
    var len = reader.readUint32();
    for (var i = 0; i < len; i++) {
      category.add(CategoryItem(
        title: reader.readString(),
        description: reader.readString(),
      ));
    }
    return category;
  }

  @override
  void write(BinaryWriter writer, Category obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.title);
    writer.writeUint32(obj.items.length);
    for (var item in obj.items) {
      writer.writeString(item.title);
      writer.writeString(item.description);
    }
  }
}
