import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureSotrageService {
  final _secureStorage = const FlutterSecureStorage();
  final _userTokenKey = 'userTokenKey';
  final _userIdKey = 'userIdKey';

  String? _userToken;
  String? _userId;

  Future<String?> getUserToken() async {
    _userToken ??= await _secureStorage.read(key: _userTokenKey);

    return _userToken;
  }

  Future<void> setUserToken({required String userToken}) async {
    _userToken = userToken;

    await _secureStorage.write(
      key: _userTokenKey,
      value: userToken,
    );
  }

  Future<String?> getUserId() async {
    _userId ??= await _secureStorage.read(key: _userIdKey);

    return _userId;
  }

  Future<void> setUserId({required String userId}) async {
    _userId = userId;

    await _secureStorage.write(
      key: _userIdKey,
      value: userId,
    );
  }

  Future<void> clearAllData() async {
    _userToken = null;
    _userId = null;
    await _secureStorage.deleteAll();
  }
}
