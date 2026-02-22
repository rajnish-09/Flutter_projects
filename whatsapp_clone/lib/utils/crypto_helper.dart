import 'package:encrypt/encrypt.dart';
import 'dart:math';

String generate32CharKey() {
  const chars =
      'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  final rand = Random.secure();
  return List.generate(32, (_) => chars[rand.nextInt(chars.length)]).join();
}

class CryptoHelper {
  static final _key = Key.fromUtf8('vG7p9sL4qW8xZ2rT6bH1kM5dC3nQ0aY2');
  static final _iv = IV.fromLength(16);

  // Encrypt plain text
  static String encrypt(String plainText) {
    final encrypter = Encrypter(AES(_key));
    final encrypted = encrypter.encrypt(plainText, iv: _iv);
    return encrypted.base64;
  }

  static String decrypt(String encryptedText) {
    try {
      final encrypter = Encrypter(AES(_key));
      return encrypter.decrypt64(encryptedText, iv: _iv);
    } catch (e) {
      return "[Decryption Error]";
    }
  }
}
