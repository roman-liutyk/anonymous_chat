import 'dart:convert';

import 'package:crypto/crypto.dart';

/// Extension for `encrypting` [String] using `crypto` package.
extension Encrypt on String {
  /// Getter that encodes [String] to list of bytes and uses `crypto` package
  /// for converting these bytes to `hash`.
  ///
  /// As a result, returns hash as a [String] type.
  String get encrypt {
    final bytes = utf8.encode(this);
    final hash = sha256.convert(bytes);

    return hash.toString();
  }
}
