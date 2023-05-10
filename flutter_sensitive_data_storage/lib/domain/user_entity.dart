
import 'package:flutter_sensitive_data_storage/data/credit_card_storage.dart';
import 'package:flutter_sensitive_data_storage/data/database.dart';
import 'package:flutter_sensitive_data_storage/domain/user.dart';

class UserEntity {
  final String _id;
  final CreditCardStorage _creditCardStorage;
  final AppDatabase _db;
  User _user;

  String get id => _id;
  User get user => _user;

  UserEntity(this._id,this._user, this._db, this._creditCardStorage);

  Future<void> edit(User user, String cardNumber) async {
    _user = user;
    _creditCardStorage.save(id, cardNumber);
    save();
  }

  Future<void> save() async {
    await _db.updateUser(UserPersistenceModel(
      id: id,
      firstName: user.firstName,
      lastName: user.lastName,
      age: user.age,
      avatar: user.avatar,
      phoneNumber: user.phoneNumber,
    ));

    final card = await cardNumber();

    await _creditCardStorage.save(id, card);
  }

  Future<void> delete() async {
    await _db.deleteUserById(id);
    await _creditCardStorage.remove(id);
  }

  Future<String> cardNumber() async {
    return await _creditCardStorage.get(id);
  }
}