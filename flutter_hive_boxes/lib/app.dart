import 'package:flutter/material.dart';
import 'package:flutter_hive_boxes/domain/category_repository.dart';
import 'package:flutter_hive_boxes/screens/categories_screen.dart';

class App extends StatelessWidget {
  final CategoryRepository repository;

  const App({
    super.key,
    required this.repository,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hive boxes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: CategoriesScreen(repository: repository),
    );
  }
}
