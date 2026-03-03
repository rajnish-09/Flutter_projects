import 'dart:convert';

import 'package:encrypt/encrypt.dart';

class CryptoHelper {
  static final _key = Key.fromUtf8('vG7p9sL4qW8xZ2rT6bH1kM5dC3nQ0aY2');
  static final _iv = IV.fromLength(16);

  // // Encrypt plain text
  // static String encrypt(String plainText) {
  //   final encrypter = Encrypter(AES(_key));
  //   final encrypted = encrypter.encrypt(plainText, iv: _iv);
  //   return encrypted.base64;
  // }

  // static String decrypt(String encryptedText) {
  //   try {
  //     final encrypter = Encrypter(AES(_key));

  //     final result = encrypter.decrypt64(encryptedText, iv: _iv);
  //     return result;
  //   } catch (e) {
  //     return "[Decryption Error]";
  //   }
  // }
  static String encrypt(String plainText) {
    final iv = IV.fromSecureRandom(16);

    final encrypter = Encrypter(AES(_key, mode: AESMode.cbc, padding: 'PKCS7'));

    final encrypted = encrypter.encrypt(plainText, iv: iv);

    // Store IV + ciphertext together
    final combined = iv.bytes + encrypted.bytes;

    return base64Encode(combined);
  }

  static String decrypt(String encryptedText) {
    try {
      final combined = base64Decode(encryptedText);

      final iv = IV(combined.sublist(0, 16));
      final ciphertext = combined.sublist(16);

      final encrypter = Encrypter(
        AES(_key, mode: AESMode.cbc, padding: 'PKCS7'),
      );

      return encrypter.decrypt(Encrypted(ciphertext), iv: iv);
    } catch (e) {
      return "[Decryption Error]";
    }
  }
}