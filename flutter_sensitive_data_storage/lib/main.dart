import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_sensitive_data_storage/data/credit_card_storage.dart';
import 'package:flutter_sensitive_data_storage/data/database.dart';
import 'package:flutter_sensitive_data_storage/domain/user_entity_repository.dart';
import 'package:flutter_sensitive_data_storage/presentation/screens/home_screen.dart';

void main() {
  const storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock,
    ),
  );
  final db = AppDatabase();

  runApp(MyApp(
    storage: storage,
    db: db,
  ));
}

class MyApp extends StatelessWidget {
  final FlutterSecureStorage storage;
  final AppDatabase db;

  const MyApp({
    super.key,
    required this.db,
    required this.storage,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sensitive data storage',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: HomeScreen(
        userEntityRepository: UserEntityRepository(
          db,
          CreditCardStorage(storage),
        ),
      ),
    );
  }
}
