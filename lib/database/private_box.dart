part of 'database.dart';

class PrivateBox<T> {
  PrivateBox(boxName) : box = Hive.box<T>(boxName);

  final Box<T> box;

  Future<void> put(String key, T value) async {
    await box.put(key, value);
  }

  Future<T?> get(String key) async {
    return box.get(key);
  }

  Future delete(String key) async{
    await box.delete(key);
  }
}