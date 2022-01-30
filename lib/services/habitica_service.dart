import 'dart:convert';

import 'package:habitica_assistant/models/battle_gear_model.dart';
import 'package:habitica_assistant/models/gear_model.dart';
import 'package:habitica_assistant/models/habitica_user_profile_model.dart';
import 'package:habitica_assistant/models/parsed_response_model.dart';
import 'package:habitica_assistant/services/shared_preferences_service.dart';
import 'package:http/http.dart' as http;

class HabiticaService {
  final SharedPreferencesService _sharedPreferencesService = SharedPreferencesService();
  static const String baseUrl = 'https://habitica.com/api/v3';
  static const String client = 'testing';
  String? _apiToken;
  String? _userID;

  HabiticaService();

  Future<HabiticaUserProfileModel> getAuthenticatedUserProfile() async {
    Uri url = Uri.parse('$baseUrl/user');
    final response =
        ParsedResponseModel<String>.fromResponse(await http.get(url, headers: await _getHeaders()));
    final responseJson = jsonDecode(response.body);
    if (!response.isOk()) {
      if (response.isUnauthorized()) {
        throw Exception('Unauthorized');
      }
      throw Exception(responseJson["error"]);
    }
    final HabiticaUserProfileModel profile = HabiticaUserProfileModel.fromMap(responseJson["data"]);
    return profile;
  }

  Future<GearModel> getEquippedBattleGear() async {
    final response = await getAuthenticatedUserProfile();
    final GearModel equippedGear = response.items.gear.equipped;
    return equippedGear;
  }

  Future<void> setEquippedBattleGear(BattleGearModel gear) async {
    const String type = 'equipped';
    final equippedGear = await getEquippedBattleGear();
    if (equippedGear.armor != gear.armor) {
      await _equipItem(type, gear.armor ?? '');
    }
    if (equippedGear.head != gear.head) {
      await _equipItem(type, gear.head ?? '');
    }
    if (equippedGear.shield != gear.shield) {
      await _equipItem(type, gear.shield ?? '');
    }
    if (equippedGear.weapon != gear.weapon) {
      await _equipItem(type, gear.weapon ?? '');
    }
    if (equippedGear.eyewear != gear.eyewear) {
      await _equipItem(type, gear.eyewear ?? '');
    }
    if (equippedGear.headAccessory != gear.headAccessory) {
      await _equipItem(type, gear.headAccessory ?? '');
    }
    if (equippedGear.body != gear.body) {
      await _equipItem(type, gear.body ?? '');
    }
    if (equippedGear.back != gear.back) {
      await _equipItem(type, gear.back ?? '');
    }
  }

  Future<void> _equipItem(String type, String key) async {
    Uri url = Uri.parse('$baseUrl/user/equip/$type/$key');
    final response = ParsedResponseModel<String>.fromResponse(
        await http.post(url, headers: await _getHeaders()));
    final responseJson = jsonDecode(response.body);
    if (!response.isOk()) {
      if (response.isUnauthorized()) {
        throw Exception('Unauthorized');
      }
      throw Exception(responseJson["error"]);
    }
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
