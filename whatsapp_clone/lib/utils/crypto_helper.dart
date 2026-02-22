import 'package:encrypt/encrypt.dart';
import 'dart:math';

String generate32CharKey() {
  const chars =
      'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  final rand = Random.secure();
  return List.generate(32, (_) => chars[rand.nextInt(chars.length)]).join();
}

class CryptoHelper {
  static final _key = Key.fromUtf8(generate32CharKey()); // 32 chars
  static final _iv = IV.fromLength(16); // 16 bytes IV

  // Encrypt plain text
  static String encrypt(String plainText) {
    final encrypter = Encrypter(AES(_key));
    final encrypted = encrypter.encrypt(plainText, iv: _iv);
    return encrypted.base64; // store this in Firebase
  }

  // // Decrypt encrypted text
  // static String decrypt(String encryptedText) {
  //   final encrypter = Encrypter(AES(_key));
  //   return encrypter.decrypt64(encryptedText, iv: _iv);
  // }

  static String decrypt(String encryptedText) {
    try {
      final encrypter = Encrypter(AES(_key));
      return encrypter.decrypt64(encryptedText, iv: _iv);
    } catch (e) {
      // If decryption fails (e.g. malformed data), return the original text
      // or an error message so the app doesn't crash
      return "[Decryption Error]";
    }
  }
}
