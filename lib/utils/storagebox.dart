import 'package:get_storage/get_storage.dart';

class StorageBox {
  StorageBox._singleton();

  static final StorageBox instance = StorageBox._singleton();

  final _box = GetStorage();

  setToken(String value) {
    _box.write("TOKEN", value);
  }

  String getToken() {
    return _box.read("TOKEN") ?? '';
  }

  setUserName(String value) {
    _box.write("USERNAME", value);
  }

  String getUserName() {
    return _box.read("USERNAME") ?? '';
  }

  setIsAdmin(bool value) {
    _box.write("IsAdmin", value);
  }

  bool isAdmin() {
    return _box.read("IsAdmin") ?? false;
  }

  clear() async {
    await _box.erase();
  }

/*setFetchLocation(bool value) {
    _box.write("FETCH_LOCATION", value);
  }

  bool getFetchLocation() {
    return _box.read("FETCH_LOCATION") ?? false;
  }*/
}
