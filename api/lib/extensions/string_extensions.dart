import 'dart:convert';

import 'package:crypto/crypto.dart';

extension Encrypt on String {
  String get encrypt {
    final bytes = utf8.encode(this);
    final hash = sha256.convert(bytes);

    return hash.toString();
  }
}
