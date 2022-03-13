import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:habitica_assistant/models/habitica_auth_data_model.dart';

class SecureStorageService {
  static const _storage = FlutterSecureStorage();
  static const String _kApiToken = 'apiToken';
  static const String _kUserID = 'userID';

  Future<void> setApiToken(String value) async {
    return _storage.write(key: _kApiToken, value: value);
  }

  Future<void> setUserID(String value) async {
    return _storage.write(key: _kUserID, value: value);
  }

  Future<HabiticaAuthDataModel> getAuthData() async {
    final Map<String, String> auth = await _storage.readAll();
    return HabiticaAuthDataModel.fromMap(auth);
  }

  Future<void> setAuthData(HabiticaAuthDataModel authData) async {
    if (authData.apiToken == null || authData.userID == null) {
      throw Exception('Invalid api token');
    }
    final tokenFuture = setApiToken(authData.apiToken!);
    final userFuture = setUserID(authData.userID!);
    Future.wait([tokenFuture, userFuture]);
  }
}
