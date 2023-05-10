import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CreditCardStorage {
  final FlutterSecureStorage _storage;

  const CreditCardStorage(this._storage);

  String _getUserCardKey(String id) => 'creditCard/$id';

  Future<void> save(String id, String card) async {
    await _storage.write(key: _getUserCardKey(id), value: card);
  }

  Future<String> get(String id) async {
    final cardNumber = await _storage.read(key: _getUserCardKey(id));

    return cardNumber ?? '';
  }

  Future<void> remove(String id) async {
    await _storage.delete(key: _getUserCardKey(id));
  }
}
