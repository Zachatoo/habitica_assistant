import 'dart:convert';

import 'package:habitica_assistant/models/battle_gear_model.dart';
import 'package:habitica_assistant/models/costume_model.dart';
import 'package:habitica_assistant/models/gear_model.dart';
import 'package:habitica_assistant/models/habitica_user_profile_model.dart';
import 'package:habitica_assistant/models/parsed_response_model.dart';
import 'package:habitica_assistant/services/shared_preferences_service.dart';
import 'package:habitica_assistant/utils/habitica_base_gear.dart';
import 'package:http/http.dart' as http;

class HabiticaService {
  final SharedPreferencesService _sharedPreferencesService = SharedPreferencesService();
  static const String baseUrl = 'https://habitica.com/api/v3';
  static const String client = '67d1d9e3-57cc-4d7c-ab00-b09b63780a78-HabiticaAssistant';
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
      await _equipItem(type, gear.armor, equippedGear.armor);
    }
    if (equippedGear.head != gear.head) {
      await _equipItem(type, gear.head, equippedGear.head);
    }
    if (equippedGear.shield != gear.shield) {
      await _equipItem(type, gear.shield, equippedGear.shield);
    }
    if (equippedGear.weapon != gear.weapon) {
      await _equipItem(type, gear.weapon, equippedGear.weapon);
    }
    if (equippedGear.eyewear != gear.eyewear) {
      await _equipItem(type, gear.eyewear, equippedGear.eyewear);
    }
    if (equippedGear.headAccessory != gear.headAccessory) {
      await _equipItem(type, gear.headAccessory, equippedGear.headAccessory);
    }
    if (equippedGear.body != gear.body) {
      await _equipItem(type, gear.body, equippedGear.body);
    }
    if (equippedGear.back != gear.back) {
      await _equipItem(type, gear.back, equippedGear.back);
    }
  }

  Future<GearModel> getEquippedCostume() async {
    final response = await getAuthenticatedUserProfile();
    final GearModel equippedCostume = response.items.gear.costume;
    return equippedCostume;
  }

  Future<void> setEquippedCostume(CostumeModel gear) async {
    const String type = 'costume';
    final equippedGear = await getEquippedCostume();
    if (equippedGear.armor != gear.armor) {
      await _equipItem(type, gear.armor, equippedGear.armor);
    }
    if (equippedGear.head != gear.head) {
      await _equipItem(type, gear.head, equippedGear.head);
    }
    if (equippedGear.shield != gear.shield) {
      await _equipItem(type, gear.shield, equippedGear.shield);
    }
    if (equippedGear.weapon != gear.weapon) {
      await _equipItem(type, gear.weapon, equippedGear.weapon);
    }
    if (equippedGear.eyewear != gear.eyewear) {
      await _equipItem(type, gear.eyewear, equippedGear.eyewear);
    }
    if (equippedGear.headAccessory != gear.headAccessory) {
      await _equipItem(type, gear.headAccessory, equippedGear.headAccessory);
    }
    if (equippedGear.body != gear.body) {
      await _equipItem(type, gear.body, equippedGear.body);
    }
    if (equippedGear.back != gear.back) {
      await _equipItem(type, gear.back, equippedGear.back);
    }
  }

  Future<void> _equipItem(String type, String? itemToEquip, String? equippedItem) async {
    String? key;
    if (baseGear.contains(itemToEquip)) {
      key = equippedItem;
    } else {
      key = itemToEquip;
    }
    if (key == null) {
      throw Exception('Failed to equip null item');
    }
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
