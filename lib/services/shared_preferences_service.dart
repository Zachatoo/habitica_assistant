import 'package:habitica_assistant/models/habitica_auth_data_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  final String _kApiToken = 'apiToken';
  final String _kUserID = 'userID';

  Future<String?> getApiToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kApiToken);
  }

  Future<bool> setApiToken(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_kApiToken, value);
  }

  Future<String?> getUserID() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kUserID);
  }

  Future<bool> setUserID(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_kUserID, value);
  }

  Future<HabiticaAuthDataModel> getAuthData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final apiToken = prefs.getString(_kApiToken);
    final userID = prefs.getString(_kUserID);
    return HabiticaAuthDataModel(apiToken: apiToken!, userID: userID!);
  }

  Future<bool> setAuthData(HabiticaAuthDataModel authData) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_kApiToken, authData.apiToken);
    return prefs.setString(_kUserID, authData.userID);
  }
}
