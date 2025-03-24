
import 'package:encrypt/encrypt.dart' as encrypt;

class AES {
  // final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();
  // static String SESSIONTOKEN = "15b97917-b296-11ed-997a-b42e9923";
  static String encryptWithAES(String key, String plainText) {
    final cipherKey = encrypt.Key.fromUtf8(key);
    final encrypter = encrypt.Encrypter(encrypt.AES(cipherKey, mode: encrypt.AESMode.cbc));
    final iv = encrypt.IV.fromUtf8(key.substring(0, 16)); // Use an IV with the correct length
    final encrypted = encrypter.encrypt(plainText, iv: iv);
    final encryptedBase64 = encrypted.base64;
    return encryptedBase64;
  }

  static String decryptWithAES(String key, String encryptedData) {
    final cipherKey = encrypt.Key.fromUtf8(key);
    final encrypter = encrypt.Encrypter(encrypt.AES(cipherKey, mode: encrypt.AESMode.cbc));
    final iv = encrypt.IV.fromUtf8(key.substring(0, 16)); // Use an IV with the correct length

    final encrypted = encrypt.Encrypted.fromBase64(encryptedData);
    return encrypter.decrypt(encrypted, iv: iv);
  }
}