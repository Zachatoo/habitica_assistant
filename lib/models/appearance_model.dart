import 'package:habitica_assistant/models/habitica_user_profile_model.dart';
import 'package:habitica_assistant/models/hair_model.dart';

import 'gear_model.dart';

class AppearanceModel extends GearModel {
  String? pet;
  String? mount;
  late HairModel hair;
  late String size;
  late String skin;
  late String shirt;
  late String chair;
  late String background;

  AppearanceModel({
    this.pet,
    this.mount,
    required this.hair,
    required this.size,
    required this.skin,
    required this.shirt,
    required this.chair,
    required this.background,
  });

  AppearanceModel.fromHabiticaUserProfile(HabiticaUserProfileModel model) {
    final items = model.items;
    final gear = items.gear.costume;
    final preferences = model.preferences;
    armor = gear.armor;
    head = gear.head;
    shield = gear.shield;
    weapon = gear.weapon;
    eyewear = gear.eyewear;
    headAccessory = gear.headAccessory;
    body = gear.body;
    back = gear.back;
    pet = items.currentPet;
    mount = items.currentMount;
    hair = preferences.hair;
    size = preferences.size;
    skin = preferences.skin;
    shirt = preferences.shirt;
    chair = preferences.chair;
    background = preferences.background;
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'armor': armor,
      'head': head,
      'shield': shield,
      'weapon': weapon,
      'eyewear': eyewear,
      'headAccessory': headAccessory,
      'body': body,
      'back': back,
      'pet': pet,
      'mount': mount,
      'hair': hair,
      'size': size,
      'skin': skin,
      'shirt': shirt,
      'chair': chair,
      'background': background,
    };
  }

  AppearanceModel.fromMap(Map<String, dynamic> map) {
    armor = map["armor"];
    head = map["head"];
    shield = map["shield"];
    weapon = map["weapon"];
    eyewear = map["eyewear"];
    headAccessory = map["headAccessory"];
    body = map["body"];
    back = map["back"];
    pet = map["pet"];
    mount = map["mount"];
    size = map["size"];
    skin = map["skin"];
    shirt = map["shirt"];
    chair = map["chair"];
    background = map["background"];
  }

  @override
  String toString() {
    return '''GearFull{
      armor: $armor,
      head: $head,
      shield: $shield,
      weapon: $weapon,
      eyewear: $eyewear,
      headAccessory: $headAccessory,
      body: $body,
      back: $back,
      pet: $pet,
      mount: $mount,
      size: $size,
      skin: $skin,
      shirt: $shirt,
      chair: $chair,
      background: $background,
    }''';
  }
}
