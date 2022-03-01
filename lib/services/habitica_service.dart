import 'dart:convert';

import 'package:habitica_assistant/models/battle_gear_model.dart';
import 'package:habitica_assistant/models/costume_model.dart';
import 'package:habitica_assistant/models/gear_full_model.dart';
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
    final equippedGear = await getEquippedBattleGear();
    await _equipEquipment(gear.armor, equippedGear.armor);
    await _equipEquipment(gear.head, equippedGear.head);
    await _equipEquipment(gear.shield, equippedGear.shield);
    await _equipEquipment(gear.weapon, equippedGear.weapon);
    await _equipEquipment(gear.eyewear, equippedGear.eyewear);
    await _equipEquipment(gear.headAccessory, equippedGear.headAccessory);
    await _equipEquipment(gear.body, equippedGear.body);
    await _equipEquipment(gear.back, equippedGear.back);
  }

  Future<GearFullModel> getEquippedCostume() async {
    final response = await getAuthenticatedUserProfile();
    final equippedCostume = GearFullModel.fromHabiticaUserProfile(response);
    return equippedCostume;
  }

  Future<void> setEquippedCostume(CostumeModel costume) async {
    final equippedCostume = await getEquippedCostume();
    await _equipCostume(costume.armor, equippedCostume.armor);
    await _equipCostume(costume.head, equippedCostume.head);
    await _equipCostume(costume.shield, equippedCostume.shield);
    await _equipCostume(costume.weapon, equippedCostume.weapon);
    await _equipCostume(costume.eyewear, equippedCostume.eyewear);
    await _equipCostume(costume.headAccessory, equippedCostume.headAccessory);
    await _equipCostume(costume.body, equippedCostume.body);
    await _equipCostume(costume.back, equippedCostume.back);
    await _equipPet(costume.pet, equippedCostume.pet);
    await _equipMount(costume.mount, equippedCostume.mount);
  }

  Future<void> _equipEquipment(String? itemToEquip, String? equippedItem) async {
    return _equipItem('equipped', itemToEquip, equippedItem);
  }

  Future<void> _equipCostume(String? itemToEquip, String? equippedItem) async {
    return _equipItem('costume', itemToEquip, equippedItem);
  }

  Future<void> _equipPet(String? petToEquip, String? equippedPet) async {
    return _equipItem('pet', petToEquip, equippedPet);
  }

  Future<void> _equipMount(String? mountToEquip, String? equippedMount) async {
    return _equipItem('mount', mountToEquip, equippedMount);
  }

  Future<void> _equipItem(String type, String? itemToEquip, String? equippedItem) async {
    if (itemToEquip == equippedItem ||
        ((itemToEquip == null || itemToEquip.isEmpty) &&
            (equippedItem == null || equippedItem.isEmpty))) {
      return;
    }
    String? key;
    if (baseGear.contains(itemToEquip) || (itemToEquip == null && equippedItem!.isNotEmpty)) {
      key = equippedItem;
    } else {
      key = itemToEquip;
    }
    if (key == null) {
      throw Exception('Failed to equip $itemToEquip item of type $type');
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
