import 'package:habitica_assistant/models/costume_model.dart';
import 'package:habitica_assistant/models/gear_model.dart';
import 'package:habitica_assistant/models/hair_model.dart';
import 'package:habitica_assistant/utils/habitica_base_gear.dart';
import 'package:habitica_assistant/utils/string_extensions.dart';

class HabiticaUserProfileModel {
  late _HabiticaUserProfileItemsModel items;
  late HabiticaUserProfilePreferencesModel preferences;

  HabiticaUserProfileModel.fromMap(Map<String, dynamic> map) {
    items = _HabiticaUserProfileItemsModel.fromMap(map['items'] ?? {});
    preferences = HabiticaUserProfilePreferencesModel.fromMap(map['preferences'] ?? {});
  }
}

class _HabiticaUserProfileItemsModel {
  late _HabiticaUserProfileGearModel gear;
  late Iterable<String> pets;
  late String currentPet;
  late Iterable<String> mounts;
  late String currentMount;

  _HabiticaUserProfileItemsModel.fromMap(Map<String, dynamic> map) {
    gear = _HabiticaUserProfileGearModel.fromMap(map['gear'] ?? {});
    final petsObj = Map<String, int>.from(map['pets']);
    petsObj.removeWhere((key, value) => value == -1);
    var petsList = petsObj.keys.toSet().toList();
    petsList.insert(0, '');
    pets = petsList;
    currentPet = map['currentPet'] ?? '';
    final mountsObj = Map<String, bool>.from(map['mounts']);
    mountsObj.removeWhere((key, value) => value == false);
    var mountsList = mountsObj.keys.toSet().toList();
    mountsList.insert(0, '');
    mounts = mountsList;
    currentMount = map['currentMount'] ?? '';
  }
}

class _HabiticaUserProfileGearModel {
  late GearModel equipped;
  late GearModel costume;
  late Iterable<String> owned;

  _HabiticaUserProfileGearModel.fromMap(Map<String, dynamic> map) {
    equipped = GearModel.fromMap(map['equipped'] ?? {});
    costume = GearModel.fromMap(map['costume'] ?? {});
    final allOwned = Map<String, bool>.from(map['owned']);
    allOwned.removeWhere((key, value) => value == false);
    final allOwnedKeys = allOwned.keys.toSet().toList();
    allOwnedKeys.insertAll(0, baseGear);
    owned = allOwnedKeys;
  }
}

class HabiticaUserProfilePreferencesModel {
  late HairModel hair;
  late String size;
  late String skin;
  late String shirt;
  late String chair;
  late String background;

  HabiticaUserProfilePreferencesModel.fromMap(Map<String, dynamic> map) {
    hair = HairModel.fromMap(map['hair'] ?? {});
    size = map['size'] ?? '';
    skin = map['skin'] ?? '';
    shirt = map['shirt'] ?? '';
    chair = map['chair'] ?? '';
    background = map['background'] ?? '';
  }

  HabiticaUserProfilePreferencesModel.fromCostume(CostumeModel costume) {
    hair = costume.hair ?? HairModel();
    size = costume.size ?? '';
    skin = costume.skin ?? '';
    shirt = costume.shirt ?? '';
    chair = costume.chair ?? '';
    background = costume.background ?? '';
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = {};
    if (hair.color.isNotNullOrEmpty()) {
      map['preferences.hair.color'] = hair.color;
    }
    if (hair.base.isNotNullOrEmpty()) {
      map['preferences.hair.base'] = hair.base;
    }
    if (hair.bangs.isNotNullOrEmpty()) {
      map['preferences.hair.bangs'] = hair.bangs;
    }
    if (hair.beard.isNotNullOrEmpty()) {
      map['preferences.hair.beard'] = hair.beard;
    }
    if (hair.mustache.isNotNullOrEmpty()) {
      map['preferences.hair.mustache'] = hair.mustache;
    }
    if (hair.accent.isNotNullOrEmpty()) {
      map['preferences.hair.flower'] = hair.accent;
    }
    if (size.isNotNullOrEmpty()) {
      map['preferences.size'] = size;
    }
    if (skin.isNotNullOrEmpty()) {
      map['preferences.skin'] = skin;
    }
    if (shirt.isNotNullOrEmpty()) {
      map['preferences.shirt'] = shirt;
    }
    if (chair.isNotNullOrEmpty()) {
      map['preferences.chair'] = chair;
    }
    if (background.isNotNullOrEmpty()) {
      map['preferences.background'] = background;
    }
    return map;
  }
}
