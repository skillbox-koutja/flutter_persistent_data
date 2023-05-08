import 'package:flutter/material.dart';
import 'package:flutter_hive_boxes/app.dart';
import 'package:flutter_hive_boxes/domain/category.dart';
import 'package:flutter_hive_boxes/domain/category_repository.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(CategoryAdapter());

  final repository = await CategoryRepository.init();

  runApp(App(repository: repository));
}
