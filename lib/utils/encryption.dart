import 'package:encrypt/encrypt.dart' as en;
import 'global.dart';

final key = en.Key.fromUtf8('n2aHQ+q7whNMugXLPopZnWsqAx1gc5qp');
final iv = en.IV.fromUtf8('jhuWhuGspfeGeFjX');

String? aesEncrypt(String data) {
  try {
    final encryption = en.Encrypter(en.AES(key, mode: en.AESMode.cbc));
    final encrypted = encryption.encrypt(data, iv: iv);
    return encrypted.base64;
  } catch (e) {
      kPrintLog(e);
  }
  return null;
}

String? aesDecrypt(String? data) {
  if(data == null) return null;
  try {
    final encryption = en.Encrypter(en.AES(key, mode: en.AESMode.cbc));
    final decrypted = encryption.decrypt64(data, iv: iv);
    return decrypted;
  } catch (e) {
      kPrintLog(e);
  }
  return null;
}
