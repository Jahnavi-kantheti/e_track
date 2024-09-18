import 'package:e_track/utils/encryption.dart';
import 'package:get_storage/get_storage.dart';

class StorageBox {
  StorageBox._singleton();

  static final StorageBox instance = StorageBox._singleton();

  final _box = GetStorage();

  setFullName(String? value) async {
    await _box.write("FullName", value);
  }

  String getFullName() {
    return _box.read("FullName") ?? '';
  }

  setUsername(String value) async {
    await _box.write("Username", aesEncrypt(value));
  }

  String getUsername() {
    return aesDecrypt(_box.read("Username")) ?? '';
  }

  setPassword(String value) async {
    await _box.write("Password", value);
  }

  String getPassword() {
    return _box.read("Password") ?? '';
  }

  setIsAdmin(bool value) async {
    await _box.write("IsAdmin", value);
  }

  bool isAdmin() {
    return _box.read("IsAdmin") ?? false;
  }

  setDeviceID(String? value) async {
    await _box.write("DEVICE_ID", value);
  }

  String getDeviceID() {
    return _box.read("DEVICE_ID") ?? '';
  }

  setBackgroundFetchEnable(bool value) async {
    await _box.write("IsFetching", value);
  }

  bool getBackgroundFetchEnabled() {
    return _box.read("IsFetching") ?? false;
  }

  setProfilePic(String? value) async {
    await _box.write("ProfilePic", value);
  }

  String? getProfilePic() {
    return _box.read("ProfilePic");
  }

  setUserId(String? value) async {
    await _box.write("UserId", value);
  }

  String? getUserId() {
    return _box.read("UserId");
  }

  clear() async {
    await _box.erase();
  }
}
