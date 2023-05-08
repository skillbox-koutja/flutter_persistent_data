import 'package:flutter/material.dart';
import 'package:flutter_hive_boxes/domain/category.dart';
import 'package:flutter_hive_boxes/domain/category_repository.dart';
import 'package:flutter_hive_boxes/screens/category_item_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CategoryScreen extends StatelessWidget {
  final CategoryRepository repository;
  final Category category;

  const CategoryScreen({
    super.key,
    required this.repository,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Категория: ${category.title}'),
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<Category>('categories').listenable(),
        builder: (context, box, widget) {
          if (category.items.isEmpty) {
            return const Center(
              child: Text('Список элементов пуст'),
            );
          }

          return ListView.builder(
            itemCount: category.items.length,
            itemBuilder: (_, index) {
              final item = category.items[index];

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Dismissible(
                  key: UniqueKey(),
                  onDismissed: (_) {
                    repository.removeItem(category, item);
                  },
                  child: InkWell(
                    child: Card(
                      child: ListTile(
                        title: Text(item.title),
                      ),
                    ),
                    onTap: () {
                      Navigator.push<CategoryScreen>(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategoryItemScreen(
                            item: item,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          repository.addItem(category);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
