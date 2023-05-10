import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

@DataClassName('UserPersistenceModel')
class Users extends Table {
  TextColumn get id => text()();
  TextColumn get firstName => text()();
  TextColumn get lastName => text()();
  IntColumn get age => integer()();
  TextColumn get avatar => text()();
  TextColumn get phoneNumber => text()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [Users])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<UserPersistenceModel>> getAllUsers() => select(users).get();

  Stream<List<UserPersistenceModel>> users$() => select(users).watch();

  Future<int> updateUser(user) => into(users).insertOnConflictUpdate(user);

  Future<List<UserPersistenceModel>> getUserById(String id) =>
      (select(users)..where((u) => u.id.equals(id))).get();

  Future<int> deleteUserById(String id) =>
      (delete(users)..where((u) => u.id.equals(id))).go();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
