import 'package:flutter_sensitive_data_storage/data/credit_card_storage.dart';
import 'package:flutter_sensitive_data_storage/data/database.dart';
import 'package:flutter_sensitive_data_storage/domain/user.dart';
import 'package:flutter_sensitive_data_storage/domain/user_entity.dart';
import 'package:uuid/uuid.dart';

class UserEntityRepository {
  final AppDatabase _db;
  final CreditCardStorage _creditCardStorage;

  const UserEntityRepository(this._db, this._creditCardStorage);

  Stream<List<UserEntity>> users$() {
    return _db.users$().map((users) {
      return users
          .map(
            (pm) => UserEntity(
              pm.id,
              _userFromDb(pm),
              _db,
              _creditCardStorage,
            ),
          )
          .toList();
    });
  }

  String nextId() {
    return (const Uuid()).v4();
  }

  Future<UserEntity> add() async {
    final userEntity = UserEntity(
      nextId(),
      const User(),
      _db,
      _creditCardStorage,
    );

    await userEntity.save();

    return userEntity;
  }

  User _userFromDb(UserPersistenceModel pm) {
    return User(
      firstName: pm.firstName,
      lastName: pm.lastName,
      age: pm.age,
      avatar: pm.avatar,
      phoneNumber: pm.phoneNumber,
    );
  }
}
