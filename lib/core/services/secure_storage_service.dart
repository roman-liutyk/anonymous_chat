import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureSotrageService {
  final _secureStorage = const FlutterSecureStorage();
  final _userTokenKey = 'userTokenKey';
  final _userIdKey = 'userIdKey';

  Future<String?> getUserToken() async {
    return _secureStorage.read(key: _userTokenKey);
  }

  Future<void> setUserToken({required String userToken}) async {
    await _secureStorage.write(
      key: _userTokenKey,
      value: userToken,
    );
  }

  Future<String?> getUserId() async {
    return _secureStorage.read(key: _userIdKey);
  }

  Future<void> setUserId({required String userId}) async {
    await _secureStorage.write(
      key: _userIdKey,
      value: userId,
    );
  }

  Future<void> clearAllData() async {
    await _secureStorage.deleteAll();
  }
}
