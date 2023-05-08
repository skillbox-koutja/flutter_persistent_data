import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_images_saver/image_list_widget.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var documentDirectory = await getApplicationDocumentsDirectory();
  var dir = '${documentDirectory.path}/images';
  await Directory(dir).create(recursive: true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Images saver',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const ImageListWidget(),
    );
  }
}
