import 'package:flutter/material.dart';
import 'package:flutter_hive_boxes/domain/category_item.dart';

class CategoryItemScreen extends StatelessWidget {
  final CategoryItem item;

  const CategoryItemScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(item.description),
      ),
    );
  }
}
