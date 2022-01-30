import 'package:habitica_assistant/models/gear_model.dart';

class HabiticaUserProfileModel {
  // Map<String, dynamic> auth;
  // Map<String, dynamic> flags;
  late _HabiticaUserProfileItemsModel items;
  late _HabiticaUserProfilePreferencesModel preferences;
  // Map<String, dynamic>[] notifications;

  HabiticaUserProfileModel.fromMap(Map<String, dynamic> map) {
    items = _HabiticaUserProfileItemsModel.fromMap(map["items"] ?? {});
    preferences = _HabiticaUserProfilePreferencesModel.fromMap(map["preferences"] ?? {});
  }
}

class _HabiticaUserProfileItemsModel {
  late _HabiticaUserProfileGearModel gear;

  _HabiticaUserProfileItemsModel.fromMap(Map<String, dynamic> map) {
    gear = _HabiticaUserProfileGearModel.fromMap(map["gear"] ?? {});
  }
}

class _HabiticaUserProfileGearModel {
  late GearModel equipped;
  late GearModel costume;
  late Iterable<String> owned;

  _HabiticaUserProfileGearModel.fromMap(Map<String, dynamic> map) {
    equipped = GearModel.fromMap(map["equipped"] ?? {});
    costume = GearModel.fromMap(map["costume"] ?? {});
    final allOwned = Map<String, bool>.from(map["owned"]);
    allOwned.removeWhere((key, value) => value == false);
    owned = allOwned.keys;
  }
}

class _HabiticaUserProfilePreferencesModel {
  // Map<String, dynamic> hair;
  // Map<String, bool> emailNotifications;
  // Map<String, bool> pushNotifications;
  // Map<String, bool> suppressModals;
  // Map<String, bool> tasks;
  // int dayStart;
  late String size;
  // bool hideHeader;
  late String skin;
  late String shirt;
  // int timezoneOffset;
  // String sound;
  late String chair;
  // String allocationMode;
  // bool autoEquip;
  // String dateFormat;
  // bool sleep;
  // bool stickyHeader;
  // bool disableClasses;
  // bool newTaskEdit;
  // bool dailyDueDefaultView;
  // bool advancedCollapsed;
  // bool toolbarCollapsed;
  // bool reverseChatOrder;
  // bool displayInviteToPartyWhenPartyIs1;
  // dynamic[] improvementCategories;
  // String language;
  // Object webhooks;
  late String background;
  // bool costume;
  // int timezoneOffsetAtLastCron;
  // bool automaticAllocation;

  _HabiticaUserProfilePreferencesModel.fromMap(Map<String, dynamic> map) {
    size = map["size"] ?? "";
    skin = map["skin"] ?? "";
    shirt = map["shirt"] ?? "";
    chair = map["chair"] ?? "";
    background = map["background"] ?? "";
  }
}
