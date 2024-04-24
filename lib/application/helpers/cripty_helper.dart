import 'dart:convert';

import 'package:crypto/crypto.dart';

sealed class CriptyHelper {
  static String generateSha256Hash(String password) {
    final bytes = utf8.encode(password);
    return sha256.convert(bytes).toString();
  }
}
