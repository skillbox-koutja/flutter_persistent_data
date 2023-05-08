import 'package:flutter/material.dart';
import 'package:flutter_hive_boxes/domain/category.dart';
import 'package:flutter_hive_boxes/domain/category_generator.dart';
import 'package:flutter_hive_boxes/domain/category_repository.dart';
import 'package:flutter_hive_boxes/screens/category_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CategoriesScreen extends StatelessWidget {
  final CategoryRepository repository;
  const CategoriesScreen({
    super.key,
    required this.repository,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Категории'),
      ),
      body: ValueListenableBuilder(
        valueListenable: repository.box.listenable(),
        builder: (context, box, widget) {
          debugPrint('box.length ${box.length}');
          if (box.length == 0) {
            return const Center(
              child: Text('Список категорий пуст'),
            );
          }

          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (_, index) {
              final category = box.getAt(index)!;

              return Dismissible(
                key: ValueKey(category.id),
                onDismissed: (_) {
                  repository.remove(category);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    child: Card(
                      child: ListTile(
                        title: Text(category.title),
                        subtitle: Text('Кол-во элементов ${category.items.length}'),
                      ),
                    ),
                    onTap: () {
                      Navigator.push<CategoryScreen>(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategoryScreen(
                            category: category,
                            repository: repository,
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
          final categoriesBox = await Hive.openBox<Category>('categories');
          final gen = CategoryGenerator();
          final category = gen.generate();

          categoriesBox.add(category);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
