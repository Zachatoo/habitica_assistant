import 'dart:convert';

import 'package:habitica_assistant/models/gear_model.dart';
import 'package:habitica_assistant/services/shared_preferences_service.dart';
import 'package:http/http.dart' as http;

class HabiticaService {
  final SharedPreferencesService _sharedPreferencesService = SharedPreferencesService();
  static const String baseUrl = 'https://habitica.com/api/v3';
  static const String client = 'testing';
  String? _apiToken;
  String? _userID;

  HabiticaService();

  Future<GearModel> getEquippedBattleGear() async {
    Uri url = Uri.parse('$baseUrl/user');
    final response = await http.get(url, headers: await _getHeaders());
    if (response.statusCode == 401) {
      throw Exception('Unauthorized');
    }
    final responseJson = jsonDecode(response.body);
    final GearModel equippedGear =
        GearModel.fromMap(responseJson["data"]["items"]["gear"]["equipped"]);
    return equippedGear;
  }

  Future<Map<String, String>> _getHeaders() async {
    _apiToken ??= await _sharedPreferencesService.getApiToken();
    _userID ??= await _sharedPreferencesService.getUserID();
    return {
      "x-api-key": _apiToken as String,
      "x-api-user": _userID as String,
      "x-client": client,
    };
  }
}
